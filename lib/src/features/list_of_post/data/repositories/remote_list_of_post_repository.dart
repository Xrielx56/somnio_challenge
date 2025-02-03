import 'package:challenge_somnio/src/features/list_of_post/data/models/post_model.dart';
import 'package:challenge_somnio/src/features/list_of_post/domain/entities/post_entity.dart';
import 'package:challenge_somnio/src/features/list_of_post/domain/repositories/list_of_post_repository.dart';
import 'package:challenge_somnio/src/src.dart';
import 'package:dartz/dartz.dart';

class RemoteListOfPostRepository extends ListOfPostRepository {
  RemoteListOfPostRepository({
    required DioHttpHelper client,
  }) : _dioHttpHelper = client;

  final DioHttpHelper _dioHttpHelper;

  @override
  Future<Result<List<Post>>> fetchLisOfPost() async {
    final response = await _dioHttpHelper.get('/posts');

    return response.flatMap((response) {
      final data = response.data;

      final postList = List<PostModel>.from(data.map((i) => PostModel.fromMap(i)).toList());

      return right(postList.map((e) => e.toEntity()).toList());
    });
  }
}
