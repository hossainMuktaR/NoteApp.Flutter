import 'package:flutter/material.dart';
import 'package:noteapp_flutter/presentation/add_edit_note/add_edit_note_screen.dart';
import 'package:noteapp_flutter/presentation/note_list/note_list_viewmodel.dart';
import 'package:noteapp_flutter/presentation/note_list/widget/note_card.dart';
import 'package:noteapp_flutter/presentation/note_list/widget/order_section.dart';
import 'package:provider/provider.dart';

class NoteListScreen extends StatelessWidget {
  const NoteListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => NoteListViewModel(),
      child: Consumer<NoteListViewModel>(builder: (context, vm, child) {
        return Scaffold(
            appBar: AppBar(
              title: const Text('NoteApp'),
              actions: [
                IconButton(
                    onPressed: () {
                      vm.toggleOrderSection();
                    },
                    icon: const Icon(Icons.sort))
              ],
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () async {
                // implement navigation to add edit note screen
                final result = await Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const AddEditNoteScreen()));
                if (result == true) {
                  vm.loadNotes();
                }
              },
              child: const Icon(Icons.add),
            ),
            body: Buildbody(vm: vm));
      }),
    );
  }
}

class Buildbody extends StatelessWidget {
  final NoteListViewModel vm;

  Buildbody({super.key, required this.vm});

  @override
  Widget build(BuildContext context) {
    if (vm.notes.isEmpty) {
      return const Center(
        child: Text('No notes available.'),
      );
    }

    return Column(
      children: [
        if (vm.isOrderSectionVisible)
          OrderSection(
            noteOrder: vm.order,
            onOrderChange: (noteOrder) => vm.changeOrder(noteOrder),
          ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView.builder(
                itemCount: vm.notes.length,
                itemBuilder: (context, index) {
                  final note = vm.notes[index];
                  return Column(children: [
                    NoteCard(
                      note: note,
                      onDeleteClick: () {
                        vm.deleteNoteById(note.id);
                      },
                      onClickItem: () async {
                        final result = await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  AddEditNoteScreen(noteId: note.id),
                            ));
                        if (result == true) {
                          vm.loadNotes();
                        }
                      },
                    ),
                    const SizedBox(height: 8)
                  ]);
                }),
          ),
        ),
      ],
    );
  }
}
