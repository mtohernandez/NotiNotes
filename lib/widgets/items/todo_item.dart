import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../providers/notes.dart';

class TodoItem extends StatefulWidget {
  final Notes notesProvider;
  final String id;
  final int indexTask;
  final int fullLength;
  final String title;
  final bool isChecked;
  final FocusScopeNode? focusScopeNode;
  final bool isForNote;
  const TodoItem({
    required this.id,
    required this.notesProvider,
    required this.indexTask,
    required this.fullLength,
    required this.title,
    required this.isChecked,
    required this.focusScopeNode,
    required this.isForNote,
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
      descendantsAreFocusable: true, // I dont really know what this does
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
      if (widget.focusScopeNode != null) {
        widget.focusScopeNode!.requestFocus(textNode);
      }
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
    final colorTodo = widget.isForNote
        ? widget.notesProvider.findById(widget.id).fontColor
        : Theme.of(context).primaryColor;

    final heightContainer = widget.isForNote
        ? Theme.of(context).textTheme.bodyText1!.fontSize! * 2.0
        : Theme.of(context).textTheme.bodyText1!.fontSize! * 2.5;

    return Container(
      width: double.infinity,
      height: heightContainer,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        // contentPadding: EdgeInsets.zero,
        children: [
          IconButton(
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(
              minWidth: 24,
              minHeight: 24,
            ),
            onPressed: () {
              widget.notesProvider.toggleTask(widget.id, widget.indexTask);
            },
            icon: !widget.isChecked
                ? SvgPicture.asset(
                    'lib/assets/icons/checkUnchecked.svg',
                    color: colorTodo,
                  )
                : SvgPicture.asset(
                    'lib/assets/icons/checkChecked.svg',
                    color: colorTodo,
                  ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: RawKeyboardListener(
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

                enabled: !widget.isForNote,
                controller: textController,
                focusNode: textNode,
                textInputAction: TextInputAction.next,
                // focusNode: textNode,
                style: !widget.isChecked
                    ? Theme.of(context).textTheme.bodyText1!.copyWith(
                          color: colorTodo,
                        )
                    : Theme.of(context).textTheme.bodyText1!.copyWith(
                          color: colorTodo,
                          decoration: TextDecoration.lineThrough,
                        ),
                decoration: InputDecoration(
                  isDense: true, // WHAT
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
          ),
        ],
      ),
    );
  }
}
