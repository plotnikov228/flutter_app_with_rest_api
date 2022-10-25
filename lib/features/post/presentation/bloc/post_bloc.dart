import 'package:flutter_app_with_rest_api/features/post/domain/entityes/post.dart';
import 'package:flutter_app_with_rest_api/features/post/domain/repositories/post_repository.dart';
import 'package:flutter_app_with_rest_api/features/post/domain/usecase/get_post_list.dart';
import 'package:flutter_app_with_rest_api/features/post/presentation/bloc/post_event.dart';
import 'package:flutter_app_with_rest_api/features/post/presentation/bloc/post_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';




class PostBloc extends Bloc<PostEvent, PostState> {
  final GetPostList getPostList;

  PostBloc(initialState, {required this.getPostList}) : super(PostEmptyState()) {

    on<PostsLoadEvent>((event, emit) async {
      emit(PostLoadingState());

      try {
        final List<Post> loadedPostsList = await getPostList.getAllPost();
        emit(PostLoadedState(loadedPosts: loadedPostsList));
      } catch (_) {
        emit(PostErrorState());
      }
    });
  }
}
