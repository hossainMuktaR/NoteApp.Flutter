import 'package:noteapp_flutter/domain/model/note.dart';
import 'package:noteapp_flutter/domain/utils/order_type.dart';

abstract class NoteRepository {
  
  Future<List<Note>> getAllNotes(NoteOrder noteOrder);

  // Get a specific note by its ID
  Future<Note?> getNoteById(int id);

  // Insert a new note into the repository
  Future<void> insertNote(Note note);

  // Delete a specific note from the repository
  Future<void> deleteNote(Note note);
}