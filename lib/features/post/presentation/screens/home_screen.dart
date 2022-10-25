import 'package:flutter/material.dart';
import 'package:flutter_app_with_rest_api/features/post/data/datasources/posts_local_data_source.dart';
import 'package:flutter_app_with_rest_api/features/post/data/datasources/posts_remote_data_source.dart';
import 'package:flutter_app_with_rest_api/features/post/data/repositories/post_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecase/get_post_list.dart';
import '../bloc/post_bloc.dart';
import '../bloc/post_state.dart';
import '../widgets/posts_list.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    PostRepositoryImpl postRepositoryImpl = PostRepositoryImpl(postsDataSource: PostsDataSource(), postLocalDataSource: PostLocalDataSource());
    GetPostList getPostList = GetPostList(postRepositoryImpl);
    return BlocProvider(
          create: (BuildContext context) => PostBloc(PostEmptyState, getPostList: getPostList,
             ),
          child: Scaffold(
              appBar: AppBar(
                title: const Text('Posts'),
              ),
              body: const PostsList()

        ));
  }
}
