import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:sprout_mobile/src/api/api.dart';
import 'package:sprout_mobile/src/api/api_constant.dart';
import 'package:sprout_mobile/src/components/home/repository/home_repository.dart';

class HomeRepositoryImpl implements HomeRepository {
  final Api api = Get.find<Api>();

  @override
  getWallet() async {
    try {
      return await api.dio.get(
        walletUrl,
      );
    } on DioError catch (e) {
      return api.handleError(e);
    }
  }

  @override
  getTransactions() async {
    try {
      return await api.dio.get(
        transactionsUrl,
      );
    } on DioError catch (e) {
      return api.handleError(e);
    }
  }
}
