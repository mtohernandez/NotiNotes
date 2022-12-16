import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

import '../widgets/tag_item.dart';
import '../models/note.dart';
import '../providers/notes.dart';

class NotesCreationScreen extends StatefulWidget {
  static const routeName = '/note-creation';
  NotesCreationScreen({super.key});

  @override
  State<NotesCreationScreen> createState() => _NotesCreationScreenState();
}

class _NotesCreationScreenState extends State<NotesCreationScreen> {
  final _titleFocusNode = FocusNode();
  final _contentFocusNode = FocusNode();
  final _tagController = TextEditingController();

  var _creatingNote = Note(
    {},
    '',
    id: const Uuid().v1(), // Creates a random id
    title: '',
    content: '',
    dateCreated: DateTime.now(),
  );

  @override
  void dispose() {
    _titleFocusNode.dispose();
    _contentFocusNode.dispose();
    super.dispose();
  }

  Set<String> allTags = {};

  void addNote() {
    Provider.of<Notes>(context, listen: false).addNote(_creatingNote);
  }

  @override
  Widget build(BuildContext context) {
    final tagsSize = Theme.of(context).textTheme.bodyText1!.fontSize! * 2.7;

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 50.0),
          child: Form(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Creating Note',
                  style: Theme.of(context).textTheme.headline1,
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  decoration: InputDecoration(
                    hintText: 'Title',
                    hintStyle: Theme.of(context).textTheme.headline2,
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.zero,
                  ),
                  style: Theme.of(context).textTheme.headline2,
                  textInputAction: TextInputAction.next,
                  focusNode: _titleFocusNode,
                  onFieldSubmitted: (_) {
                    // Change focus to content
                    FocusScope.of(context).requestFocus(_contentFocusNode);
                  },
                  onChanged: (value) {
                    _creatingNote = Note(
                      _creatingNote.tags,
                      _creatingNote.imageUrl,
                      id: _creatingNote.id,
                      title: value,
                      content: _creatingNote.content,
                      dateCreated: _creatingNote.dateCreated,
                    );
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(
                    hintText: 'Content',
                    hintStyle: Theme.of(context).textTheme.bodyText1,
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.zero,
                  ),
                  style: Theme.of(context).textTheme.bodyText1,
                  focusNode: _contentFocusNode,
                  onChanged: (value) {
                    _creatingNote = Note(
                      _creatingNote.tags,
                      _creatingNote.imageUrl,
                      id: _creatingNote.id,
                      title: _creatingNote.title,
                      content: value,
                      dateCreated: _creatingNote.dateCreated,
                    );
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  'Add your tags',
                  style: TextStyle(
                    color: Theme.of(context)
                        .textTheme
                        .bodyText1!
                        .color!
                        .withOpacity(.5),
                    fontSize: Theme.of(context).textTheme.bodyText1!.fontSize,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  padding: const EdgeInsets.only(left: 10),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Theme.of(context).primaryColor.withOpacity(.5),
                    ),
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Row(
                    children: [
                      Flexible(
                        fit: FlexFit.tight,
                        child: SizedBox(
                          height:
                              Theme.of(context).textTheme.bodyText1!.fontSize! *
                                  2,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) => GestureDetector(
                              onDoubleTap: () {
                                setState(
                                  () {
                                    allTags.remove(
                                      allTags.elementAt(index).toString(),
                                    );
                                  },
                                );
                              },
                              child: TagItem(
                                tag: allTags.elementAt(index),
                              ),
                            ),
                            itemCount: allTags.length,
                          ),
                        ),
                      ),
                      IconButton(
                        padding: EdgeInsets.zero,
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              backgroundColor:
                                  Theme.of(context).backgroundColor,
                              title: Text(
                                'Add a tag',
                                style: Theme.of(context).textTheme.headline1,
                              ),
                              content: TextField(
                                autofocus: true,
                                decoration: InputDecoration(
                                  hintText: 'Tag',
                                  hintStyle: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .copyWith(
                                        // Using copyWith to change the opacity of the text
                                        color: Theme.of(context)
                                            .textTheme
                                            .bodyText1!
                                            .color!
                                            .withOpacity(.5),
                                      ),
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.zero,
                                ),
                                style: Theme.of(context).textTheme.bodyText1,
                                controller: _tagController,
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text(
                                    'Cancel',
                                    style:
                                        Theme.of(context).textTheme.bodyText1,
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {
                                    setState(() {
                                      allTags.add(_tagController.text);
                                      _tagController.clear();
                                    });
                                    Navigator.of(context).pop();
                                  },
                                  child: Text(
                                    'Add',
                                    style:
                                        Theme.of(context).textTheme.bodyText1,
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                        icon: SvgPicture.asset(
                          'lib/assets/icons/plus.svg',
                          color: Theme.of(context).primaryColor.withOpacity(.5),
                          height: tagsSize,
                          width: tagsSize,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextButton(
                  onPressed: () {},
                  style: ButtonStyle(
                    padding: MaterialStateProperty.all(
                      EdgeInsets.zero,
                    ),
                  ),
                  child: Text(
                    'Add Photo',
                    style: TextStyle(
                      color: Theme.of(context).textTheme.bodyText1!.color,
                      fontSize: Theme.of(context).textTheme.bodyText1!.fontSize,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Expanded(
                      child: MaterialButton(
                        onPressed: () {
                          _creatingNote = Note(
                            allTags,
                            _creatingNote.imageUrl,
                            id: _creatingNote.id,
                            title: _creatingNote.title,
                            content: _creatingNote.content,
                            dateCreated: _creatingNote.dateCreated,
                          );
                          addNote();
                          Navigator.of(context).pop();
                        },
                        color: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: Text(
                          'Create Note',
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: MaterialButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        color: Colors.black.withOpacity(.2),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: Text(
                          'Cancel',
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
