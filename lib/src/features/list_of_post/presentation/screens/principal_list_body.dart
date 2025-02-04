import 'package:challenge_somnio/src/features/list_of_post/presentation/providers/cubit/list_post_cubit.dart';
import 'package:challenge_somnio/src/features/list_of_post/presentation/widgets/post_blog_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PrincipalListBody extends StatelessWidget {
  const PrincipalListBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ListPostCubit, ListPostState>(
      builder: (context, state) {
        return state.when(
          initial: () => const Center(child: CircularProgressIndicator.adaptive()),
          loading: () => const Center(child: CircularProgressIndicator.adaptive()),
          loaded: (posts) => SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: posts
                    .map(
                      (post) => PostBlogCardWidget(
                        title: post.title,
                        subtitle: post.body,
                      ),
                    )
                    .toList(),
              ),
            ),
          ),
          failure: () => const Center(
            child: Text('Failure'),
          ),
        );
      },
    );
  }
}
