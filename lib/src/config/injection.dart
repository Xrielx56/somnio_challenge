import 'package:challenge_somnio/src/src.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

class InjectorManager {
  static Future<void> initConfig({required String baseUrl}) async {
    sl.registerSingleton<DioHttpHelper>(DioHttpHelper(baseUrl: baseUrl));
  }
}
