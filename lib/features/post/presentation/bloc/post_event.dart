abstract class PostEvent {}

class PostsLoadEvent extends PostEvent{}
class PostsRefreshEvent extends PostEvent{}
class PostsRefreshWithoutRebuildListEvent extends PostEvent{}

