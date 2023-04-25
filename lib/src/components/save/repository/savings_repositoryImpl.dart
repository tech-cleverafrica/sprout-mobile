import 'package:dio/dio.dart';
import 'package:get/get.dart' hide FormData, MultipartFile;
import 'package:sprout_mobile/src/api/api_constant.dart';
import 'package:sprout_mobile/src/components/save/repository/savings_repository.dart';

import '../../../api/api.dart';

class SavingsRepositoryImpl implements SavingsRepository {
  final Api api = Get.find<Api>();
  @override
  getPlans() async {
    try {
      return await api.dio.get(plansUrl);
    } on DioError catch (e) {
      return api.handleError(e);
    }
  }

  getRateOptions() async {
    try {
      return await api.dio.get(rateOptionsUrl);
    } on DioError catch (e) {
      return api.handleError(e);
    }
  }
}