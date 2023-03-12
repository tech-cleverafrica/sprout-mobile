import 'package:dio/dio.dart';
import 'package:get/get.dart' hide FormData, MultipartFile;
import 'package:sprout_mobile/src/api/api.dart';
import 'package:sprout_mobile/src/api/api_constant.dart';
import 'package:sprout_mobile/src/components/profile/repository/profile_repository.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final Api api = Get.find<Api>();

  @override
  sendOtp(requestBody) async {
    try {
      return await api.dio.post(sendOtpdUrl, data: requestBody);
    } on DioError catch (e) {
      return api.handleError(e);
    } catch (e) {
      e.printError();
    }
  }

  @override
  changePin(requestBody) async {
    try {
      return await api.dio.patch(changePinUrl, data: requestBody);
    } on DioError catch (e) {
      return api.handleError(e);
    } catch (e) {
      e.printError();
    }
  }

  @override
  createPin(requestBody) async {
    try {
      return await api.dio.post(createPinUrl, data: requestBody);
    } on DioError catch (e) {
      return api.handleError(e);
    } catch (e) {
      e.printError();
    }
  }
}
