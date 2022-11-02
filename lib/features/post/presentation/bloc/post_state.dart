import '../../domain/entityes/post.dart';

abstract class PostState {}

class PostEmptyState extends PostState{}
class PostLoadingState extends PostState {}
class PostLoadedState extends PostState {
  bool hasReachedMax;
  List<Post> unloadedPosts;
  List<Post> loadedPosts;
  PostLoadedState({required this.loadedPosts, required this.unloadedPosts, required this.hasReachedMax});
}
class PostErrorState extends PostState {}