import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:sprout_mobile/src/api/api.dart';
import 'package:sprout_mobile/src/api/api_constant.dart';
import 'package:sprout_mobile/src/components/fund-wallet/repository/fund_wallet_repository.dart';

class FundWalletRepositoryImpl implements FundWalletRepository {
  final Api api = Get.find<Api>();

  @override
  getCards() async {
    try {
      return await api.dio.get(
        cardsUrl,
      );
    } on DioError catch (e) {
      return api.handleError(e);
    }
  }

  @override
  fundWalletWithNewCard(Map<String, dynamic> requestBody) async {
    try {
      return await api.dio.post(fundWalletWithNewCardUrl, data: requestBody);
    } on DioError catch (e) {
      return api.handleError(e);
    }
  }
}
