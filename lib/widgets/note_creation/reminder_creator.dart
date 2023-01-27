import 'package:flutter/material.dart';
import 'package:noti_notes_app/api/notifications_api.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

import '../../widgets/items/icon_button_x_item.dart';
import '../../providers/notes.dart';

class ReminderCreator extends StatefulWidget {
  final String id;
  const ReminderCreator(this.id, {super.key});

  @override
  State<ReminderCreator> createState() => _ReminderCreatorState();
}

class _ReminderCreatorState extends State<ReminderCreator> {
  // Initial Selected Value
  String dropdownvalue = 'SECONDS';
  int selectedValue = 1;

  // List of items in our dropdown menu
  List<String> items = [
    'SECONDS',
    'MINUTES',
    'HOURS',
  ];

  List<int> createList(int length) {
    List<int> list = [];
    for (int i = 1; i <= length; i++) {
      list.add(i);
    }
    return list;
  }

  @override
  Widget build(BuildContext context) {
    final notes = Provider.of<Notes>(context, listen: false);
    final note = notes.findById(widget.id);

    exitCreator() {
      Navigator.pop(context);
    }

    List<int> values = createList(60);
    List<int> valuesForHours = createList(24);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Set a reminder',
              style: Theme.of(context).textTheme.headline1,
            ),
            IconButtonXItem(exitCreator),
          ],
        ),
        // const SizedBox(height: 20),
        Text(
          'Keep in mind reminders work only on the same day. This will increase your productivity and help you focus on the task at hand.',
          style: Theme.of(context).textTheme.bodyText1!.copyWith(
                color: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .color!
                    .withOpacity(0.5),
              ),
        ),
        const SizedBox(height: 10),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Remind me in',
              style: Theme.of(context)
                  .textTheme
                  .headline1!
                  .copyWith(fontWeight: FontWeight.w400),
            ),
            const SizedBox(width: 10),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Theme.of(context).primaryColor.withOpacity(0.1),
              ),
              height: Theme.of(context).textTheme.headline1!.fontSize! + 5,
              width: MediaQuery.of(context).size.width * 0.1,
              child: ListWheelScrollView(
                physics: const FixedExtentScrollPhysics(),
                // diameterRatio: 1.5,
                itemExtent:
                    Theme.of(context).textTheme.headline1!.fontSize!.toDouble(),
                children: [
                  if (dropdownvalue != 'HOURS')
                    ...values.map((e) {
                      return Text(
                        e.toString(),
                        style: Theme.of(context).textTheme.headline1!.copyWith(
                              fontWeight: FontWeight.w400,
                              color: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .color!
                                  .withOpacity(0.5),
                            ),
                      );
                    }).toList(),
                  if (dropdownvalue == 'HOURS')
                    ...valuesForHours.map((e) {
                      return Text(
                        e.toString(),
                        style: Theme.of(context).textTheme.headline1!.copyWith(
                              fontWeight: FontWeight.w400,
                              color: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .color!
                                  .withOpacity(0.5),
                            ),
                      );
                    }).toList(),
                ],
                onSelectedItemChanged: (value) => selectedValue = values[value],
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Theme.of(context).primaryColor.withOpacity(0.1),
                ),
                height: Theme.of(context).textTheme.headline1!.fontSize! + 5,
                // width: MediaQuery.of(context).size.width * 0.4,
                child: ListWheelScrollView(
                    physics: const FixedExtentScrollPhysics(),
                    // diameterRatio: 1.5,
                    itemExtent: Theme.of(context)
                        .textTheme
                        .headline1!
                        .fontSize!
                        .toDouble(),
                    children: [
                      ...items.map((e) {
                        return Text(
                          e,
                          textAlign: TextAlign.center,
                          style:
                              Theme.of(context).textTheme.headline1!.copyWith(
                                    fontWeight: FontWeight.w400,
                                    color: Theme.of(context)
                                        .textTheme
                                        .bodyText1!
                                        .color!
                                        .withOpacity(0.5),
                                  ),
                        );
                      }).toList(),
                    ],
                    onSelectedItemChanged: (value) => setState(() {
                          dropdownvalue = items[value];
                        })),
              ),
            )
          ],
        ),
        const SizedBox(height: 10),
        note.reminder == null
            ? TextButton(
                style: TextButton.styleFrom(
                  backgroundColor:
                      Theme.of(context).primaryColor.withOpacity(0.1),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () async {
                  await Permission.notification.isDenied.then((value) {
                    if (value) {
                      Permission.notification.request();
                    }
                  });
                  DateTime reminder = dropdownvalue == 'HOURS'
                      ? DateTime.now().add(
                          Duration(
                            hours: selectedValue,
                          ),
                        )
                      : dropdownvalue == 'MINUTES'
                          ? DateTime.now().add(
                              Duration(
                                minutes: selectedValue,
                              ),
                            )
                          : DateTime.now().add(
                              Duration(
                                seconds: selectedValue,
                              ),
                            );
                  LocalNotificationService().addNotification(
                    notes.findIndex(note.id),
                    note.title != '' ? note.title : 'Reminder',
                    // notes.reminderMessage, TO BE SET
                    'Content',
                    reminder,
                    channel: 'reminders',
                  );
                  setState(() {
                    notes.addReminder(widget.id, reminder);
                  });
                },
                child: Text(
                  'Set',
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              )
            : Row(
                children: [
                  Text(
                    'Reminder set for ${DateFormat('MMM d, HH:mm').format(note.reminder!)}',
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        LocalNotificationService()
                            .cancelNotification(notes.findIndex(note.id));
                        notes.removeReminder(widget.id);
                      });
                    },
                    child: Text(
                      'Cancel',
                      style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            decoration: TextDecoration.underline,
                          ),
                    ),
                  ),
                ],
              ),
      ],
    );
  }
}
