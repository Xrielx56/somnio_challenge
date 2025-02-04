import 'package:challenge_somnio/src/common/common.dart';
import 'package:challenge_somnio/src/features/list_of_post/presentation/providers/cubit/list_post_cubit.dart';
import 'package:challenge_somnio/src/features/list_of_post/presentation/widgets/post_blog_card_widget.dart';
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
    'Post blog card widget',
    (widgetTester) async {
      setUpRepositories(state: TestState.success);
      await widgetTester.pumpWidget(
        BlocProvider(
          create: (_) => ListPostCubit(repository: mockRepository),
          child: const MaterialApp(
            home: PostBlogCardWidget(
              title: 'title',
              subtitle: 'subtitle',
            ),
          ),
        ),
      );

      expect(find.text('title'), findsOne);
      expect(find.text('subtitle'), findsOne);
      expect(find.text('Read more'), findsOne);
      expect(find.byType(Card), findsOneWidget);
      expect(find.byType(ClipRRect), findsOneWidget);
      expect(find.byType(GestureDetector), findsNWidgets(2));

      final actionCard = find.byKey(const Key('action-card'));
      final readMoreAction = find.byKey(const Key('read-more-action'));

      expect(actionCard, findsOneWidget);
      await widgetTester.tap(actionCard);
      await widgetTester.pump();

      expect(readMoreAction, findsOneWidget);
      await widgetTester.tap(readMoreAction);
      await widgetTester.pump();
    },
  );
}
