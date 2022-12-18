import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:noti_notes_app/screens/note_view_screen.dart';
import 'dart:io';

import 'tag_item.dart';

class NoteItem extends StatelessWidget {
  final String id;
  final String title;
  final String content;
  final Set<String> tags;
  final File? imageFile;
  final DateTime date;
  final Color colorBackground;

  const NoteItem(
    this.tags,
    this.imageFile, {
    super.key,
    required this.id,
    required this.title,
    required this.content,
    required this.date,
    required this.colorBackground,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context)
            .pushNamed(NoteViewScreen.routeName, arguments: id);
      },
      onLongPress: () {},
      child: Container(
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
              if (imageFile != null)
                Hero(
                  tag: 'noteImage$id',
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.1,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      image: DecorationImage(
                        image: FileImage(imageFile!),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              if (imageFile != null) const SizedBox(height: 5),
              if (title.isNotEmpty)
                Text(
                  title,
                  style: Theme.of(context).textTheme.headline1,
                ),
              if (title.isNotEmpty) const SizedBox(height: 10),
              if (content.isNotEmpty)
                Text(
                  content,
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              if (content.isNotEmpty) const SizedBox(height: 10),
              if (tags.isNotEmpty)
                Container(
                  height:
                      Theme.of(context).textTheme.bodyText1!.fontSize! * 2.0,
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
      ),
    );
  }
}
