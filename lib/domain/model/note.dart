import 'package:flutter/material.dart';
import 'package:noteapp_flutter/data/model/note_model.dart';

class Note {
  final String title;
  final String content;
  final int timeStamp;
  final int color;
  final int id;

  Note({
    required this.title,
    required this.content,
    required this.timeStamp,
    required this.color,
    required this.id,
  });

  static const List<Color> noteColors = [
    Colors.orange, // RedOrange
    Colors.lightGreen, // LightGreen
    Colors.yellow, // Violet
    Colors.lightBlue, // BabyBlue
    Colors.pink, // RedPink
  ];
  NoteModel toNoteModel() {
    return NoteModel(
      title: title,
      content: content,
      timeStamp: timeStamp,
      color: color,
      id: id,
    );
  }
}
