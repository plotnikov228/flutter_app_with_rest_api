import 'package:flutter_app_with_rest_api/features/post/domain/entityes/user.dart';

class UserModelImpl implements UserModel {
  final int id;
  final String name;
  final String username;

  UserModelImpl({required this.id, required this.name, required this.username});

  factory UserModelImpl.fromJson(Map<String, dynamic> json) {
    return UserModelImpl(
        id: json['id'], name: json['name'], username: json['username']);
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name, 'body': username};
  }
}
