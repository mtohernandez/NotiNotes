import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:noti_notes_app/helpers/color_picker.dart';
import 'package:noti_notes_app/models/note.dart';
import 'dart:io';
import 'package:provider/provider.dart';

import '../../providers/search.dart';
import '../../screens/note_view_screen.dart';
import '../../providers/notes.dart';
import '../items/todo_item.dart';
import 'tag_item.dart';

class NoteItem extends StatefulWidget {
  final String id;
  final String title;
  final String content;
  final Set<String> tags;
  final List<Map<String, dynamic>> todoList;
  final File? imageFile;
  final String? patternImage;
  final DateTime date;
  final DisplayMode displayMode;
  Color colorBackground;
  Color fontColor;

  NoteItem(
    this.tags,
    this.imageFile,
    this.patternImage,
    this.todoList, {
    super.key,
    required this.id,
    required this.title,
    required this.content,
    required this.date,
    required this.colorBackground,
    required this.fontColor,
    required this.displayMode,
  });

  @override
  State<NoteItem> createState() => _NoteItemState();
}

class _NoteItemState extends State<NoteItem> {
  var isSelected = false;
  late Notes notes;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    notes = Provider.of<Notes>(context, listen: false);
  }

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
      style: Theme.of(context)
          .textTheme
          .headline2!
          .copyWith(color: widget.fontColor),
    );
  }

  Widget _buildContent() {
    return Text(
      widget.content,
      style: Theme.of(context)
          .textTheme
          .bodyText1!
          .copyWith(color: widget.fontColor),
      maxLines: 4,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget _buildTodoList() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.1,
      alignment: Alignment.topLeft,
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: widget.todoList.length,
        itemBuilder: (context, index) => TodoItem(
          isForNote: true,
          id: widget.id,
          notesProvider: notes,
          indexTask: index,
          fullLength: notes.findById(widget.id).todoList.length,
          title: notes.findById(widget.id).todoList[index]['content'],
          isChecked: notes.findById(widget.id).todoList[index]['isChecked'],
          focusScopeNode: null,
        ),
      ),
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
        color: widget.fontColor.withOpacity(.5),
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
        // Here i need toy to use the notes to delete array instead of the bool variable, just use it to check if the note is selected or not
        if (isSearching.isSearching == SearchType.notSearching) {
          notes.activateEditMode();
          isSelected = true;
          setState(() {});
        }
      },
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          image: widget.patternImage != null
              ? DecorationImage(
                  image: AssetImage(widget.patternImage!),
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(
                    ColorPicker.darken(widget.colorBackground, 0.1),
                    BlendMode.srcATop,
                  ),
                )
              : null,
          color: isSelected
              ? widget.colorBackground.withOpacity(.5)
              : widget.colorBackground,
          // color: Colors.black,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Stack(
          children: [
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
                  if (widget.imageFile != null &&
                      widget.displayMode == DisplayMode.withImage)
                    _buildHeroImage(),
                  if (widget.imageFile != null &&
                      widget.displayMode == DisplayMode.withImage)
                    noteSeparator,
                  if (widget.title.isNotEmpty) _buildTitle(),
                  if (widget.title.isNotEmpty) noteSeparator,
                  if (widget.content.isNotEmpty &&
                      widget.displayMode != DisplayMode.withoutContent)
                    _buildContent(),
                  if (widget.content.isNotEmpty &&
                      widget.displayMode != DisplayMode.withoutContent)
                    noteSeparator,
                  if (widget.todoList.isNotEmpty &&
                      widget.displayMode == DisplayMode.withTodoList)
                    _buildTodoList(),
                  if (widget.tags.isNotEmpty &&
                      widget.displayMode == DisplayMode.withTodoList)
                    _buildTags(),
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
