import 'package:dio/dio.dart';
import 'package:get/get.dart' hide FormData, MultipartFile;
import 'package:get_storage/get_storage.dart';
import 'package:sprout_mobile/src/api/api.dart';
import 'package:sprout_mobile/src/api/api_constant.dart';
import 'package:sprout_mobile/src/components/complete-account-setup/repository/complete_account_setup_repository.dart';

class CompleteAccountSetupRepositoryImpl
    implements CompleteAccountSetupRepository {
  final Api api = Get.find<Api>();
  final storage = GetStorage();

  @override
  requestVerification(requestBody) async {
    try {
      String id = storage.read("userId");
      return await api.dio
          .patch(requestVerificationUrl + id, data: requestBody);
    } on DioError catch (e) {
      return api.handleError(e);
    } catch (e) {
      e.printError();
    }
  }
}
