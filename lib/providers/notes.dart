import 'package:flutter/material.dart';
import 'package:noti_notes_app/helpers/aligment.dart';
import 'package:noti_notes_app/helpers/database_helper.dart';
import 'package:noti_notes_app/helpers/photo_picker.dart';
import 'package:string_similarity/string_similarity.dart';
// import 'package:hive_flutter/hive_flutter.dart';
// ignore: depend_on_referenced_packages
import 'package:collection/collection.dart';
import 'dart:io';
import 'dart:convert';

import '../models/note.dart';
import '../api/notifications_api.dart';

enum ToolingNote {
  addTag,
  removeTag,
  addImage,
  removeImage,
  color,
  patternImage,
  removePatternImage,
  addreminder,
  removeReminder,
  fontColor,
  displayMode,
  gradient,
}

class Notes with ChangeNotifier {
  final List<Note> _notes = [];
  bool editMode = false;
  Set<String> notesToDelete = {};

  List<Note> get notes {
    return [..._notes];
  }

  int get notesCount {
    return _notes.length;
  }

  bool get isEditMode {
    return editMode;
  }

  void clearBox() {
    DbHelper.clearBox(DbHelper.notesBoxName);
  }

  //? Modes on note editing

  void activateEditMode() {
    editMode = true;
    notifyListeners();
  }

  void deactivateEditMode() {
    editMode = false;
    notifyListeners();
  }

  //? Load all notes from database

  void loadNotesFromDataBase() {
    final notesBox = DbHelper.getBox(DbHelper.notesBoxName);
    if (notesBox.values.isEmpty) {
      return;
    }
    for (var note in notesBox.values) {
      var noteDecoded = jsonDecode(note);
      // print('Gradient: ${noteDecoded['gradient']}');
      _notes.add(
        Note(
          noteDecoded['tags'].cast<String>().toSet(),
          noteDecoded['imageFile'] != null
              ? File(noteDecoded['imageFile'])
              : null,
          noteDecoded['patternImage'],
          noteDecoded['todoList'].cast<Map<String, dynamic>>(),
          noteDecoded['reminder'] != ''
              ? DateTime.parse(noteDecoded['reminder'])
              : null,
          noteDecoded['gradient'] != null && noteDecoded['gradient'] != ''
              ? LinearGradient(
                  colors: [
                    Color(noteDecoded['gradient']['colors'][0]),
                    Color(noteDecoded['gradient']['colors'][1]),
                  ],
                  begin: toAlignment(noteDecoded['gradient']['alignment'][0]),
                  end: toAlignment(noteDecoded['gradient']['alignment'][1]),
                )
              : null,
          id: noteDecoded['id'],
          title: noteDecoded['title'],
          content: noteDecoded['content'],
          dateCreated: DateTime.parse(noteDecoded['dateCreated']),
          colorBackground: Color(noteDecoded['colorBackground']),
          fontColor: Color(noteDecoded['fontColor']),
          displayMode: DisplayMode.values[noteDecoded['displayMode']],
          hasGradient: noteDecoded['hasGradient'],
        ),
      );
    }
    // _notes = _notes.reversed.toList(); This idk if it actually works
    notifyListeners();
  }

  //?  Sort notes by date created

  void sortByDateCreated() {
    _notes.sort((a, b) => b.dateCreated.compareTo(a.dateCreated));
    notifyListeners();
  }

  //? Update database

  void updateNoteOnDataBase(Note note) async {
    await DbHelper.insertUpdateData(
        DbHelper.notesBoxName, note.id, jsonEncode(note.toJson()));
  }

  void updateNotesOnDataBase(List<Note> notes) {
    for (var note in notes) {
      updateNoteOnDataBase(note);
    }
    // notifyListeners();
  }

  //? Note creation

  void addNote(Note note) {
    if (note.id.isEmpty) {
      return;
    }
    _notes.add(note);
    updateNoteOnDataBase(note);
  }

  //? Note Searching

  Note findById(String id) {
    return _notes.firstWhere((note) => note.id == id);
  }

  Note? findByIdOrNull(String id) {
    return _notes.firstWhereOrNull((note) => note.id == id);
  }

  int findIndex(String id) {
    return _notes.indexWhere((note) => note.id == id);
  }

  //? Note deletion

  Future<void> removeSelectedNotes(Set<String> ids) async {
    for (var id in ids) {
      findById(id).imageFile != null
          ? PhotoPicker.removeImage(findById(id).imageFile!)
          : null;
      LocalNotificationService().cancelNotification(findIndex(id));
      _notes.removeWhere((note) => note.id == id);
      DbHelper.deleteData(DbHelper.notesBoxName, id);
    }
    notifyListeners();
  }

  // Future<void> removeNoteById(String id) async {
  //   findById(id).imageFile != null
  //       ? PhotoPicker.removeImage(findById(id).imageFile!)
  //       : null;
  //   _notes.removeWhere((note) => note.id == id);
  //   DbHelper.deleteData(DbHelper.notesBoxName, id);
  //   notifyListeners();
  // }

  //? Note Updating for temporal memory

  void updateNote(
    Note noteUpdated,
  ) {
    final noteIndex = findIndex(noteUpdated.id);
    if (noteIndex >= 0) {
      _notes[noteIndex] = noteUpdated;
      updateNoteOnDataBase(noteUpdated);
      notifyListeners();
    }
  }

  //? Filtering methods

  List<Note> filterByTitle(String name) {
    return _notes
        .where((note) =>
            note.title.toUpperCase().similarityTo(name.toUpperCase()) > 0.6
                ? true
                : false)
        .toList();
  }

  List<Note> filterByTag(Set<String> tags) {
    return _notes
        .where((note) => note.tags.intersection(tags).isNotEmpty ? true : false)
        .toList();
  }

  Color findColor(String id) {
    return _notes.firstWhere((note) => note.id == id).colorBackground;
  }

  Color findFontColor(String id) {
    return _notes.firstWhere((note) => note.id == id).fontColor;
  }

  String? findPatternImage(String id) {
    return _notes.firstWhereOrNull((note) => note.id == id)!.patternImage;
  }

  LinearGradient? findGradient(String id) {
    return _notes.firstWhereOrNull((note) => note.id == id)!.gradient;
  }

  //? Tooling for note changing
  // Convert to switch
  void toolingNote(String id, ToolingNote tooling, dynamic value,
      [int index = 0]) {
    final noteIndex = findIndex(id);

    if (noteIndex >= 0) {
      switch (tooling) {
        case ToolingNote.addImage:
          _notes[noteIndex].imageFile = File(value.path);
          break;
        case ToolingNote.removeImage:
          PhotoPicker.removeImage(_notes[noteIndex].imageFile!);
          _notes[noteIndex].imageFile = value;
          break;
        case ToolingNote.addTag:
          _notes[noteIndex].tags.add(value);
          break;
        case ToolingNote.removeTag:
          _notes[noteIndex]
              .tags
              .remove(_notes[noteIndex].tags.elementAt(index));
          break;
        case ToolingNote.color:
          _notes[noteIndex].colorBackground = value;
          break;
        case ToolingNote.patternImage:
          _notes[noteIndex].patternImage = value;
          break;
        case ToolingNote.removePatternImage:
          _notes[noteIndex].patternImage = null;
          break;
        case ToolingNote.fontColor:
          _notes[noteIndex].fontColor = value;
          break;
        case ToolingNote.displayMode:
          _notes[noteIndex].displayMode = value;
          break;
        case ToolingNote.addreminder:
          _notes[noteIndex].reminder = value;
          break;
        case ToolingNote.removeReminder:
          _notes[noteIndex].reminder = null;
          break;
        case ToolingNote.gradient:
          _notes[noteIndex].gradient = value;
          break;
      }

      updateNoteOnDataBase(_notes[noteIndex]);
      notifyListeners();
    }
  }

  void addImageToNote(String id, File? image) {
    toolingNote(
      id,
      ToolingNote.addImage,
      image,
    );
  }

  void removeImageFromNote(String id) {
    toolingNote(
      id,
      ToolingNote.removeImage,
      null,
    );
  }

  void addTagToNote(String tag, String id) {
    toolingNote(
      id,
      ToolingNote.addTag,
      tag,
    );
  }

  void removeTagsFromNote(int index, String id) {
    toolingNote(
      id,
      ToolingNote.removeTag,
      null,
      index,
    );
  }

  void changeCurrentColor(String id, Color color) {
    toolingNote(
      id,
      ToolingNote.color,
      color,
    );
  }

  void changeCurrentPattern(String id, String? pattern) {
    toolingNote(
      id,
      ToolingNote.patternImage,
      pattern,
    );
  }

  void removeCurrentPattern(String id) {
    toolingNote(
      id,
      ToolingNote.removePatternImage,
      null,
    );
  }

  void changeCurrentFontColor(String id, Color color) {
    toolingNote(
      id,
      ToolingNote.fontColor,
      color,
    );
  }

  void changeCurrentDisplay(String id, DisplayMode mode) {
    toolingNote(
      id,
      ToolingNote.displayMode,
      mode,
    );
  }

  void changeCurrentGradient(String id, LinearGradient gradient) {
    toolingNote(
      id,
      ToolingNote.gradient,
      gradient,
    );
  }

  void addReminder(String id, DateTime dateTime) {
    toolingNote(
      id,
      ToolingNote.addreminder,
      dateTime,
    );
  }

  void removeReminder(String id) {
    toolingNote(
      id,
      ToolingNote.removeReminder,
      null,
    );
  }

  void toggleTask(String id, int index) {
    final noteIndex = findIndex(id);
    if (noteIndex >= 0) {
      _notes[noteIndex].todoList[index]['isChecked'] =
          !_notes[noteIndex].todoList[index]['isChecked'];
      updateNoteOnDataBase(_notes[noteIndex]);
      notifyListeners();
    }
  }

  void addTask(String id) {
    final noteIndex = findIndex(id);
    if (noteIndex >= 0) {
      _notes[noteIndex].todoList.add({
        'content': '',
        'isChecked': false,
      });
      updateNoteOnDataBase(_notes[noteIndex]);
      notifyListeners();
    }
  }

  void removeTask(String id, int index) {
    final noteIndex = findIndex(id);
    if (noteIndex >= 0) {
      _notes[noteIndex].todoList.removeAt(index);
      updateNoteOnDataBase(_notes[noteIndex]);
      notifyListeners();
    }
  }

  void updateTask(String id, int index, String content) {
    final noteIndex = findIndex(id);
    if (noteIndex >= 0) {
      _notes[noteIndex].todoList[index]['content'] = content;
      updateNoteOnDataBase(_notes[noteIndex]);
      notifyListeners();
    }
  }

  bool checkGradient(String id) {
    return findById(id).hasGradient;
  }

  void switchGradient(String id) {
    findById(id).hasGradient = !findById(id).hasGradient;
    updateNoteOnDataBase(findById(id));
    notifyListeners();
  }

  // Co pilot did this
  Set<String> getMostUsedTags() {
    final tags = <String, int>{};
    for (var note in _notes) {
      for (var tag in note.tags) {
        if (tags.containsKey(tag)) {
          tags[tag] = tags[tag]! + 1;
        } else {
          tags[tag] = 1;
        }
      }
    }
    final mostUsedTags = tags.entries.toList();
    mostUsedTags.sort((a, b) => b.value.compareTo(a.value));
    return mostUsedTags.take(5).map((e) => e.key).toSet();
  }
}
