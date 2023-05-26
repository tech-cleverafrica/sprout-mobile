import 'dart:io';

import 'package:dio/dio.dart';
import 'package:get/get.dart' hide FormData, MultipartFile;
import 'package:sprout_mobile/api/api.dart';
import 'package:sprout_mobile/api/api_constant.dart';
import 'package:mime/mime.dart';
import 'package:http_parser/http_parser.dart';
import 'package:sprout_mobile/public/repository/shared_repository.dart';

class SharedRepositoryImpl implements SharedRepository {
  final Api api = Get.find<Api>();

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

  addNotificationID(requestBody) async {
    try {
      return await api.dio.post(notificationUrl, data: requestBody);
    } on DioError catch (e) {
      return api.handleError(e);
    }
  }
}
