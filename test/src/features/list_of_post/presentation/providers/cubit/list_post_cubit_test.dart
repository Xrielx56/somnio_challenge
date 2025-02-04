// import 'package:challenge_somnio/src/common/common.dart';
// import 'package:challenge_somnio/src/features/list_of_post/domain/entities/post_entity.dart';
// import 'package:challenge_somnio/src/features/list_of_post/domain/repositories/list_of_post_repository.dart';
// import 'package:challenge_somnio/src/features/list_of_post/presentation/providers/cubit/list_post_cubit.dart';
// import 'package:dartz/dartz.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:bloc_test/bloc_test.dart';
// import 'package:mocktail/mocktail.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter/material.dart';

// // Mock del repositorio
// class MockListOfPostRepository extends Mock implements ListOfPostRepository {}

// // Mock del BuildContext (ya que lo usas para obtener el repositorio)
// class MockBuildContext extends Mock implements BuildContext {}

// enum TestState { success, error }

// void main() {
//   late MockListOfPostRepository mockRepository;
//   late MockBuildContext mockContext;

//   setUp(() {
//     mockRepository = MockListOfPostRepository();
//     mockContext = MockBuildContext();

//     // when(() => RepositoryProvider.of<ListOfPostRepository>(mockContext)).thenReturn(mockRepository);
//   });

//   final mockPosts = [
//     const Post(id: 1, body: 'body 1', title: 'title 1', userId: 1),
//     const Post(id: 2, body: 'body 2', title: 'title 2', userId: 2),
//     const Post(id: 3, body: 'body 3', title: 'title 3', userId: 3),
//   ];

//   void setUpRepositories({required TestState state}) {
//     when(() => mockRepository.fetchLisOfPost()).thenAnswer(
//       (_) async => state == TestState.success ? Right(mockPosts) : Left(HttpResponseError(errorType: '', message: '')),
//     );
//   }

//   group('ListPostCubit', () {
//     blocTest<ListPostCubit, ListPostState>(
//       'emite [loading, loaded] cuando fetchListOfPost es exitoso',
//       build: () {
//         // Simula un resultado exitoso
//         setUpRepositories(state: TestState.success);
//         return ListPostCubit(context: mockContext);
//       },
//       expect: () => [
//         const ListPostState.loading(),
//         ListPostState.loaded(posts: mockPosts),
//       ],
//     );

//     blocTest<ListPostCubit, ListPostState>(
//       'emite [loading, failure] cuando fetchListOfPost falla',
//       build: () {
//         // Simula un fallo
//         setUpRepositories(state: TestState.error);
//         return ListPostCubit(context: mockContext);
//       },
//       expect: () => [
//         const ListPostState.loading(),
//         const ListPostState.failure(),
//       ],
//     );
//   });
// }
