import 'package:challenge_somnio/src/features/list_of_post/presentation/screens/principal_list_body.dart';
import 'package:flutter/material.dart';

class ListOfPostScreen extends StatelessWidget {
  const ListOfPostScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return TabBarView(
      children: [
        PrincipalListBody(),
        Center(child: Text('view del segundo tab')),
      ],
    );
  }
}
