import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:sprout_mobile/src/api/api_constant.dart';
import 'package:sprout_mobile/src/components/invoice/repository/invoice_repository.dart';

import '../../../api/api.dart';

class InvoiceRepositoryImpl implements InvoiceRepository {
  final Api api = Get.find<Api>();
  @override
  getInvoices() async {
    try {
      return await api.dio.get(
        getInvoicesUrl,
      );
    } on DioError catch (e) {
      return api.handleError(e);
    }
  }
}
