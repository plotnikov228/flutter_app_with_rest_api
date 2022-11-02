import 'dart:convert';

import 'package:flutter_app_with_rest_api/features/post/data/models/user_model.dart';
import 'package:http/http.dart' as http;

class UsersRemoteDataSource {
  Future <UserModelImpl> getUser() async {
    final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));

    if(response.statusCode == 200) {
      final dynamic userJson = json.decode(response.body);
      return userJson.map((json) => UserModelImpl.fromJson(json));
    } else {
      throw Exception('Error fetching posts');
    }

  }
}