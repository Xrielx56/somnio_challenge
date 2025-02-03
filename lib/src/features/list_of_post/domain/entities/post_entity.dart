import 'package:equatable/equatable.dart';

class Post extends Equatable {
  final int id;
  final int userId;
  final String body;
  final String title;

  const Post({
    required this.id,
    required this.body,
    required this.title,
    required this.userId,
  });

  @override
  List<Object?> get props => [
        id,
        body,
        title,
        userId,
      ];
}
