import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:sprout_mobile/src/api/api.dart';
import 'package:sprout_mobile/src/components/authentication/repository/auth_repositoryimpl.dart';

import '../components/authentication/service/auth_service.dart';

GetIt locator = GetIt.instance;

Future<void> registerApiInstance() async {
  final Api api = Api(Dio());
  Get.put(api);
  api.setUpInterceptors();

  locator.registerLazySingleton<AuthRepositoryImpl>(() => AuthRepositoryImpl());
  locator.registerLazySingleton<AuthService>(() => AuthService());
}
