import 'package:flutter_app_with_rest_api/features/post/domain/entityes/post.dart';

abstract class PostRepository {
  Future<List<Post>> getAllPosts();
}
