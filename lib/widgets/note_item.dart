import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../widgets/tag_item.dart';

class NoteItem extends StatelessWidget {
  final String id;
  final String title;
  final String content;
  final Set<String> tags;
  final String imageUrl;
  final DateTime date;
  final Color colorBackground;

  const NoteItem(
    this.tags,
    this.imageUrl, {
    super.key,
    required this.id,
    required this.title,
    required this.content,
    required this.date,
    required this.colorBackground,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: colorBackground, // This will be the color for now
        borderRadius: BorderRadius.circular(30),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // This code right here
            if (imageUrl.isNotEmpty)
              Container(
                height: MediaQuery.of(context).size.height * 0.1,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  image: DecorationImage(
                    image: AssetImage(imageUrl),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            if (imageUrl.isNotEmpty) const SizedBox(height: 5),
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
                    tag: tags.elementAt(index),
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
