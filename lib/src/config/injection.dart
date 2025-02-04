import 'package:challenge_somnio/src/features/list_of_post/data/repositories/remote_list_of_post_repository.dart';
import 'package:challenge_somnio/src/features/list_of_post/domain/repositories/list_of_post_repository.dart';
import 'package:challenge_somnio/src/src.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

class InjectorManager {
  static Future<void> initConfig({required String baseUrl}) async {
    sl.registerSingleton<DioHttpHelper>(DioHttpHelper(baseUrl: baseUrl));

    sl.registerSingleton<ListOfPostRepository>(RemoteListOfPostRepository(client: sl.get<DioHttpHelper>()));
  }
}
