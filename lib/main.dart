import 'package:challenge_somnio/src/config/injection.dart';
import 'package:challenge_somnio/src/features/features.dart';
import 'package:challenge_somnio/src/features/list_of_post/data/repositories/remote_list_of_post_repository.dart';
import 'package:challenge_somnio/src/features/list_of_post/domain/repositories/list_of_post_repository.dart';
import 'package:challenge_somnio/src/features/list_of_post/presentation/providers/cubit/list_post_cubit.dart';
import 'package:challenge_somnio/src/src.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

void main() async {
  await InjectorManager.initConfig(baseUrl: 'https://jsonplaceholder.typicode.com');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final dioHelper = GetIt.instance.get<DioHttpHelper>();

    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<ListOfPostRepository>(
          create: (_) => RemoteListOfPostRepository(client: dioHelper),
        ),
      ],
      child: MaterialApp(
        title: 'Challenge Somnio',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          fontFamily: 'Montserrat',
        ),
        home: const HomePage(),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: NestedScrollView(
          floatHeaderSlivers: true,
          headerSliverBuilder: (context, innerBoxIsScrolled) => [
            const SliverAppBar(
              centerTitle: true,
              pinned: true,
              floating: true,
              snap: true,
              title: Column(
                children: [
                  Text('Blog'),
                  SizedBox(height: 5),
                  Text('Challenge Somnio'),
                ],
              ),
              bottom: TabBar(
                indicatorWeight: 5,
                tabs: [
                  Tab(child: Text('Principal')),
                  Tab(child: Text('Recomendados')),
                ],
              ),
            ),
          ],
          body: BlocProvider(
            create: (_) => ListPostCubit(context: context),
            child: const ListOfPostScreen(),
          ),
        ),
      ),
    );
  }
}
