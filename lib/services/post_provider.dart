import 'dart:convert';

import '../model/post.dart';
import 'package:http/http.dart' as http;

class PostProvider {
  Future <List<Post>> getPosts() async {
    final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));

    if(response.statusCode == 200) {
      final List<dynamic> postJson = json.decode(response.body);
      return postJson.map((json) => Post.fromJson(json)).toList();
    } else {
      throw Exception('Error fetching posts');
    }

  }
}