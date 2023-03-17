import 'package:dio/dio.dart';
import 'package:get/get.dart' hide FormData, MultipartFile;
import 'package:get_storage/get_storage.dart';
import 'package:sprout_mobile/src/api/api.dart';
import 'package:sprout_mobile/src/api/api_constant.dart';
import 'package:sprout_mobile/src/components/borow/repository/borrow_repository.dart';

class BorrowRepositoryImpl implements BorrowRepository {
  final Api api = Get.find<Api>();
  final storage = GetStorage();

  @override
  initiateCardlessPayment(requestBody) async {
    try {
      return await api.dio.post(initiateCardlessPaymentUrl, data: requestBody);
    } on DioError catch (e) {
      return api.handleError(e);
    } catch (e) {
      e.printError();
    }
  }

  @override
  saveCardlessPayment(requestBody) async {
    try {
      return await api.dio.post(saveCardlessPaymentUrl, data: requestBody);
    } on DioError catch (e) {
      return api.handleError(e);
    } catch (e) {
      e.printError();
    }
  }
}