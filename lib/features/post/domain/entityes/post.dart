import 'package:equatable/equatable.dart';

class Post extends Equatable {
  final int userId;
  final int id;
  final String title;
  final String body;

  Post({required this.userId,
      required this.id,
      required this.title,
      required this.body})
      : super([userId, id, title, body]);
}
