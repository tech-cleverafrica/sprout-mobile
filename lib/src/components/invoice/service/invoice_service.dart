import 'package:dio/dio.dart';
import 'package:sprout_mobile/src/api-setup/api_setup.dart';
import 'package:sprout_mobile/src/api/api_response.dart';
import 'package:sprout_mobile/src/components/invoice/model/invoice_model.dart';
import 'package:sprout_mobile/src/components/invoice/repository/invoice_repositoryImpl.dart';

class InvoiceService {
  Future<AppResponse<List<Invoice>>> getInvoices() async {
    Response response = await locator<InvoiceRepositoryImpl>().getInvoices();

    int statusCode = response.statusCode ?? 000;
    Map<String, dynamic> responseBody = response.data;
    if (statusCode >= 200 && statusCode <= 300) {
      print("vvv$responseBody");
      return AppResponse<List<Invoice>>(true, statusCode, responseBody,
          Invoice.getList(responseBody["data"]));
    }

    return AppResponse(false, statusCode, {});
  }
}
