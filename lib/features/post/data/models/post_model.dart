import 'package:flutter_app_with_rest_api/features/post/domain/entityes/post.dart';

class PostModel extends Post {
  PostModel(
      {required int userId,
      required int id,
      required String title,
      required String body})
      : super(userId: userId, id: id, title: title, body: body);

  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
        userId: json['userId'],
        id: json['id'],
        title: json['title'],
        body: json['body']);
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'id': id,
      'title': title,
      'body': body
    };
}
}
