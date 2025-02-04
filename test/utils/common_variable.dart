import 'package:challenge_somnio/src/features/list_of_post/domain/entities/post_entity.dart';
import 'package:challenge_somnio/src/features/list_of_post/domain/repositories/list_of_post_repository.dart';

import 'package:mocktail/mocktail.dart';

enum TestState { success, error }

class MockListOfPostRepository extends Mock implements ListOfPostRepository {}

final mockPosts = [
  const Post(id: 1, body: 'body 1', title: 'title 1', userId: 1),
  const Post(id: 2, body: 'body 2', title: 'title 2', userId: 2),
  const Post(id: 3, body: 'body 3', title: 'title 3', userId: 3),
];
