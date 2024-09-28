import 'package:noteapp_flutter/domain/model/note.dart';

class NoteModel {
  final String title;
  final String content;
  final int timeStamp;
  final int color;
  final int? id;

  NoteModel({
    required this.title,
    required this.content,
    required this.timeStamp,
    required this.color,
    this.id,
  });

  // Convert Note object to Map to insert into database
  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'content': content,
      'timeStamp': timeStamp,
      'color': color,
      'id': id,
    };
  }

  // Create a Note object from a map
  factory NoteModel.fromMap(Map<String, dynamic> map) {
    return NoteModel(
      title: map['title'],
      content: map['content'],
      timeStamp: map['timeStamp'],
      color: map['color'],
      id: map['id'],
    );
  }

  Note toNote() {
    return Note(
        title: title, content: content, timeStamp: timeStamp, color: color, id: id!);
  }
}
