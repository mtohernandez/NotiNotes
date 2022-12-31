import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:material_tag_editor/tag_editor.dart';

import '../../widgets/items/tag_item.dart';
import '../../widgets/items/icon_button_x_item.dart';

import '../../providers/notes.dart';

class TagCreatorManager extends StatefulWidget {
  final String id;
  const TagCreatorManager(this.id, {super.key});

  @override
  State<TagCreatorManager> createState() => _TagCreatorManagerState();
}

class _TagCreatorManagerState extends State<TagCreatorManager> {
  final List<String> _values = [];
  final FocusNode _focusNode = FocusNode();
  final TextEditingController _textEditingController = TextEditingController();

  @override
  void initState() {
    _values.addAll(
        Provider.of<Notes>(context, listen: false).findById(widget.id).tags);
    super.initState();
  }

  void _onDelete(index) {
    setState(() {
      _values.removeAt(index);
      Provider.of<Notes>(context, listen: false)
          .removeTagsFromNote(index, widget.id);
    });
  }

  void exitCreator() {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final notes = Provider.of<Notes>(context, listen: false);
    return Container(
        padding: EdgeInsets.only(
            left: 30,
            right: 30,
            top: 20,
            bottom: MediaQuery.of(context).viewInsets.bottom),
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
                  'Add tags',
                  style: Theme.of(context).textTheme.headline1,
                ),
                IconButtonXItem(exitCreator),
              ],
            ),
            Text(
              'Press \'Space\' to create the tag.',
              style: Theme.of(context).textTheme.bodyText1!.copyWith(
                    // Using copyWith to change the opacity of the text
                    color: Theme.of(context)
                        .textTheme
                        .bodyText1!
                        .color!
                        .withOpacity(.5),
                  ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              height: MediaQuery.of(context).size.height * .2,
              child: ListView(
                children: [
                  TagEditor(
                    length: _values.length,
                    controller: _textEditingController,
                    focusNode: _focusNode,
                    delimiters: [',', ' '],
                    hasAddButton: false,
                    resetTextOnSubmitted: true,
                    // This is set to grey just to illustrate the `textStyle` prop
                    textStyle: const TextStyle(color: Colors.grey),
                    onSubmitted: (outstandingValue) {
                      setState(() {
                        _values.add(outstandingValue);
                      });
                    },
                    inputDecoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Add a tag...',
                      hintStyle:
                          Theme.of(context).textTheme.bodyText1!.copyWith(
                                // Using copyWith to change the opacity of the text
                                color: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .color!
                                    .withOpacity(.5),
                              ),
                    ),
                    onTagChanged: (newValue) {
                      setState(() {
                        _values.add(newValue);
                        notes.addTagToNote(newValue, widget.id);
                      });
                    },
                    tagBuilder: (context, index) => TagItem(
                      _onDelete,
                      index,
                      tag: _values[index],
                      isForSearch: false,
                      isForCreation: true,
                      backgroundColor: Theme.of(context).backgroundColor,
                    ),
                    // InputFormatters example, this disallow \ and /
                    inputFormatters: [
                      FilteringTextInputFormatter.deny(RegExp(r'[/\\]'))
                    ],
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
