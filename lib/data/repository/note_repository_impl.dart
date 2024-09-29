import 'package:noteapp_flutter/data/local/note_database.dart';
import 'package:noteapp_flutter/domain/model/note.dart';
import 'package:noteapp_flutter/domain/repository/note_repository.dart';
import 'package:noteapp_flutter/domain/utils/note_order.dart';
import 'package:noteapp_flutter/domain/utils/order_type.dart';

class NoteRepositoryImpl implements NoteRepository {
  final NoteDatabase db;

  NoteRepositoryImpl({NoteDatabase? database})
      : db = database ?? NoteDatabase();

  @override
  Future<List<Note>> getAllNotes(NoteOrder noteOrder) async {
    final notes = await db.getAllNotes();
    return getSortedNote(notes.map((e) => e.toNote()).toList(), noteOrder);
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

  List<Note> getSortedNote(List<Note> notes, NoteOrder noteOrder) {
    if (noteOrder.orderType == OrderType.ascending) {
      switch (noteOrder.runtimeType) {
        case NoteOrderTitle _:
          notes.sort((a, b) => a.title.compareTo(b.title));
          break;
        case NoteOrderDate _:
          notes.sort((a, b) => a.timeStamp.compareTo(b.timeStamp));
          break;
        case NoteOrderColor _:
          notes.sort((a, b) => a.color.compareTo(b.color));
          break;
      }
    } else if (noteOrder.orderType == OrderType.descending) {
      switch (noteOrder.runtimeType) {
        case NoteOrderTitle _:
          notes.sort((a, b) => b.title.compareTo(a.title));
          break;
        case NoteOrderDate _:
          notes.sort((a, b) => b.timeStamp.compareTo(a.timeStamp));
          break;
        case NoteOrderColor _:
          notes.sort((a, b) => b.color.compareTo(a.color));
          break;
      }
    }
    return notes;
  }
}
