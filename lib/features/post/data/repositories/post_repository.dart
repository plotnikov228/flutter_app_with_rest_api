import 'package:flutter_app_with_rest_api/features/post/data/models/post_model.dart';
import 'package:flutter_app_with_rest_api/features/post/domain/entityes/post.dart';
import 'package:flutter_app_with_rest_api/features/post/domain/entityes/user.dart';
import 'package:flutter_app_with_rest_api/features/post/domain/repositories/post_repository.dart';

import '../data_sources/connection_info.dart';
import '../data_sources/posts_local_data_source.dart';
import '../data_sources/users_remote_data_source.dart';
import '../data_sources/posts_remote_data_source.dart';


class PostRepositoryImpl implements PostRepository {
  final PostsRemoteDataSource postsDataSource;
  final PostLocalDataSource postLocalDataSource;
  final ConnectionInfo connectionInfo;
  final UsersRemoteDataSource usersRemoteDataSource;

  PostRepositoryImpl({
    required this.postsDataSource,
    required this.postLocalDataSource,
    required this.connectionInfo,
    required this.usersRemoteDataSource,
  });

  @override
  Future<List<Post>> getAllPosts() async {
    try {
      await postLocalDataSource.initDB();
      connectionInfo.connectionAccess();
      List<PostModel> list = await postsDataSource.getPosts();
      List<PostModel> localList = await postLocalDataSource.retrievePosts();
      if (localList.isNotEmpty) {
        for (int i = 1; i < list.length; i++) {
          await postLocalDataSource.updatePosts(list[i]);
        }
      } else {
        for (int i = 1; i < list.length; i++) {
          await postLocalDataSource.insertPosts(list[i]);
        }
      }
      print('connection is ${connectionInfo.connectionState}');
      return await postsDataSource.getPosts();
    } catch (_) {
      postLocalDataSource.initDB();
      connectionInfo.connectionFailure();
      print('connection is ${connectionInfo.connectionState}');
      return await postLocalDataSource.retrievePosts();
    }
  }

  @override
  Future<UserModel> getUser() {
      return usersRemoteDataSource.getUser();
  }
}
