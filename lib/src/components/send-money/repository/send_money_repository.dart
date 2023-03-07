import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:sprout_mobile/src/api/api.dart';
import 'package:sprout_mobile/src/api/api_constant.dart';
import 'package:sprout_mobile/src/components/send-money/repository/send_money_repository_impl.dart';

class SendMoneyRepositoryImpl implements SendMoneyRepository {
  final Api api = Get.find<Api>();
  @override
  getBeneficiaries() async {
    try {
      return await api.dio.get(
        beneficiaryUrl,
      );
    } on DioError catch (e) {
      return api.handleError(e);
    }
  }
}
