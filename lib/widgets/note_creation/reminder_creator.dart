import 'package:flutter/material.dart';
import 'package:noti_notes_app/api/notifications_api.dart';

import '../../widgets/items/icon_button_x_item.dart';

class ReminderCreator extends StatelessWidget {
  final String id;
  const ReminderCreator(this.id, {super.key});

  @override
  Widget build(BuildContext context) {
    exitCreator() {
      Navigator.pop(context);
    }

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
        const SizedBox(height: 20),
        Text(
          'When do you want to be reminded?',
          style: Theme.of(context).textTheme.headline3,
        ),
        const SizedBox(height: 10),
        TextButton(
          onPressed: () async {
            await NotificationsApi.showNotification(
              id: 1,
              title: 'Reminder',
              body: 'This is a reminder',
            );
          },
          child: const Text('Show notification'),
        )
      ],
    );
  }
}
