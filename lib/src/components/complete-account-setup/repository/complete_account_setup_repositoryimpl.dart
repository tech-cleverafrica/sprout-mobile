import 'dart:io';

import 'package:dio/dio.dart';
import 'package:get/get.dart' hide FormData, MultipartFile;
import 'package:get_storage/get_storage.dart';
import 'package:sprout_mobile/src/api/api.dart';
import 'package:sprout_mobile/src/api/api_constant.dart';
import 'package:sprout_mobile/src/components/complete-account-setup/repository/complete_account_setup_repository.dart';
import 'package:mime/mime.dart';
import 'package:http_parser/http_parser.dart';

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

  @override
  uploadAndCommit(File? image, String fileType) async {
    try {
      final mimeTypeData =
          lookupMimeType(image!.path, headerBytes: [0xFF, 0xD8])!.split('/');
      FormData formData = FormData.fromMap({
        "file": await MultipartFile.fromFile(image.path,
            filename: fileType,
            contentType: MediaType(mimeTypeData[0], mimeTypeData[1])),
        "documentType": fileType
      });
      return await api.dio.post(uploadUrl, data: formData);
    } on DioError catch (e) {
      return api.handleError(e);
    } catch (e) {
      e.printError();
    }
  }
}
