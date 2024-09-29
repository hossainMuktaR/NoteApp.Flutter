import 'package:flutter/material.dart';
import 'package:noteapp_flutter/domain/model/note.dart';
import 'package:noteapp_flutter/presentation/add_edit_note/add_edit_note_viewmodel.dart';
import 'package:provider/provider.dart';

class AddEditNoteScreen extends StatelessWidget {
  final int? noteId;
  const AddEditNoteScreen({super.key, this.noteId});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AddEditNoteViewmodel(noteId),
      child: Consumer<AddEditNoteViewmodel>(
        builder: (context, vm, child) {
          return _bodybuilder(vm: vm);
        },
      ),
    );
  }
}

class _bodybuilder extends StatefulWidget {
  final AddEditNoteViewmodel vm;
  const _bodybuilder({required this.vm});

  @override
  _bodybuilderState createState() => _bodybuilderState();
}

class _bodybuilderState extends State<_bodybuilder> {
  late TextEditingController _titleController;
  late TextEditingController _contentController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.vm.noteTitle);
    _contentController = TextEditingController(text: widget.vm.noteContent);

    // Set up a listener to update the controllers
    widget.vm.addListener(() {
      _titleController.text = widget.vm.noteTitle;
      _contentController.text = widget.vm.noteContent;
    });
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          widget.vm.saveNote();
          Navigator.pop(context);
        },
        child: const Icon(Icons.save),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Color Picker Row
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: Note.noteColors.map((color) {
                    int colorInt = color.value;
                    return GestureDetector(
                      onTap: () {
                        widget.vm.colorChanged(colorInt);
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 8.0),
                        width: 50.0,
                        height: 50.0,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: color,
                          border: Border.all(
                            color: colorInt == widget.vm.noteColor
                                ? Colors.black
                                : Colors.transparent,
                            width: 3.0,
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
              const SizedBox(height: 16.0),

              // Title Input
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(
                  hintText: "Enter note title",
                  border: InputBorder.none,
                ),
                style: Theme.of(context).textTheme.headlineSmall,
                textInputAction: TextInputAction.next,
                onChanged: (value) => widget.vm.titleChanged(value),
              ),
              const SizedBox(height: 16.0),

              // Content Input
              Expanded(
                child: TextFormField(
                  controller: _contentController,
                  decoration: const InputDecoration(
                    hintText: "Enter note content",
                    border: InputBorder.none,
                  ),
                  maxLines: null,
                  expands: true,
                  style: Theme.of(context).textTheme.bodyMedium,
                  onChanged: (value) => widget.vm.contentChanged(value),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
