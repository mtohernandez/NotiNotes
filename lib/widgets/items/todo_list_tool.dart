import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:noti_notes_app/widgets/items/todo_item.dart';
import 'package:provider/provider.dart';

import '../../providers/notes.dart';

class TodoListTool extends StatelessWidget {
  final String id;
  TodoListTool(this.id, {super.key});

  @override
  Widget build(BuildContext context) {
    final notes = Provider.of<Notes>(context, listen: false);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            maxLength: 25,
            initialValue: 'To do:',
            style: Theme.of(context).textTheme.headline2,
            decoration: InputDecoration(
              counter: const SizedBox
                  .shrink(), // This is a good way to remove the counter
              contentPadding: EdgeInsets.zero,
              border: InputBorder.none,
              hintText: 'Add a name to your list',
              hintStyle: Theme.of(context).textTheme.headline2!.copyWith(
                    color: Theme.of(context)
                        .textTheme
                        .headline2!
                        .color!
                        .withOpacity(0.5),
                  ),
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: Consumer<Notes>(
              builder: (context, notes, child) {
                return Column(
                  children: [
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: notes.findById(id).todoList.length,
                      // itemCount: todoList.length,
                      itemBuilder: ((context, index) {
                        return TodoItem(
                          id: id,
                          notesProvider: notes,
                          indexTask: index,
                          title: notes.findById(id).todoList[index]['content'],
                          isChecked: notes.findById(id).todoList[index]
                              ['isChecked'],
                        );
                      }),
                    ),
                    const SizedBox(height: 10),
                    MaterialButton(
                      onPressed: () {
                        notes.addTask(id);
                      },
                      child: Row(
                        children: [
                          SvgPicture.asset(
                            'lib/assets/icons/plus.svg',
                            height:
                                Theme.of(context).textTheme.bodyText1!.fontSize,
                            color:
                                Theme.of(context).primaryColor.withOpacity(.5),
                          ),
                          const SizedBox(width: 10),
                          Text(
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
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
