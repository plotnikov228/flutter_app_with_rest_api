import 'dart:convert';

import 'package:flutter_app_with_rest_api/features/post/data/models/post_model.dart';
import 'package:http/http.dart' as http;

class PostsRemoteDataSource {
  Future <List<PostModel>> getPosts() async {
    final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));

    if(response.statusCode == 200) {
      final List<dynamic> postJson = json.decode(response.body);
      return postJson.map((json) => PostModel.fromJson(json)).toList();
    } else {
      throw Exception('Error fetching posts');
    }

  }
}