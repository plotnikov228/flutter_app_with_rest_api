import 'package:flutter_app_with_rest_api/features/post/data/datasources/posts_local_data_source.dart';
import 'package:flutter_app_with_rest_api/features/post/domain/entityes/post.dart';
import 'package:flutter_app_with_rest_api/features/post/domain/repositories/post_repository.dart';
import 'package:flutter_app_with_rest_api/features/post/data/datasources/posts_remote_data_source.dart';

class PostRepositoryImpl implements PostRepository {
  final PostsDataSource postsDataSource;
  final PostLocalDataSource postLocalDataSource;

  PostRepositoryImpl({required this.postsDataSource, required this.postLocalDataSource});

  @override
  Future<List<Post>> getAllPosts() async{
    postLocalDataSource.initDB();
    try {
      return await postsDataSource.getPosts();
    } catch (_) {
      return postLocalDataSource.retrievePosts();
    }
  }
}