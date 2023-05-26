import 'package:dio/dio.dart';

import 'package:sprout_mobile/api/api_response.dart';
import 'package:sprout_mobile/components/help/model/catergories_model.dart';
import 'package:sprout_mobile/components/help/model/issues_model.dart';
import 'package:sprout_mobile/components/help/model/issues_sub_category_model.dart';
import 'package:sprout_mobile/components/help/model/overview_model.dart';
import 'package:sprout_mobile/public/widgets/custom_loader.dart';
import '../../../api-setup/api_setup.dart';
import '../repository/help_repositoryimpl.dart';

class HelpService {
  Future<AppResponse<List<Categories>>> getCategories() async {
    Response response = await locator.get<HelpRepositoryImpl>().getCategories();
    int statusCode = response.statusCode ?? 000;

    Map<String, dynamic> responseBody = response.data;
    if (response.data["status"]) {
      print(":::::::::$responseBody");
      return AppResponse<List<Categories>>(true, statusCode, responseBody,
          Categories.getList(responseBody["data"]));
    }
    return AppResponse(false, statusCode, responseBody);
  }

  Future<AppResponse<List<IssuesSubCategory>>> getSubCategories(
      String id, String loadingMessage) async {
    CustomLoader.show();
    Response response =
        await locator.get<HelpRepositoryImpl>().getSubCategories(id);
    CustomLoader.dismiss();
    int statusCode = response.statusCode ?? 000;

    Map<String, dynamic> responseBody = response.data;
    if (response.data["status"]) {
      print(":::::::::$responseBody");
      return AppResponse<List<IssuesSubCategory>>(true, statusCode,
          responseBody, IssuesSubCategory.getList(responseBody["data"]));
    }
    return AppResponse(false, statusCode, responseBody);
  }

  Future<AppResponse<Overview>> getOverview() async {
    Response response = await locator.get<HelpRepositoryImpl>().getOverview();
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
        await locator.get<HelpRepositoryImpl>().getIssues(size, param);
    int statusCode = response.statusCode ?? 000;

    Map<String, dynamic> responseBody = response.data;
    if (statusCode >= 200 && statusCode <= 300) {
      print(":::::::::$responseBody");
      return AppResponse<List<Issues>>(
          true, statusCode, responseBody, Issues.getList(responseBody["data"]));
    }
    return AppResponse(false, statusCode, responseBody);
  }

  Future<AppResponse<List<Issues>>> getPendingIssues(int size) async {
    Response response =
        await locator.get<HelpRepositoryImpl>().getPendingIssues(size);
    int statusCode = response.statusCode ?? 000;

    Map<String, dynamic> responseBody = response.data;
    if (statusCode >= 200 && statusCode <= 300) {
      print(":::::::::$responseBody");
      return AppResponse<List<Issues>>(
          true, statusCode, responseBody, Issues.getList(responseBody["data"]));
    }
    return AppResponse(false, statusCode, responseBody);
  }

  Future<AppResponse<Issues>> reopenIssue(
      Map<String, dynamic> requestBody, String id) async {
    CustomLoader.show();
    Response response =
        await locator.get<HelpRepositoryImpl>().reopenIssue(requestBody, id);
    CustomLoader.dismiss();
    int statusCode = response.statusCode ?? 000;

    Map<String, dynamic> responseBody = response.data;
    if (response.data["status"]) {
      print(":::::::::$responseBody");
      return AppResponse<Issues>(true, statusCode, responseBody,
          Issues.fromJson(responseBody["data"]));
    }
    return AppResponse(false, statusCode, responseBody);
  }

  Future<AppResponse<Issues>> updateIssue(
      Map<String, dynamic> requestBody, String id) async {
    CustomLoader.show();
    Response response =
        await locator.get<HelpRepositoryImpl>().updateIssue(requestBody, id);
    CustomLoader.dismiss();
    int statusCode = response.statusCode ?? 000;

    Map<String, dynamic> responseBody = response.data;
    if (response.data["status"]) {
      print(":::::::::$responseBody");
      return AppResponse<Issues>(true, statusCode, responseBody,
          Issues.fromJson(responseBody["data"]));
    }
    return AppResponse(false, statusCode, responseBody);
  }

  Future<AppResponse<Issues>> submitIssue(
      Map<String, dynamic> requestBody) async {
    CustomLoader.show();
    Response response =
        await locator.get<HelpRepositoryImpl>().submitIssue(requestBody);
    CustomLoader.dismiss();
    int statusCode = response.statusCode ?? 000;

    Map<String, dynamic> responseBody = response.data;
    if (response.data["status"]) {
      print(":::::::::$responseBody");
      return AppResponse<Issues>(true, statusCode, responseBody,
          Issues.fromJson(responseBody["data"]));
    }
    return AppResponse(false, statusCode, responseBody);
  }

  Future<AppResponse<Issues>> submitDispenseError(
      Map<String, dynamic> requestBody) async {
    CustomLoader.show();
    Response response = await locator
        .get<HelpRepositoryImpl>()
        .submitDispenseError(requestBody);
    CustomLoader.dismiss();
    int statusCode = response.statusCode ?? 000;

    Map<String, dynamic> responseBody = response.data;
    if (response.data["status"]) {
      print(":::::::::$responseBody");
      return AppResponse<Issues>(true, statusCode, responseBody,
          Issues.fromJson(responseBody["data"]));
    }
    return AppResponse(false, statusCode, responseBody);
  }
}