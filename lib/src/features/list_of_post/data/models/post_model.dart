import 'dart:convert';

import 'package:challenge_somnio/src/features/list_of_post/domain/entities/post_entity.dart';

class PostModel {
  PostModel({
    required this.userId,
    required this.id,
    required this.title,
    required this.body,
  });

  factory PostModel.fromMap(Map<String, dynamic> json) => PostModel(
        userId: json['userId'] as int,
        id: json['id'] as int,
        title: json['title'] as String,
        body: json['body'] as String,
      );

  factory PostModel.fromJson(String source) => PostModel.fromMap(jsonDecode(source) as Map<String, dynamic>);

  Post toEntity() {
    return Post(id: id, body: body, title: title, userId: userId);
  }

  final int userId;
  final int id;
  final String title;
  final String body;
}
