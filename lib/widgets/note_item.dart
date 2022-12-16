import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../widgets/tag_item.dart';

class NoteItem extends StatelessWidget {
  final String id;
  final String title;
  final String content;
  final List<String> tags;
  final String imageUrl;
  final DateTime date;

  const NoteItem(
    this.tags,
    this.imageUrl, {
    super.key,
    required this.id,
    required this.title,
    required this.content,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.red, // This will be the color for now
        borderRadius: BorderRadius.circular(30),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.headline1,
            ),
            const SizedBox(height: 10),
            Text(
              content,
              style: Theme.of(context).textTheme.bodyText1,
            ),
            const SizedBox(height: 10),
            if (tags.isNotEmpty)
              Container(
                height: Theme.of(context).textTheme.bodyText1!.fontSize! * 2.0,
                alignment: Alignment.centerLeft,
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: tags.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) => TagItem(
                    tag: tags[index],
                  ),
                ),
              ),
            const SizedBox(height: 10),
            Text(
              DateFormat('MMM d, h:mm a').format(date),
              style: TextStyle(
                color: Theme.of(context).primaryColor.withOpacity(.5),
                fontSize: Theme.of(context).textTheme.bodyText1!.fontSize!,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
