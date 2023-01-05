import 'package:flutter/material.dart';
import 'package:noti_notes_app/helpers/database_helper.dart';
import 'package:noti_notes_app/helpers/photo_picker.dart';
import 'package:string_similarity/string_similarity.dart';
import 'package:collection/collection.dart';
import 'dart:convert';
import 'dart:io';

import '../models/note.dart';

enum SqueezedMetric {
  superSqueezed,
  squeeezed,
  notSqueezed,
}

enum ToolingNote {
  addTag,
  removeTag,
  addImage,
  removeImage,
  color,
}

class Notes with ChangeNotifier {
  List<Note> _notes = [];

  //? TEST
  final Map<SqueezedMetric, int> squeezMetrics = {
    // Testing
    SqueezedMetric.superSqueezed: 3,
    SqueezedMetric.squeeezed: 2,
    SqueezedMetric.notSqueezed: 1,
  };

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

  //? Modes on note editing

  void activateEditMode() {
    editMode = true;
    notifyListeners();
  }

  void deactivateEditMode() {
    editMode = false;
    notifyListeners();
  }


  //? Load the notes from the database

  Future<void> loadNotesFromDataBase() async {
    final dataList = await DbHelper.getData(DbHelper.notesTable, DbHelper.databaseNotes());
    _notes = dataList.map((note) => 
        Note(
          jsonDecode(note['tags']).cast<String>().toSet(),
          note['imageFile'] != null
              ? File(note['imageFile'])
              : null,
          note['patternImage'] != null
              ? File(note['patternImage'])
              : null,
          jsonDecode(note['todoList']).cast<Map<String, dynamic>>(),
          note['reminder'] != ''
              ? DateTime.parse(note['reminder'])
              : null,
          id: note['id'],
          title: note['title'],
          content: note['content'],
          dateCreated: DateTime.parse(note['dateCreated']),
          colorBackground: Color(note['colorBackground']),
        ),
      ).toList();
    notifyListeners();
  }

  //? Note creation

  void addNote(Note note) {
    if (note.id.isEmpty) {
      return;
    }
    _notes.add(note);
    DbHelper.insert(DbHelper.notesTable, note.toJson(), DbHelper.databaseNotes());
    // notifyListeners();
  }

  //? Multiple note deletion

  Future<void> removeSelectedNotes(Set<String> ids) async {
    _notes.removeWhere((note) => ids.contains(note.id));
    for (var id in ids) {
      await DbHelper.delete(DbHelper.notesTable, id, DbHelper.databaseNotes());
    }
    notifyListeners();
  }

  //? Single note deletion

  Future<void> removeNoteById(String id) async {
    findById(id).imageFile != null
        ? PhotoPicker.removeImage(findById(id).imageFile!)
        : null;
    _notes.removeWhere((note) => note.id == id);
    await DbHelper.delete(DbHelper.notesTable, id, DbHelper.databaseNotes());
    notifyListeners();
  }

  //? Updating single note

  void updateNote(
    Note noteUpdated,
  ) {
    final noteIndex = _notes.indexWhere((note) => note.id == noteUpdated.id);
    if (noteIndex >= 0) {
      _notes[noteIndex] = noteUpdated;
      notifyListeners();
    }
    DbHelper.update(DbHelper.notesTable, noteUpdated.toJson(), DbHelper.databaseNotes());
  }

  //? Updating multiple notes

  void updateNotesToDataBase(List<Note> notesUpdated) {
    for (var note in notesUpdated) {
      final noteIndex = _notes.indexWhere((note) => note.id == note.id);
      if (noteIndex >= 0) {
        _notes[noteIndex] = note;
        notifyListeners();
      }
      DbHelper.update(DbHelper.notesTable, note.toJson(), DbHelper.databaseNotes());
    }
  }

  //? Filtering methods

  List<Note> filterByTitle(String name) {
    return _notes
        .where((note) => note.title.similarityTo(name) > 0.6 ? true : false)
        .toList();
  }

  List<Note> filterByTag(Set<String> tags) {
    return _notes
        .where((note) => note.tags.intersection(tags).isNotEmpty ? true : false)
        .toList();
  }

  Note findById(String id) {
    return _notes.firstWhere((note) => note.id == id);
  }

  Note? findByIdOrNull(String id) {
    return _notes.firstWhereOrNull((note) => note.id == id);
  }

  int findIndex(String id) {
    return _notes.indexWhere((note) => note.id == id);
  }

  Color findColor(String id) {
    return _notes.firstWhere((note) => note.id == id).colorBackground;
  }

  //? Tooling for note changing

  void toolingNote(String id, ToolingNote tooling, dynamic value,
      [int index = 0]) {
    final noteIndex = findIndex(id);
    if (noteIndex >= 0) {
      if (tooling == ToolingNote.addImage) {
        _notes[noteIndex].imageFile = File(value.path);
      } else if (tooling == ToolingNote.removeImage) {
        PhotoPicker.removeImage(_notes[noteIndex].imageFile!);
        _notes[noteIndex].imageFile = value;
      } else if (tooling == ToolingNote.addTag) {
        _notes[noteIndex].tags.add(value);
      } else if (tooling == ToolingNote.removeTag) {
        _notes[noteIndex].tags.remove(_notes[noteIndex].tags.elementAt(index));
      } else if (tooling == ToolingNote.color) {
        _notes[noteIndex].colorBackground = value;
      }

      notifyListeners();
    }
  }

  void addImageToNote(String id, File? image) {
    toolingNote(id, ToolingNote.addImage, image);
  }

  void removeImageFromNote(String id) {
    toolingNote(id, ToolingNote.removeImage, null);
  }

  void addTagToNote(String tag, String id) {
    toolingNote(id, ToolingNote.addTag, tag);
  }

  void removeTagsFromNote(int index, String id) {
    toolingNote(id, ToolingNote.removeTag, null, index);
  }

  void changeCurrentColor(String id, Color color) {
    toolingNote(id, ToolingNote.color, color);
  }

  void toggleTask(String id, int index) {
    final noteIndex = findIndex(id);
    if (noteIndex >= 0) {
      _notes[noteIndex].todoList[index]['isChecked'] =
          !_notes[noteIndex].todoList[index]['isChecked'];
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
      notifyListeners();
    }
  }

  void removeTask(String id, int index) {
    final noteIndex = findIndex(id);
    if (noteIndex >= 0) {
      _notes[noteIndex].todoList.removeAt(index);
      notifyListeners();
    }
  }

  void updateTask(String id, int index, String content) {
    final noteIndex = findIndex(id);
    if (noteIndex >= 0) {
      _notes[noteIndex].todoList[index]['content'] = content;
      notifyListeners();
    }
  }
}
