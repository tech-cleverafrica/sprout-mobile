import 'package:dio/dio.dart';
import 'package:get/get.dart' hide FormData, MultipartFile;
import 'package:get_storage/get_storage.dart';
import 'package:sprout_mobile/api/api.dart';
import 'package:sprout_mobile/api/api_constant.dart';
import 'package:sprout_mobile/components/profile/repository/profile_repository.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final Api api = Get.find<Api>();
  final storage = GetStorage();

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

  @override
  changePassword(requestBody) async {
    try {
      return await api.dio.patch(changePasswordUrl, data: requestBody);
    } on DioError catch (e) {
      return api.handleError(e);
    } catch (e) {
      e.printError();
    }
  }

  @override
  updateProfilePicture(requestBody) async {
    try {
      String userId = storage.read("userId");
      return await api.dio
          .patch(uploadProfilePictureUrl + userId, data: requestBody);
    } on DioError catch (e) {
      return api.handleError(e);
    } catch (e) {
      e.printError();
    }
  }

  @override
  logout(requestBody) async {
    try {
      return await api.dio.post(logoutUrl, data: requestBody);
    } on DioError catch (e) {
      return api.handleError(e);
    } catch (e) {
      e.printError();
    }
  }
}
