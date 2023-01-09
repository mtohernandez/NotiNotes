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

  Widget _buildHeroImage() {
    return Hero(
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
    );
  }

  Widget _buildTitle() {
    return Text(
      widget.title,
      style: Theme.of(context).textTheme.headline2,
    );
  }

  Widget _buildContent() {
    return Text(
      widget.content,
      style: Theme.of(context).textTheme.bodyText1,
      maxLines: 4,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget _buildTags() {
    return Container(
      height: Theme.of(context).textTheme.bodyText1!.fontSize! * 2.0,
      alignment: Alignment.centerLeft,
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: widget.tags.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) => TagItem(
          null,
          0,
          tag: widget.tags.elementAt(index),
          isForSearch: false,
          isForCreation: false,
          backgroundColor: widget.colorBackground, // Note background
        ),
      ),
    );
  }

  Widget _buildDate() {
    return Text(
      DateFormat('MMM d, yyyy').format(widget.date),
      style: TextStyle(
        color: Theme.of(context).primaryColor.withOpacity(.5),
        fontSize: Theme.of(context).textTheme.bodyText1!.fontSize!,
      ),
    );
  }

  Widget _buildEmptyNote() {
    return Column(
      children: [
        Text(
          'You left this note empty...',
          style: Theme.of(context).textTheme.bodyText1!.copyWith(
                fontStyle: FontStyle.italic,
                color: Theme.of(context).primaryColor.withOpacity(.5),
              ),
        ),
        const SizedBox(
          height: 10,
        ),
      ],
    );
  }

  void selectNote() {
    setState(() {
      isSelected = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    final notes = Provider.of<Notes>(context, listen: false);
    final isSearching = Provider.of<Search>(context, listen: false);
    const noteSeparator = SizedBox(height: 10);

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
          // color: Colors.black,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Stack(
          children: [
            // This is how to add the pattern image
            // ClipRRect(
            //   borderRadius: BorderRadius.circular(30),
            //   child: Image.asset(
            //     'lib/assets/images/patterns/polygons.png',
            //     color: widget.colorBackground,
            //     fit: BoxFit.cover,
            //   ),
            // ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (widget.imageFile == null &&
                      widget.title.isEmpty &&
                      widget.content.isEmpty)
                    _buildEmptyNote(),
                  if (widget.imageFile != null) _buildHeroImage(),
                  if (widget.imageFile != null) noteSeparator,
                  if (widget.title.isNotEmpty) _buildTitle(),
                  if (widget.title.isNotEmpty) noteSeparator,
                  if (widget.content.isNotEmpty) _buildContent(),
                  if (widget.content.isNotEmpty) noteSeparator,
                  if (widget.tags.isNotEmpty) _buildTags(),
                  if (widget.tags.isNotEmpty) noteSeparator,
                  _buildDate(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
