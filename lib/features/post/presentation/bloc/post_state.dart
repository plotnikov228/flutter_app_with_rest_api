import '../../domain/entityes/post.dart';

abstract class PostState {}

class PostEmptyState extends PostState{}
class PostLoadingState extends PostState {}
class PostLoadedState extends PostState {
  List<Post> loadedPosts;
  PostLoadedState({required this.loadedPosts});
}
class PostErrorState extends PostState {}