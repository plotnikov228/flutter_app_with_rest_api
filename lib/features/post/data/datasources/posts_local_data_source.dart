import 'dart:async';

import 'package:flutter_app_with_rest_api/features/post/data/models/post_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class PostLocalDataSource {
  static final PostLocalDataSource _databaseHelper = PostLocalDataSource._();

  PostLocalDataSource._();

  late Database db;

  factory PostLocalDataSource() {
    return _databaseHelper;
  }

  Future<void> initDB() async {
    db = await openDatabase(
      join(await getDatabasesPath(), 'users_demo.db'),
      onCreate: (database, version) async {
        await database.execute(
          'CREATE TABLE dishes (userId INTEGER PRIMARY KEY, id INTEGER NOT NULL, title TEXT NOT NULL, body TEXT NULL)',
        );
      },
      version: 1,
    );
  }

  Future<int> insertPosts(PostModel postModel) async {
    int result = await db.insert('posts', postModel.toJson());
    return result;
  }

  Future updatePosts(List<PostModel> postModelList) async {
    for (int i = 1; i <= postModelList.length; i++) {
      return await _databaseHelper.db.update("posts", postModelList[i].toJson(),
          where: "id = ?", whereArgs: [postModelList[i].id]);
    }
  }

  Future<List<PostModel>> retrievePosts() async {
    final List<Map<String, Object?>> queryResult = await db.query('posts');
    return queryResult.map((e) => PostModel.fromJson(e)).toList();
  }
}
