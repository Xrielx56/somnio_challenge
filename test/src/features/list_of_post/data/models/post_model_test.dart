import 'package:challenge_somnio/src/features/list_of_post/data/models/post_model.dart';
import 'package:challenge_somnio/src/features/list_of_post/domain/entities/post_entity.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group(
    'Post model test',
    () {
      test(
        'Crear una instancia de PostModel a partir de un mapa',
        () {
          final payload = {
            "userId": 1,
            "id": 1,
            "title": "title",
            "body": "body",
          };

          final postModel = PostModel.fromMap(payload);

          expect(postModel, isA<PostModel>());
          expect(postModel.userId, 1);
          expect(postModel.id, 1);
          expect(postModel.title, 'title');
          expect(postModel.body, 'body');
        },
      );

      test(
        'Crear instancia de PostModel a partir de un String',
        () {
          const jsonString = '''{"userId": 1, "id": 1, "title": "title", "body": "body"}''';

          final postModel = PostModel.fromJson(jsonString);

          expect(postModel, isA<PostModel>());
          expect(postModel.userId, 1);
          expect(postModel.id, 1);
          expect(postModel.title, 'title');
          expect(postModel.body, 'body');
        },
      );

      test(
        'post model to post entity',
        () {
          final postModel = PostModel(userId: 1, id: 1, title: 'title', body: 'body');

          final postEntity = postModel.toEntity();

          expect(postEntity, isA<Post>());
          expect(postEntity.userId, 1);
          expect(postEntity.id, 1);
          expect(postEntity.title, 'title');
          expect(postEntity.body, 'body');
        },
      );
    },
  );
}
