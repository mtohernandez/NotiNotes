import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../providers/notes.dart';

class TodoItem extends StatefulWidget {
  final Notes notesProvider;
  final String id;
  final int indexTask;
  final int fullLength;
  final String title;
  final bool isChecked;
  final FocusScopeNode focusScopeNode;
  const TodoItem({
    required this.id,
    required this.notesProvider,
    required this.indexTask,
    required this.fullLength,
    required this.title,
    required this.isChecked,
    required this.focusScopeNode,
    super.key,
  });

  @override
  State<TodoItem> createState() => _TodoItemState();
}

class _TodoItemState extends State<TodoItem> {
  late final TextEditingController textController;
  late final FocusNode textNode;
  late final FocusNode keyBoardNode;

  @override
  void initState() {
    textNode = FocusNode(
      descendantsAreFocusable: true,
    );
    keyBoardNode = FocusNode();
    textController = TextEditingController.fromValue(
      TextEditingValue(
        text: widget.title,
        selection: TextSelection.collapsed(offset: widget.title.length),
      ),
    );
    if (widget.indexTask == widget.fullLength - 1 &&
        textController.text.isEmpty) {
      widget.focusScopeNode.requestFocus(textNode);
    }
    super.initState();
  }

  @override
  void dispose() {
    textController.dispose();
    textNode.dispose();
    keyBoardNode.dispose();
    super.dispose();
  }

  // final keyBoardNode = FocusNode();
  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: IconButton(
        style: ButtonStyle(
            padding: MaterialStateProperty.all(EdgeInsets.zero),
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            minimumSize: MaterialStateProperty.all(const Size(30, 0))),
        onPressed: () {
          widget.notesProvider.toggleTask(widget.id, widget.indexTask);
        },
        icon: !widget.isChecked
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
        focusNode: keyBoardNode,
        onKey: (event) {
          if (event.isKeyPressed(LogicalKeyboardKey.backspace) &&
              textController.text.isEmpty) {
            // widget.focusScopeNode.requestFocus(textNode.ancestors.first);
            widget.notesProvider.removeTask(widget.id, widget.indexTask);
            // keyBoardNode.unfocus();
            FocusScope.of(context).unfocus();
          }
        },
        child: TextFormField(
          // initialValue: title,
          // autofocus: true,
          controller: textController,
          focusNode: textNode,
          textInputAction: TextInputAction.next,
          // focusNode: textNode,
          style: !widget.isChecked
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
          onChanged: (value) => widget.notesProvider
              .updateTask(widget.id, widget.indexTask, value),
          onFieldSubmitted: (value) {
            if (widget.indexTask == widget.fullLength - 1) {
              widget.notesProvider.addTask(widget.id);
              // widget.focusScopeNode.nextFocus();
            }
          },
        ),
      ),
    );
  }
}
