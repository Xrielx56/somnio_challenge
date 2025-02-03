import 'package:challenge_somnio/src/features/list_of_post/domain/entities/post_entity.dart';
import 'package:challenge_somnio/src/src.dart';
import 'package:dartz/dartz.dart';

typedef Result<T> = Either<HttpResponseError, T>;

abstract class ListOfPostRepository {
  Future<Result<List<Post>>> fetchLisOfPost();
}
