import 'package:noteapp_flutter/data/local/note_database.dart';
import 'package:noteapp_flutter/domain/model/note.dart';
import 'package:noteapp_flutter/domain/repository/note_repository.dart';

class NoteRepositoryImpl implements NoteRepository {
  final NoteDatabase db;

  NoteRepositoryImpl({NoteDatabase? database})
      : db = database ?? NoteDatabase();

  @override
  Future<List<Note>> getAllNotes() async {
    final notes = await db.getAllNotes();
    return notes.map((e) => e.toNote()).toList();
  }

  @override
  Future<Note?> getNoteById(int id) async {
    final note = await db.getNoteById(id);
    return note?.toNote();
  }

  @override
  Future<void> insertNote(Note note) async {
    await db.insertNote(note.toNoteModel());
  }

  @override
  Future<void> deleteNote(Note note) async {
    
      await db.deleteNote(note.id);
    
  }
}
