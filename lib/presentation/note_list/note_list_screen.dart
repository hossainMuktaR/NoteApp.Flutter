import 'package:flutter/material.dart';
import 'package:noteapp_flutter/presentation/add_edit_note/add_edit_note_screen.dart';
import 'package:noteapp_flutter/presentation/note_list/note_list_viewmodel.dart';
import 'package:noteapp_flutter/presentation/note_list/widget/note_card.dart';
import 'package:provider/provider.dart';

class NoteListScreen extends StatelessWidget {
  const NoteListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('NoteApp'),
        actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.sort))],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // implement navigation to add edit note screen
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const AddEditNoteScreen()));
        },
        child: const Icon(Icons.add),
      ),
      body: ChangeNotifierProvider(
        create: (context) => NoteListViewModel(),
        child: Consumer<NoteListViewModel>(builder: (context, vm, child) {
          // Call loadNotes once the widget tree is fully built
          WidgetsBinding.instance.addPostFrameCallback((_) {
            vm.loadNotes(); // This ensures loadNotes() is called only once
          });

          if (vm.notes.isEmpty) {
            return const Center(
              child: Text('No notes available.'),
            );
          }

          return Padding(
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
                      onClickItem: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  AddEditNoteScreen(noteId: note.id),
                            ));
                      },
                    ),
                    const SizedBox(height: 8)
                  ]);
                }),
          );
        }),
      ),
    );
  }
}
