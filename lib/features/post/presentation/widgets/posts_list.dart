import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/post_bloc.dart';
import '../bloc/post_event.dart';
import '../bloc/post_state.dart';




class PostsList extends StatelessWidget {
  const PostsList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final PostBloc bloc = context.read<PostBloc>();
    final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
        GlobalKey<RefreshIndicatorState>();
    return BlocBuilder<PostBloc, PostState>(builder: (context, state) {
      if (state is PostEmptyState) {
        return Center(
          child: OutlinedButton(
            child: const Text('Press to load posts'),
            onPressed: () {
              bloc.add(PostsLoadEvent());
            },
          ),
        );
      }
      if (state is PostLoadingState) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }
      if (state is PostLoadedState) {
        return RefreshIndicator(
            onRefresh: () async {
              bloc.add(PostsLoadEvent());
            },
            key: _refreshIndicatorKey,
            color: Colors.white,
            backgroundColor: Colors.blue,
            strokeWidth: 4.0,
            child: Expanded(
                child: ListView.builder(
                    itemCount: 20,
                    itemBuilder: (context, index) => ListTile(
                            title: Card(
                          child: Column(
                            children: [
                              Text(
                                  'User ID: ${state.loadedPosts[index].userId}'),
                              Text('Title: ${state.loadedPosts[index].title}'),
                              Text('Body: ${state.loadedPosts[index].body}'),
                            ],
                          ),
                        )))));
      }
      if (state is PostErrorState) {
        return const Center(
          child: Text('Error'),
        );
      } else {
        return Container();
      }
    });
  }
}
