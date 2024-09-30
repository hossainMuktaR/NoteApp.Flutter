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
    if (noteOrder is NoteOrderTitle) {
      notes.sort((a, b) => a.title.compareTo(b.title));
      print("Sorted by Title Ascending: $notes");
    } else if (noteOrder is NoteOrderDate) {
      notes.sort((a, b) => a.timeStamp.compareTo(b.timeStamp));
      print("Sorted by Date Ascending: $notes");
    } else if (noteOrder is NoteOrderColor) {
      notes.sort((a, b) => a.color.compareTo(b.color));
      print("Sorted by Color Ascending: $notes");
    }
  } else if (noteOrder.orderType == OrderType.descending) {
    if (noteOrder is NoteOrderTitle) {
      notes.sort((a, b) => b.title.compareTo(a.title));
      print("Sorted by Title Descending: $notes");
    } else if (noteOrder is NoteOrderDate) {
      notes.sort((a, b) => b.timeStamp.compareTo(a.timeStamp));
      print("Sorted by Date Descending: $notes");
    } else if (noteOrder is NoteOrderColor) {
      notes.sort((a, b) => b.color.compareTo(a.color));
      print("Sorted by Color Descending: $notes");
    }
  }
  
  print("Sorted Notes Returned: $notes");
  return notes;
}
}
