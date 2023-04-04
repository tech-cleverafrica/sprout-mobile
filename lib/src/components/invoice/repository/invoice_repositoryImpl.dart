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

  @override
  getInvoice(String invoiceId) async {
    try {
      return await api.dio.get(
        getInvoicesUrl + "/serial/" + invoiceId,
      );
    } on DioError catch (e) {
      return api.handleError(e);
    }
  }

  @override
  getCustomers() async {
    try {
      return await api.dio.get(invoiceCustomersUrl);
    } on DioError catch (e) {
      return api.handleError(e);
    }
  }

  @override
  addCustomer(Map<String, dynamic> requestBody) async {
    try {
      return await api.dio.post(createCustomerUrl, data: requestBody);
    } on DioError catch (e) {
      return api.handleError(e);
    } catch (e) {
      e.printError();
    }
  }

  @override
  updateCustomer(Map<String, dynamic> requestBody, String id) async {
    try {
      return await api.dio
          .patch(updateCustomerUrl + "/" + id, data: requestBody);
    } on DioError catch (e) {
      return api.handleError(e);
    } catch (e) {
      e.printError();
    }
  }
}
