import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:noti_notes_app/widgets/items/icon_button_x_item.dart';
import 'package:provider/provider.dart';

import '../items/tag_item.dart';
import '../../providers/notes.dart';

class TagCreator extends StatelessWidget {
  final String noteId;
  TagCreator(this.noteId, {super.key});

  final _tagController = TextEditingController();

  void _showTagCreator(
      BuildContext context, Notes notes, Function exitCreator) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
        ),
        backgroundColor: Theme.of(context).backgroundColor,
        title: Text(
          'Add a tag',
          style: Theme.of(context).textTheme.headline1,
        ),
        content: TextField(
          autofocus: true,
          decoration: InputDecoration(
            hintText: 'Tag',
            hintStyle: Theme.of(context).textTheme.bodyText1!.copyWith(
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
          onSubmitted: (value) {
            notes.addTagToNote(_tagController.text, noteId);
            _tagController.clear();
            exitCreator();
          },
        ),
        actions: [
          TextButton(
            style: const ButtonStyle(
              overlayColor: MaterialStatePropertyAll(
                Colors.transparent,
              ),
            ),
            onPressed: () {
              exitCreator();
            },
            child: Text(
              'Cancel',
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ),
          TextButton(
            style: const ButtonStyle(
              overlayColor: MaterialStatePropertyAll(
                Colors.transparent,
              ),
            ),
            onPressed: () {
              notes.addTagToNote(_tagController.text, noteId);
              _tagController.clear();
              exitCreator();
            },
            child: Text(
              'Add',
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final notes = Provider.of<Notes>(context);
    final tagsSize = Theme.of(context).textTheme.bodyText1!.fontSize! * 1.5;
    final exitCreator = Navigator.of(context).pop;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Theme.of(context).backgroundColor,
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(50), topRight: Radius.circular(50)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Add your tags (double tap on one to remove)',
                style: Theme.of(context).textTheme.bodyText1!.copyWith(
                      // Using copyWith to change the opacity of the text
                      color: Theme.of(context)
                          .textTheme
                          .bodyText1!
                          .color!
                          .withOpacity(.5),
                    ),
              ),
              IconButtonXItem(exitCreator),
            ],
          ),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.only(left: 10),
            decoration: BoxDecoration(
              border: Border.all(
                color: Theme.of(context).primaryColor.withOpacity(.5),
              ),
              borderRadius: BorderRadius.circular(50),
            ),
            child: GestureDetector(
              onTap: () {
                _showTagCreator(context, notes, exitCreator);
              },
              child: Row(
                children: [
                  Flexible(
                    fit: FlexFit.tight,
                    child: SizedBox(
                      height:
                          Theme.of(context).textTheme.bodyText1!.fontSize! * 2,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) => GestureDetector(
                          onDoubleTap: () {
                            notes.removeTagsFromNote(index, noteId);
                          },
                          child: TagItem(
                            tag: notes.findById(noteId).tags.elementAt(index),
                            isForSearch: false,
                          ),
                        ),
                        itemCount: notes.findById(noteId).tags.length,
                      ),
                    ),
                  ),
                  IconButton(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    padding: EdgeInsets.zero,
                    onPressed: () {
                      _showTagCreator(context, notes, exitCreator);
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
          ),
        ],
      ),
    );
  }
}
