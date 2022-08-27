import 'package:flutter/material.dart';
import 'package:flutter_app_with_rest_api/model/post_repository.dart';
import 'package:flutter_app_with_rest_api/post_bloc/post_bloc.dart';
import 'package:flutter_app_with_rest_api/post_bloc/post_state.dart';
import 'package:flutter_app_with_rest_api/widgets/posts_list.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
        create: (context) => PostRepository(),
        child: BlocProvider(
          create: (BuildContext context) => PostBloc(PostEmptyState,
              postRepository: context.read<PostRepository>()),
          child: Scaffold(
              appBar: AppBar(
                title: const Text('Posts'),
              ),
              body: const PostsList()

        ) ));
  }
}
