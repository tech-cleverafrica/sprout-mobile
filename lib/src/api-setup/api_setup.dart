import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:sprout_mobile/src/api/api.dart';
import 'package:sprout_mobile/src/components/authentication/repository/auth_repositoryimpl.dart';
import 'package:sprout_mobile/src/components/complete-account-setup/repository/complete_account_setup_repositoryimpl.dart';
import 'package:sprout_mobile/src/components/complete-account-setup/service/complete_account_setup_service.dart';
import 'package:sprout_mobile/src/components/help/repository/help_repositoryimpl.dart';
import 'package:sprout_mobile/src/components/help/service/help_service.dart';
import 'package:sprout_mobile/src/components/home/repository/home_repositoryImpl.dart';
import 'package:sprout_mobile/src/components/home/service/home_service.dart';
import 'package:sprout_mobile/src/public/repository/shared_repositoryimpl.dart';
import 'package:sprout_mobile/src/public/services/shared_service.dart';

import '../components/authentication/service/auth_service.dart';

GetIt locator = GetIt.instance;

Future<void> registerApiInstance() async {
  final Api api = Api(Dio());
  Get.put(api);
  api.setUpInterceptors();

  locator.registerLazySingleton<AuthRepositoryImpl>(() => AuthRepositoryImpl());
  locator.registerLazySingleton<AuthService>(() => AuthService());

  locator.registerLazySingleton<HomeRepositoryImpl>(() => HomeRepositoryImpl());
  locator.registerLazySingleton<HomeService>(() => HomeService());

  locator.registerLazySingleton<CompleteAccountSetupRepositoryImpl>(
      () => CompleteAccountSetupRepositoryImpl());
  locator.registerLazySingleton<CompleteAccountSetupService>(
      () => CompleteAccountSetupService());

  locator.registerLazySingleton<HelpRepositoryImpl>(() => HelpRepositoryImpl());
  locator.registerLazySingleton<HelpService>(() => HelpService());

  locator.registerLazySingleton<SharedRepositoryImpl>(
      () => SharedRepositoryImpl());
  locator.registerLazySingleton<SharedService>(() => SharedService());
}
