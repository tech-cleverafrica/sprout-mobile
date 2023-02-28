import 'package:dio/dio.dart';
import 'package:get/get.dart' as get_accessor;
import 'package:sprout_mobile/src/api/api_response.dart';
import 'package:sprout_mobile/src/components/authentication/model/response_model.dart';
import '../../../api-setup/api_setup.dart';
import '../../../api/api.dart';
import '../../../public/widgets/custom_loader.dart';
import '../../../reources/repository.dart';
import '../repository/auth_repositoryimpl.dart';

class AuthService {
  final Api api = get_accessor.Get.put(Api(Dio()));
  final Repository repository = get_accessor.Get.put(Repository());
  SignInResponseModel signInResponseModel =
      get_accessor.Get.put(SignInResponseModel(), permanent: true);

  Future<AppResponse<SignInResponseModel>> signIn(
      Map<String, dynamic> requestBody, String loadingMessage) async {
    CustomLoader.show(message: loadingMessage);
    Response response = await locator<AuthRepositoryImpl>().signin(requestBody);
    CustomLoader.dismiss();

    int statusCode = response.statusCode ?? 000;

    Map<String, dynamic> responseBody = response.data;
    if (response.data["status"]) {
      // do some things here
    }

    return AppResponse(false, statusCode, responseBody);
  }
}
