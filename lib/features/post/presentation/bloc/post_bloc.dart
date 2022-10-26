import 'package:flutter_app_with_rest_api/features/post/domain/entityes/post.dart';
import 'package:flutter_app_with_rest_api/features/post/domain/usecase/get_post_list.dart';
import 'package:flutter_app_with_rest_api/features/post/presentation/bloc/post_event.dart';
import 'package:flutter_app_with_rest_api/features/post/presentation/bloc/post_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/datasources/posts_local_data_source.dart';
import '../../data/datasources/posts_remote_data_source.dart';
import '../../data/repositories/post_repository.dart';




class PostBloc extends Bloc<PostEvent, PostState> {
  PostBloc(initialState) : super(PostEmptyState()) {

    on<PostsLoadEvent>((event, emit) async {
      PostRepositoryImpl postRepositoryImpl = PostRepositoryImpl(postsDataSource: PostsDataSource(), postLocalDataSource: PostLocalDataSource());
      GetPostList getPostList = GetPostList(postRepositoryImpl);
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
