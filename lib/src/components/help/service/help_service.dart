import 'package:dio/dio.dart';

import 'package:sprout_mobile/src/api/api_response.dart';
import 'package:sprout_mobile/src/components/help/model/catergories_model.dart';
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
}
