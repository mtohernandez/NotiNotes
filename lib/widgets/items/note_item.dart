import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:io';
import 'package:provider/provider.dart';

import '../../providers/search.dart';
import '../../screens/note_view_screen.dart';
import '../../providers/notes.dart';
import 'tag_item.dart';

class NoteItem extends StatefulWidget {
  final String id;
  final String title;
  final String content;
  final Set<String> tags;
  final File? imageFile;
  final DateTime date;
  Color colorBackground;

  NoteItem(
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
  State<NoteItem> createState() => _NoteItemState();
}

class _NoteItemState extends State<NoteItem> {
  var isSelected = false;

  void selectNote() {
    setState(() {
      isSelected = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    final notes = Provider.of<Notes>(context, listen: false);
    final isSearching = Provider.of<Search>(context, listen: false);
    return GestureDetector(
      onTap: () {
        if (!notes.editMode) {
          Navigator.of(context)
              .pushNamed(NoteViewScreen.routeName, arguments: widget.id);
        } else {
          if (notes.notesToDelete.contains(widget.id)) {
            notes.notesToDelete.remove(widget.id);
          } else {
            notes.notesToDelete.add(widget.id);
          }
          setState(() {
            isSelected = !isSelected;
          });
        }
      },
      onLongPress: () {
        if (isSearching.isSearching == SearchType.notSearching) {
          notes.activateEditMode();
          selectNote();
        }
      },
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: isSelected
              ? widget.colorBackground.withOpacity(.5)
              : widget.colorBackground,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // This code right here
              if (widget.imageFile != null)
                Hero(
                  tag: 'noteImage${widget.id}',
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.1,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      image: DecorationImage(
                        image: FileImage(widget.imageFile!),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              if (widget.imageFile != null) const SizedBox(height: 5),
              if (widget.title.isNotEmpty)
                Text(
                  widget.title,
                  style: Theme.of(context).textTheme.headline1,
                ),
              if (widget.title.isNotEmpty) const SizedBox(height: 10),
              if (widget.content.isNotEmpty)
                Text(
                  widget.content,
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              if (widget.content.isNotEmpty) const SizedBox(height: 10),
              if (widget.tags.isNotEmpty)
                Container(
                  height:
                      Theme.of(context).textTheme.bodyText1!.fontSize! * 2.0,
                  alignment: Alignment.centerLeft,
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: widget.tags.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) => TagItem(
                      tag: widget.tags.elementAt(index),
                      isForSearch: false,
                    ),
                  ),
                ),
              const SizedBox(height: 10),
              Text(
                DateFormat('MMM d, yyyy').format(widget.date),
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
