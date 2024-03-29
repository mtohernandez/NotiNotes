import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:noti_notes_app/widgets/items/todo_item.dart';
import 'package:provider/provider.dart';

import '../../providers/notes.dart';

class TodoListTool extends StatefulWidget {
  final String id;
  const TodoListTool(this.id, {super.key});

  @override
  State<TodoListTool> createState() => _TodoListToolState();
}

class _TodoListToolState extends State<TodoListTool> {
  final FocusScopeNode _focusScopeNode = FocusScopeNode();

  @override
  void dispose() {
    _focusScopeNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Consumer<Notes>(
              builder: (context, notes, child) {
                return SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FocusScope(
                        node: _focusScopeNode,
                        child: ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: notes.findById(widget.id).todoList.length,
                          // itemCount: todoList.length,
                          itemBuilder: ((context, index) {
                            return TodoItem(
                              isForNote: false,
                              id: widget.id,
                              notesProvider: notes,
                              indexTask: index,
                              fullLength:
                                  notes.findById(widget.id).todoList.length,
                              title: notes.findById(widget.id).todoList[index]
                                  ['content'],
                              isChecked: notes
                                  .findById(widget.id)
                                  .todoList[index]['isChecked'],
                              focusScopeNode: _focusScopeNode,
                            );
                          }),
                        ),
                      ),
                      const SizedBox(height: 10),
                      TextButton.icon(
                        style: ButtonStyle(
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          padding: MaterialStateProperty.all(
                            const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 10,
                            ),
                          ),
                        ),
                        onPressed: () {
                          notes.addTask(widget.id);
                        },
                        icon: SvgPicture.asset(
                          'lib/assets/icons/plus.svg',
                          height:
                              Theme.of(context).textTheme.bodyText1!.fontSize,
                          color: Theme.of(context).primaryColor.withOpacity(.5),
                        ),
                        label: Text(
                          'Add a task',
                          style:
                              Theme.of(context).textTheme.bodyText1!.copyWith(
                                    color: Theme.of(context)
                                        .textTheme
                                        .bodyText1!
                                        .color!
                                        .withOpacity(0.5),
                                  ),
                        ),
                      ),
                      const SizedBox(height: 100),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
