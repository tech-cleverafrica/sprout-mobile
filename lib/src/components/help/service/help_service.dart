import 'dart:io';

import 'package:dio/dio.dart';

import 'package:sprout_mobile/src/api/api_response.dart';
import 'package:sprout_mobile/src/components/help/model/catergories_model.dart';
import 'package:sprout_mobile/src/components/help/model/issues_model.dart';
import 'package:sprout_mobile/src/components/help/model/overview_model.dart';
import '../../../api-setup/api_setup.dart';
import '../../../public/widgets/custom_loader.dart';
import '../repository/help_repositoryimpl.dart';

class HelpService {
  Future<AppResponse<List<Categories>>> getCategories() async {
    Response response = await locator<HelpRepositoryImpl>().getCategories();
    int statusCode = response.statusCode ?? 000;

    Map<String, dynamic> responseBody = response.data;
    if (response.data["status"]) {
      print(":::::::::$responseBody");
      return AppResponse<List<Categories>>(true, statusCode, responseBody,
          Categories.getList(responseBody["data"]));
    }
    return AppResponse(false, statusCode, responseBody);
  }

  Future<AppResponse<Overview>> getOverview() async {
    Response response = await locator<HelpRepositoryImpl>().getOverview();
    int statusCode = response.statusCode ?? 000;

    Map<String, dynamic> responseBody = response.data;
    if (response.data["status"]) {
      print(":::::::::$responseBody");
      return AppResponse<Overview>(
          true, statusCode, responseBody, Overview.fromJson(responseBody));
    }
    return AppResponse(false, statusCode, responseBody);
  }

  Future<AppResponse<List<Issues>>> getIssues(int size, String param) async {
    Response response =
        await locator<HelpRepositoryImpl>().getIssues(size, param);
    int statusCode = response.statusCode ?? 000;

    Map<String, dynamic> responseBody = response.data;
    print(response.data);
    print("EWEWEWEWEWEWEWEWWEEWWE");
    if (statusCode >= 200 && statusCode <= 300) {
      print(":::::::::$responseBody");
      return AppResponse<List<Issues>>(
          true, statusCode, responseBody, Issues.getList(responseBody["data"]));
    }
    return AppResponse(false, statusCode, responseBody);
  }

  Future<AppResponse<List<Issues>>> getPendingIssues(int size) async {
    Response response =
        await locator<HelpRepositoryImpl>().getPendingIssues(size);
    int statusCode = response.statusCode ?? 000;

    Map<String, dynamic> responseBody = response.data;
    print(response.data);
    print("EWEWEWEWEWEWEWEWWEEWWE");
    if (statusCode >= 200 && statusCode <= 300) {
      print(":::::::::$responseBody");
      return AppResponse<List<Issues>>(
          true, statusCode, responseBody, Issues.getList(responseBody["data"]));
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
