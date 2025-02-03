part of 'list_post_cubit.dart';

@freezed
class ListPostState with _$ListPostState {
  const factory ListPostState.initial() = _Initial;
  const factory ListPostState.loading() = _Loading;
  const factory ListPostState.loaded({required List<Post> posts}) = _Loaded;
  const factory ListPostState.failure() = _Failure;
}
