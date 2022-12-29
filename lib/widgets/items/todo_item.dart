import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../providers/notes.dart';

class TodoItem extends StatelessWidget {
  final Notes notesProvider;
  final String id;
  final int indexTask;
  final String title;
  final bool isChecked;
  TodoItem({
    required this.id,
    required this.notesProvider,
    required this.indexTask,
    required this.title,
    required this.isChecked,
    super.key,
  });

  // final keyBoardNode = FocusNode();
  // final textNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    final textController = TextEditingController.fromValue(
      TextEditingValue(
        text: title,
        selection: TextSelection.collapsed(offset: title.length),
      ),
    );

    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: IconButton(
        style: ButtonStyle(
            padding: MaterialStateProperty.all(EdgeInsets.zero),
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            minimumSize: MaterialStateProperty.all(const Size(30, 0))),
        onPressed: () {
          notesProvider.toggleTask(id, indexTask);
        },
        icon: !isChecked
            ? Icon(
                Icons.check_box_outline_blank,
                color: Theme.of(context).primaryColor,
              )
            : Icon(
                Icons.check_box,
                color: Theme.of(context).primaryColor,
              ),
      ),
      title: RawKeyboardListener(
        onKey: (value) {
          if (textController.text.isEmpty &&
              (value.logicalKey == LogicalKeyboardKey.backspace ||
                  value.logicalKey == LogicalKeyboardKey.delete)) {
            notesProvider.removeTask(id, indexTask);
            FocusScope.of(context).unfocus();
            // FocusScope.of(context).requestFocus(keyBoardNode.ancestors.last);
          }
        },
        focusNode: FocusNode(),
        child: TextFormField(
          // initialValue: title,
          controller: textController,
          // focusNode: textNode,
          style: !isChecked
              ? Theme.of(context).textTheme.bodyText1
              : Theme.of(context).textTheme.bodyText1!.copyWith(
                    decoration: TextDecoration.lineThrough,
                  ),
          decoration: InputDecoration(
            contentPadding: EdgeInsets.zero,
            border: InputBorder.none,
            hintText: 'Add content...',
            hintStyle: Theme.of(context).textTheme.bodyText1!.copyWith(
                  color: Theme.of(context)
                      .textTheme
                      .bodyText1!
                      .color!
                      .withOpacity(0.5),
                ),
          ),
          onChanged: (value) => notesProvider.updateTask(id, indexTask, value),
        ),
      ),
    );
  }
}
