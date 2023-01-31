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

  const NoteItem({
    super.key,
    required this.id,
  });

  @override
  State<NoteItem> createState() => _NoteItemState();
}

class _NoteItemState extends State<NoteItem> {
  late Notes notes;
  late String title;
  late String content;
  late Set<String> tags;
  late List<Map<String, dynamic>> todoList;
  late File? imageFile;
  late String? patternImage;
  late DateTime date;
  late DisplayMode displayMode;
  late Color colorBackground;
  late Color fontColor;
  late LinearGradient? gradient;
  late bool hasGradient;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    notes = Provider.of<Notes>(context, listen: false);
    title = notes.findById(widget.id).title;
    content = notes.findById(widget.id).content;
    tags = notes.findById(widget.id).tags;
    todoList = notes.findById(widget.id).todoList;
    imageFile = notes.findById(widget.id).imageFile;
    patternImage = notes.findById(widget.id).patternImage;
    date = notes.findById(widget.id).dateCreated;
    displayMode = notes.findById(widget.id).displayMode;
    colorBackground = notes.findById(widget.id).colorBackground;
    fontColor = notes.findFontColor(widget.id);
    gradient = notes.findById(widget.id).gradient;
    hasGradient = notes.findById(widget.id).hasGradient;
  }

  Widget _addPadding(Widget child) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: child,
    );
  }

  Widget _buildHeroImage() {
    return Hero(
      tag: widget.id,
      child: Container(
        height: MediaQuery.of(context).size.height * 0.1,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(15), topRight: Radius.circular(15)),
          image: DecorationImage(
            image: FileImage(imageFile!),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  Widget _buildTitle() {
    return Text(
      title,
      style: Theme.of(context).textTheme.headline2!.copyWith(color: fontColor),
    );
  }

  Widget _buildContent() {
    return Text(
      content,
      style: Theme.of(context).textTheme.bodyText1!.copyWith(color: fontColor),
      maxLines: 4,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget _buildTodoList() {
    return Container(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.1,
      ),
      // alignment: Alignment.topLeft,
      child: ListView.builder(
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        itemCount: todoList.length,
        itemBuilder: (context, index) => TodoItem(
          isForNote: true,
          id: widget.id,
          notesProvider: notes,
          indexTask: index,
          fullLength: todoList.length,
          title: todoList[index]['content'],
          isChecked: todoList[index]['isChecked'],
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
        itemCount: tags.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) => TagItem(
          null,
          0,
          tag: tags.elementAt(index),
          isForSearch: false,
          isForCreation: false,
          backgroundColor: colorBackground, // Note background
        ),
      ),
    );
  }

  Widget _buildDate() {
    return Text(
      DateFormat('MMM d, yyyy').format(date),
      style: TextStyle(
        color: fontColor.withOpacity(.5),
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
          setState(() {});
        }
      },
      onLongPress: () {
        // Here i need toy to use the notes to delete array instead of the bool variable, just use it to check if the note is selected or not
        notes.notesToDelete.clear(); // This avoid errors
        if (isSearching.isSearching == SearchType.notSearching) {
          notes.activateEditMode();
          notes.notesToDelete.add(widget.id);
          setState(() {});
        }
      },
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          image: patternImage != null
              ? DecorationImage(
                  image: AssetImage(patternImage!),
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(
                    ColorPicker.darken(colorBackground, 0.1),
                    BlendMode.srcATop,
                  ),
                )
              : null,
          color: notes.notesToDelete.contains(widget.id) && notes.editMode
              ? colorBackground.withOpacity(.5)
              : !hasGradient
                  ? colorBackground
                  : null,
          gradient: hasGradient
              ? gradient
              : null,
          // color: Colors.black,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Stack(
          children: [
            Padding(
              padding:
                  // const EdgeInsets.symmetric(horizontal: 20.0, vertical: 30),
                  EdgeInsets.only(
                // left: 20.0,
                // right: 20.0,
                top: imageFile != null && displayMode == DisplayMode.withImage
                    ? 0
                    : 30.0,
                bottom: 30.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (imageFile == null && title.isEmpty && content.isEmpty)
                    _addPadding(_buildEmptyNote()),
                  if (imageFile != null && displayMode == DisplayMode.withImage)
                    _buildHeroImage(),
                  if (imageFile != null && displayMode == DisplayMode.withImage)
                    noteSeparator,
                  if (title.isNotEmpty) _addPadding(_buildTitle()),
                  if (title.isNotEmpty) noteSeparator,
                  if (content.isNotEmpty &&
                      displayMode != DisplayMode.withoutContent &&
                      displayMode != DisplayMode.withTodoList)
                    _addPadding(_buildContent()),
                  if (content.isNotEmpty &&
                      displayMode != DisplayMode.withoutContent &&
                      displayMode != DisplayMode.withTodoList)
                    noteSeparator,
                  if (todoList.isNotEmpty &&
                      displayMode == DisplayMode.withTodoList)
                    _addPadding(_buildTodoList()),
                  if (todoList.isNotEmpty &&
                      displayMode == DisplayMode.withTodoList)
                    noteSeparator,
                  if (tags.isNotEmpty && displayMode != DisplayMode.normal)
                    _addPadding(_buildTags()),
                  if (tags.isNotEmpty) noteSeparator,
                  _addPadding(_buildDate()),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
