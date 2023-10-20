import 'package:cloud_firestore/cloud_firestore.dart';

class Note {
  final String note_id;
  final String title;
  final String content;
  final DateTime created_at;
  bool isCollapsed;
  bool isFav;

  Note({
    required this.note_id,
    required this.title,
    required this.content,
    required this.created_at,
    this.isCollapsed = false,
    this.isFav = false,
  });

  factory Note.fromJson(Map<String, dynamic> json, String documentId) {
    return Note(
      note_id: documentId ?? '',
      title: json['title'] ?? '',
      content: json['content'] ?? '',
      isCollapsed: json['isCollapsed'],
      isFav: json['isFav'],
      created_at: json['created_at'] != null
          ? (json['created_at'] as Timestamp).toDate()
          : DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() => {
        'noteId': note_id,
        'title': title,
        'note': content,
        'isCollapsed': isCollapsed,
        'isFav': isFav,
        'created_at': created_at,
      };
}
