import 'package:flutter_app_with_rest_api/model/post.dart';
import 'package:flutter_app_with_rest_api/services/post_provider.dart';

class PostRepository {
  final PostProvider _postProvider = PostProvider();
  Future<List<Post>> getAllPosts() => _postProvider.getPosts();
}