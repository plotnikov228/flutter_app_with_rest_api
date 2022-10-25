import 'package:flutter_app_with_rest_api/features/post/domain/entityes/post.dart';
import 'package:flutter_app_with_rest_api/features/post/domain/repositories/post_repository.dart';

class GetPostList {
  final PostRepository postRepository;

  GetPostList(this.postRepository);

  Future<List<Post>> getAllPost() async {
    return await postRepository.getAllPosts();
  }

}