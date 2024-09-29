import 'package:flutter/material.dart';
import 'package:noteapp_flutter/data/repository/note_repository_impl.dart';
import 'package:noteapp_flutter/domain/model/note.dart';
import 'package:noteapp_flutter/domain/repository/note_repository.dart';
import 'package:noteapp_flutter/domain/utils/note_order.dart';
import 'package:noteapp_flutter/domain/utils/order_type.dart';

class NoteListViewModel extends ChangeNotifier {
  final NoteRepository _repository = NoteRepositoryImpl();

  List<Note> _notes = [];
  List<Note> get notes => _notes;
  bool isOrderSectionVisible = false;
  NoteOrder order = NoteOrderTitle(OrderType.ascending);

  void toggleOrderSection() {
    isOrderSectionVisible = !isOrderSectionVisible;
    notifyListeners();
  }

  void changeOrder(NoteOrder noteOrder) async {
    order = noteOrder;
    await loadNotes();
  }

  Future<void> loadNotes() async {
    _notes = await _repository.getAllNotes(order);
    print("Notes loaded: ${_notes} notes");
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
