import 'package:challenge_somnio/src/features/list_of_post/domain/entities/post_entity.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test(
    'description',
    () {
      const post = Post(id: 1, body: 'body', title: 'title', userId: 1);

      expect(post, isA<Post>());
    },
  );
}
