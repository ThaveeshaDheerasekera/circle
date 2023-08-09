import 'dart:io';

class Entry {
  int entry_id;
  String title;
  String content;
  File? image;
  DateTime created_at;
  bool isCollapsed;

  Entry({
    required this.entry_id,
    required this.title,
    required this.content,
    this.image,
    required this.created_at,
    this.isCollapsed = false,
  });
}
