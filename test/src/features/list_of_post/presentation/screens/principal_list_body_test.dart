import 'package:challenge_somnio/src/features/list_of_post/presentation/providers/cubit/list_post_cubit.dart';
import 'package:challenge_somnio/src/features/list_of_post/presentation/screens/principal_list_body.dart';
import 'package:challenge_somnio/src/features/list_of_post/presentation/widgets/post_blog_card_widget.dart';
import 'package:challenge_somnio/src/src.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../../utils/common_variable.dart';

void main() {
  late MockListOfPostRepository mockRepository;

  setUp(() {
    mockRepository = MockListOfPostRepository();
  });

  void setUpRepositories({required TestState state}) {
    when(() => mockRepository.fetchLisOfPost()).thenAnswer(
      (_) async => state == TestState.success ? Right(mockPosts) : Left(HttpResponseError(errorType: '', message: '')),
    );
  }

  testWidgets(
    'principal list body test with success response',
    (widgetTester) async {
      setUpRepositories(state: TestState.success);

      await widgetTester.pumpWidget(
        BlocProvider(
          create: (_) => ListPostCubit(repository: mockRepository),
          child: const MaterialApp(
            home: PrincipalListBody(),
          ),
        ),
      );

      expect(find.byType(CircularProgressIndicator), findsOneWidget);

      await widgetTester.pump();
      await widgetTester.pumpAndSettle();

      expect(find.byType(SingleChildScrollView), findsOneWidget);
      expect(find.byType(PostBlogCardWidget), findsNWidgets(3));
    },
  );

  testWidgets(
    'principal list body test with error response',
    (widgetTester) async {
      setUpRepositories(state: TestState.error);

      await widgetTester.pumpWidget(
        BlocProvider(
          create: (_) => ListPostCubit(repository: mockRepository),
          child: const MaterialApp(
            home: PrincipalListBody(),
          ),
        ),
      );

      expect(find.byType(CircularProgressIndicator), findsOneWidget);

      await widgetTester.pump();
      await widgetTester.pumpAndSettle();

      expect(find.byType(SingleChildScrollView), findsNothing);
      expect(find.byType(PostBlogCardWidget), findsNothing);
      expect(find.text('Failure'), findsOne);
    },
  );
}
