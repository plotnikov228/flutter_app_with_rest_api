import 'dart:io';

import 'package:flutter_app_with_rest_api/features/post/data/data_sources/users_remote_data_source.dart';
import 'package:flutter_app_with_rest_api/features/post/domain/entityes/post.dart';
import 'package:flutter_app_with_rest_api/features/post/domain/usecase/get_post_list.dart';
import 'package:flutter_app_with_rest_api/features/post/presentation/bloc/post_event.dart';
import 'package:flutter_app_with_rest_api/features/post/presentation/bloc/post_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/data_sources/connection_info.dart';
import '../../data/data_sources/posts_local_data_source.dart';
import '../../data/data_sources/posts_remote_data_source.dart';
import '../../data/repositories/post_repository.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  PostBloc(initialState) : super(PostEmptyState()) {
    int quantity = 20;
    bool hasReachedMax = false;
    on<PostsLoadEvent>((event, emit) async {
      PostRepositoryImpl postRepositoryImpl = PostRepositoryImpl(
          postsDataSource: PostsRemoteDataSource(),
          postLocalDataSource: PostLocalDataSource(),
          connectionInfo: ConnectionInfo(),
          usersRemoteDataSource: UsersRemoteDataSource());
      GetPostList getPostList = GetPostList(postRepositoryImpl);
      emit(PostLoadingState());

      try {
        final List<Post> loadedPostsList = await getPostList.getAllPost();
        final List<Post> unloadedPostList = [];
        unloadedPostList
            .addAll(List.generate(quantity, (index) => loadedPostsList[index]));
        emit(PostLoadedState(
            loadedPosts: loadedPostsList, unloadedPosts: unloadedPostList, hasReachedMax: hasReachedMax));
      } catch (_) {
        emit(PostErrorState());
      }
    });

    on<PostsRefreshEvent>((event, emit) async {
      PostRepositoryImpl postRepositoryImpl = PostRepositoryImpl(
          postsDataSource: PostsRemoteDataSource(),
          postLocalDataSource: PostLocalDataSource(),
          connectionInfo: ConnectionInfo(),
          usersRemoteDataSource: UsersRemoteDataSource());
      GetPostList getPostList = GetPostList(postRepositoryImpl);
      try {
        final List<Post> loadedPostsList = await getPostList.getAllPost();
        final List<Post> unloadedPostList = [];
        unloadedPostList
            .addAll(List.generate(quantity, (index) => loadedPostsList[index]));
        if (quantity + 20 < loadedPostsList.length) {
          quantity = quantity + 20;
          hasReachedMax = false;
        } if(quantity == loadedPostsList.length){
          hasReachedMax = false;
        }
        if(quantity + 20 > loadedPostsList.length ){
          quantity = loadedPostsList.length - quantity + quantity;
          hasReachedMax = false;
        }
        emit(PostLoadedState(
            loadedPosts: loadedPostsList, unloadedPosts: unloadedPostList, hasReachedMax: hasReachedMax));
        hasReachedMax = true;
      } catch (_) {
        emit(PostErrorState());
      }
    });

    on<PostsRefreshWithoutRebuildListEvent>((event, emit) async {
      PostRepositoryImpl postRepositoryImpl = PostRepositoryImpl(
          postsDataSource: PostsRemoteDataSource(),
          postLocalDataSource: PostLocalDataSource(),
          connectionInfo: ConnectionInfo(),
          usersRemoteDataSource: UsersRemoteDataSource());
      GetPostList getPostList = GetPostList(postRepositoryImpl);
      try {
        final List<Post> loadedPostsList = await getPostList.getAllPost();
        final List<Post> unloadedPostList = [];
        unloadedPostList
            .addAll(List.generate(quantity, (index) => loadedPostsList[index]));
        emit(PostLoadedState(
            loadedPosts: loadedPostsList, unloadedPosts: unloadedPostList, hasReachedMax: hasReachedMax));
      } catch (_) {}
    });
  }
}
