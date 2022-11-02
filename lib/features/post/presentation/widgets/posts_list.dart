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


        late ScrollController controller;

        void _scrollListener() {
          if (controller.offset >= controller.position.maxScrollExtent &&
              !controller.position.outOfRange) {
            bloc.add(PostsRefreshEvent());
          }
        }

        controller = ScrollController()..addListener(_scrollListener);

        Future<void> _refresh() async {
          bloc.add(PostsRefreshWithoutRebuildListEvent());
          return Future.delayed(const Duration(seconds: 2));
        }

        return RefreshIndicator(
            onRefresh: _refresh,
            key: _refreshIndicatorKey,
            color: Colors.white,
            backgroundColor: Colors.blue,
            strokeWidth: 2.0,
            child: ListView.builder(
                itemCount: state.hasReachedMax ? state.unloadedPosts.length : state.unloadedPosts.length + 1,
                controller: controller,
                itemBuilder: (context, index) {
                  return index >= state.unloadedPosts.length
                      ? Container(
                          alignment: Alignment.center,
                          child: const Center(
                            child: SizedBox(
                              width: 33,
                              height: 33,
                              child: CircularProgressIndicator(
                                strokeWidth: 1.5,
                              ),
                            ),
                          ),
                        )
                      : Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListTile(
                          leading: Text('$index', style: const TextStyle( fontWeight: FontWeight.bold),),
                            title: Column(
                              children: [
                                Text(
                                    'Title: ${state.unloadedPosts[index].title}'),
                                Text('Body: ${state.unloadedPosts[index].body}'),
                              ],
                            ),
                          ),
                      );
                }));
      }
      if (state is PostErrorState) {
        return RefreshIndicator(
            onRefresh: () async {
              bloc.add(PostsRefreshWithoutRebuildListEvent());
            },
            key: _refreshIndicatorKey,
            color: Colors.white,
            backgroundColor: Colors.blue,
            strokeWidth: 4.0,
            child: const Center(
              child: Text('Error'),
            ));
      } else {
        return Container();
      }
    });
  }
}
