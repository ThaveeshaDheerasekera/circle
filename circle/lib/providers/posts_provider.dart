import 'package:circle/entities/post.dart';
import 'package:circle/models/posts_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PostsProvider {
  static final postsListProvider = FutureProvider<List<Post>>((ref) async {
    final model = ref.read(postsModelProvider);
    return model.getPostsList();
  });
}
