import 'dart:math';

import 'package:flutter/material.dart';
import 'package:noteapp_flutter/data/repository/note_repository_impl.dart';
import 'package:noteapp_flutter/domain/model/note.dart';
import 'package:noteapp_flutter/domain/repository/note_repository.dart';

class AddEditNoteViewmodel extends ChangeNotifier {
  final NoteRepository _repository = NoteRepositoryImpl();
  final int? noteId;

  String _noteTitle = '';
  String _noteContent = '';
  int _noteColor = Note.noteColors.first.value; // Default color (white)
  bool _isTitleHintVisible = true;
  bool _isContentHintVisible = true;

  String get noteTitle => _noteTitle;
  String get noteContent => _noteContent;
  int get noteColor => _noteColor;
  bool get isTitleHintVisible => _isTitleHintVisible;
  bool get isContentHintVisible => _isContentHintVisible;

  AddEditNoteViewmodel(int? id) : noteId = id {
    if (noteId != null) {
      loadNote(noteId!);
    }
  }
  void titleChanged(String value) {
    _noteTitle = value;
    _isTitleHintVisible = value.isEmpty;
    notifyListeners();
  }

  void contentChanged(String value) {
    _noteContent = value;
    _isContentHintVisible = value.isEmpty;
    notifyListeners();
  }

  void loadNote(int noteId) async {
    final note = await _repository.getNoteById(noteId);
    if (note != null) {
      print(
          "Note loaded: ${note.title}, ${note.content}, ${note.color}"); // Debug statement
      _noteTitle = note.title;
      _noteContent = note.content;
      _noteColor = note.color;
      notifyListeners();
    }
  }

  void colorChanged(int newColor) {
    _noteColor = newColor;
    notifyListeners();
  }

  void saveNote() {
    int currentTime = DateTime.now().millisecondsSinceEpoch;

    final note = Note(
      title: _noteTitle,
      content: _noteContent,
      timeStamp: currentTime,
      color: _noteColor,
      id: noteId ?? generateIntUUID(),
    );

    _repository.insertNote(note);
  }

  int generateIntUUID() {
    var random = Random();
    return random.nextInt(0x7FFFFFFF); // Generates a random 32-bit positive int
  }
}
