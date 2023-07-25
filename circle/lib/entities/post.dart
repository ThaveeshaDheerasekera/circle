class Post {
  final int id;
  final String content;
  final String? image;
  final int commentsCount;
  final int likesCount;

  const Post({
    required this.id,
    required this.content,
    this.image,
    required this.commentsCount,
    required this.likesCount,
  });
}
