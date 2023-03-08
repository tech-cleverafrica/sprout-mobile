import 'dart:io';

import 'package:dio/dio.dart';

import 'package:sprout_mobile/src/api/api_response.dart';
import '../../../api-setup/api_setup.dart';
import '../../../public/widgets/custom_loader.dart';
import '../repository/complete_account_setup_repositoryimpl.dart';

class CompleteAccountSetupService {
  Future<AppResponse<dynamic>> requestVerification(
      Map<String, dynamic> requestBody, String loadingMessage) async {
    CustomLoader.show(message: loadingMessage);
    Response response = await locator<CompleteAccountSetupRepositoryImpl>()
        .requestVerification(requestBody);
    CustomLoader.dismiss();
    int statusCode = response.statusCode ?? 000;

    Map<String, dynamic> responseBody = response.data;
    if (response.data["status"]) {
      print(":::::::::$responseBody");
      return AppResponse<dynamic>(true, statusCode, responseBody, responseBody);
    }
    return AppResponse(false, statusCode, responseBody);
  }

  Future<AppResponse<dynamic>> uploadAndCommit(
      File? file, String fileType, String loadingMessage) async {
    CustomLoader.show(message: loadingMessage);
    Response response = await locator<CompleteAccountSetupRepositoryImpl>()
        .uploadAndCommit(file, fileType);
    CustomLoader.dismiss();
    int statusCode = response.statusCode ?? 000;

    Map<String, dynamic> responseBody = response.data;
    if (response.data["status"]) {
      print(":::::::::$responseBody");
      return AppResponse<dynamic>(true, statusCode, responseBody, responseBody);
    }
    return AppResponse(false, statusCode, responseBody);
  }

  String validateFileSize(File file, int maxSize) {
    final bytes = file.readAsBytesSync().lengthInBytes;
    final kb = bytes / 1024;
    final mb = kb / 1024;
    String message = "";
    if (mb > maxSize) {
      message = 'File size is too large. The maximum allowable file size is ' +
          maxSize.toString() +
          'mb.';
    }
    return message;
  }
}
