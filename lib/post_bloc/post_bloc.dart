import 'package:flutter_app_with_rest_api/model/post_repository.dart';
import 'package:flutter_app_with_rest_api/post_bloc/post_event.dart';
import 'package:flutter_app_with_rest_api/post_bloc/post_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../model/post.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  final PostRepository postRepository;

  PostBloc(initialState, {required this.postRepository}) : super(PostEmptyState()) {

    on<PostsLoadEvent>((event, emit) async {
      emit(PostLoadingState());

      try {
        final List<Post> loadedPostsList = await postRepository.getAllPosts();
        emit(PostLoadedState(loadedPosts: loadedPostsList));
      } catch (_) {
        emit(PostErrorState());
      }
    });
  }
}
