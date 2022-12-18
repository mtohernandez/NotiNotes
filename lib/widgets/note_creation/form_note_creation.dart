import 'package:flutter/material.dart';
import 'package:noti_notes_app/widgets/note_creation/tag_creator.dart';
import 'package:uuid/uuid.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'dart:io';
import 'package:flutter_image_compress/flutter_image_compress.dart';

import '../../models/note.dart';
import '../../providers/notes.dart';

class FormNoteCreation extends StatefulWidget {
  final File? image;
  final Function openMediaPicker;
  final Function removeImage;
  const FormNoteCreation(this.openMediaPicker, this.image, this.removeImage,
      {super.key});

  @override
  State<FormNoteCreation> createState() => _FormNoteCreationState();
}

class _FormNoteCreationState extends State<FormNoteCreation> {
  final _titleFocusNode = FocusNode();
  final _contentFocusNode = FocusNode();

  @override
  void dispose() {
    _titleFocusNode.dispose();
    _contentFocusNode.dispose();
    super.dispose();
  }

  // Image Compression NO IDEA HOW TO DO THIS
  Future<File?> compressAndGetFile(File? file) async {
    final result = await FlutterImageCompress.compressAndGetFile(
      file!.absolute.path,
      file.path,
      quality: 50,
    );

    return result;
  }

  // Color Picker

  Color? colorSelected;

  final List<Color> allColors = [
    const Color(0xff9638CD),
    const Color(0xff5B5DD7),
    const Color(0xff48BFE3),
    const Color(0xff72EFDD),
    const Color(0xffF9C100),
    const Color(0xffEF233C),
  ];

  // Tags Manager

  Set<String> allTags = {};

  void addTag(TextEditingController tag) {
    setState(() {
      allTags.add(tag.text);
      tag.clear();
    });
    Navigator.of(context).pop();
  }

  void removeTag(int index) {
    setState(
      () {
        allTags.remove(
          allTags.elementAt(index).toString(),
        );
      },
    );
  }

  // Note Creation

  var _creatingNote = Note(
    {},
    null, // Image is null in case not loaded or not picked
    id: const Uuid().v1(), // Creates a random id
    title: '',
    content: '',
    dateCreated: DateTime.now(),
    colorBackground: Colors.black, // Default color
  );

  void addNote() {
    Provider.of<Notes>(context, listen: false).addNote(_creatingNote);
  }

  @override
  Widget build(BuildContext context) {
    final colorSize = MediaQuery.of(context).size.height * 0.07;

    const space10 = SizedBox(
      height: 10,
    );

    const space20 = SizedBox(
      height: 20,
    );

    return Form(
      child: Center(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Creating Note',
                style: Theme.of(context).textTheme.headline1,
              ),
              SizedBox(
                height: Theme.of(context).textTheme.headline1!.fontSize! / 5,
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
                    _creatingNote.imageFile,
                    id: _creatingNote.id,
                    title: value,
                    content: _creatingNote.content,
                    dateCreated: _creatingNote.dateCreated,
                    colorBackground: _creatingNote.colorBackground,
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
                    _creatingNote.imageFile,
                    id: _creatingNote.id,
                    title: _creatingNote.title,
                    content: value,
                    dateCreated: _creatingNote.dateCreated,
                    colorBackground: _creatingNote.colorBackground,
                  );
                },
              ),
              space20,
              Text(
                'Add your tags (double tap on one to delete)',
                style: TextStyle(
                  color: Theme.of(context)
                      .textTheme
                      .bodyText1!
                      .color!
                      .withOpacity(.5),
                  fontSize: Theme.of(context).textTheme.bodyText1!.fontSize,
                ),
              ),
              space10,
              TagCreator(
                removeTag,
                addTag,
                allTags: allTags,
              ),
              space10,
              TextButton(
                onPressed: () {
                  widget.openMediaPicker(context);
                },
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
              widget.image == null
                  ? Text(
                      '(No image Selected)',
                      style: TextStyle(
                        color: Theme.of(context)
                            .textTheme
                            .bodyText1!
                            .color!
                            .withOpacity(.5),
                      ),
                    )
                  : Stack(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 0.5,
                          height: MediaQuery.of(context).size.height * 0.1,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            image: DecorationImage(
                              image: FileImage(widget.image!),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Positioned(
                          right: -3,
                          top: 1,
                          child: TextButton(
                            onPressed: () {
                              widget.removeImage();
                            },
                            style: ButtonStyle(
                              shape: MaterialStateProperty.all(
                                const CircleBorder(),
                              ),
                              backgroundColor: MaterialStateProperty.all(
                                Theme.of(context).backgroundColor.withOpacity(
                                      .5,
                                    ),
                              ),
                            ),
                            child: SvgPicture.asset(
                              'lib/assets/icons/x.svg',
                              color: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .color!
                                  .withOpacity(
                                    .5,
                                  ),
                            ),
                          ),
                        )
                      ],
                    ),
              space20,
              SizedBox(
                height: colorSize,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: allColors.length,
                  itemBuilder: (context, index) {
                    return OutlinedButton(
                      onPressed: () {
                        setState(() {
                          colorSelected = allColors[index];
                        });
                      },
                      style: ButtonStyle(
                        padding: MaterialStateProperty.all(EdgeInsets.zero),
                        shape: MaterialStateProperty.all(
                          const CircleBorder(),
                        ),
                        side: MaterialStateProperty.all(
                          BorderSide(
                            color: allColors[index] == colorSelected
                                ? Theme.of(context).primaryColor
                                : Theme.of(context).backgroundColor,
                            width: allColors[index] == colorSelected ? 2.0 : 0,
                            style: BorderStyle.solid,
                          ),
                        ),
                      ),
                      child: Container(
                        width: colorSize,
                        height: colorSize,
                        decoration: BoxDecoration(
                          color: allColors[index],
                          shape: BoxShape.circle,
                        ),
                      ),
                    );
                  },
                ),
              ),
              space20,
              Row(
                children: [
                  Expanded(
                    child: MaterialButton(
                      onPressed: () {
                        _creatingNote = Note(
                          allTags,
                          widget.image ?? _creatingNote.imageFile,
                          id: _creatingNote.id,
                          title: _creatingNote.title,
                          content: _creatingNote.content,
                          dateCreated: _creatingNote.dateCreated,
                          colorBackground:
                              colorSelected ?? _creatingNote.colorBackground,
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
    );
  }
}
