import 'package:flutter/material.dart';
import 'package:noteapp_flutter/data/repository/note_repository_impl.dart';
import 'package:noteapp_flutter/domain/model/note.dart';
import 'package:noteapp_flutter/domain/repository/note_repository.dart';

class NoteListViewModel extends ChangeNotifier {
  final NoteRepository _repository = NoteRepositoryImpl();

  List<Note> _notes = [];
  List<Note> get notes => _notes;

  Future<void> loadNotes() async {
    _notes = await _repository.getAllNotes();
    notifyListeners();
  }

  Future<void> addNote(Note note) async {
    await _repository.insertNote(note);
    await loadNotes();
  }

  Future<void> deleteNoteById(int id) async {
    final note = await _repository.getNoteById(id);
    if (note != null) {
      await _repository.deleteNote(note);
      await loadNotes();
    }
  }
}