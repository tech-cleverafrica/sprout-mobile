import 'dart:io';

import 'package:dio/dio.dart';
import 'package:sprout_mobile/src/api-setup/api_setup.dart';

import 'package:sprout_mobile/src/api/api_response.dart';
import 'package:sprout_mobile/src/public/model/file_model.dart';
import 'package:sprout_mobile/src/public/repository/shared_repositoryimpl.dart';
import 'package:sprout_mobile/src/public/widgets/custom_loader.dart';

class SharedService {
  Future<AppResponse<dynamic>> uploadAndCommit(
      File? file, String fileType, String loadingMessage) async {
    CustomLoader.show(message: loadingMessage);
    Response response =
        await locator<SharedRepositoryImpl>().uploadAndCommit(file, fileType);
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

  Future<List<String>> allFilesUrl(List<NamedFile> p) async {
    if (p.length > 0) {
      List<String> ps = p.map<String>((e) => e.file ?? "").toList();
      return ps;
    }
    return [];
  }
}
