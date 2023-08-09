class Entry {
  final int entry_id;
  final String title;
  final String content;
  final String? image;
  final DateTime created_at;
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
