import 'package:challenge_somnio/src/features/list_of_post/domain/entities/post_entity.dart';
import 'package:challenge_somnio/src/features/list_of_post/domain/repositories/list_of_post_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'list_post_state.dart';
part 'list_post_cubit.freezed.dart';

class ListPostCubit extends Cubit<ListPostState> {
  ListPostCubit({
    // required this.context,
    required this.repository,
  }) : super(const ListPostState.initial()) {
    fetchListOfPost();
  }

  final ListOfPostRepository repository;

  Future<void> fetchListOfPost() async {
    emit(const ListPostState.loading());

    final either = await repository.fetchLisOfPost();

    either.fold(
      (failure) {
        emit(const ListPostState.failure());
      },
      (response) {
        emit(ListPostState.loaded(posts: response));
      },
    );
  }
}
