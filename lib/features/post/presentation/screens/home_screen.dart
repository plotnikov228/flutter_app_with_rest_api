import 'package:flutter/material.dart';
import 'package:flutter_app_with_rest_api/features/post/presentation/bloc/post_event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecase/get_post_list.dart';
import '../bloc/post_bloc.dart';
import '../bloc/post_state.dart';
import '../widgets/posts_list.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
          create: (BuildContext context) => PostBloc(PostEmptyState)..add(PostsLoadEvent()),
          child: Scaffold(
              appBar: AppBar(
                title: const Text('Posts'),
              ),
              body: const PostsList()

        ));
  }
}
