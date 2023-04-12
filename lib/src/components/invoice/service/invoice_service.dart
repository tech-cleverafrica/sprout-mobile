import 'dart:io';

import 'package:dio/dio.dart';
import 'package:sprout_mobile/src/api-setup/api_setup.dart';
import 'package:sprout_mobile/src/api/api_response.dart';
import 'package:sprout_mobile/src/components/invoice/model/invoice_business_info_model.dart';
import 'package:sprout_mobile/src/components/invoice/model/invoice_customer_model.dart';
import 'package:sprout_mobile/src/components/invoice/model/invoice_model.dart';
import 'package:sprout_mobile/src/components/invoice/repository/invoice_repositoryImpl.dart';
import 'package:sprout_mobile/src/public/widgets/custom_loader.dart';

import '../model/invoice_detail_model.dart';

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

  Future<AppResponse<InvoiceDetail>> getInvoice(String invoiceId) async {
    Response response =
        await locator<InvoiceRepositoryImpl>().getInvoice(invoiceId);
    int statusCode = response.statusCode ?? 000;
    Map<String, dynamic> responseBody = response.data;

    if (statusCode >= 200 && statusCode <= 300) {
      print("vvv$responseBody");
      return AppResponse<InvoiceDetail>(
          true, statusCode, responseBody, responseBody);
    }
    return AppResponse(false, statusCode, {});
  }

  Future<AppResponse<List<InvoiceCustomer>>> getInvoiceCustomer() async {
    Response response = await locator<InvoiceRepositoryImpl>().getCustomers();

    int statusCode = response.statusCode ?? 000;
    Map<String, dynamic> responseBody = response.data;
    if (statusCode >= 200 && statusCode <= 300) {
      print("vvv$responseBody");
      return AppResponse<List<InvoiceCustomer>>(true, statusCode, responseBody,
          InvoiceCustomer.getList(responseBody["data"]));
    }

    return AppResponse(false, statusCode, {});
  }

  Future<AppResponse<dynamic>> addCustomer(
      Map<String, dynamic> requestBody) async {
    CustomLoader.show();
    Response response =
        await locator<InvoiceRepositoryImpl>().addCustomer(requestBody);
    print(response);
    CustomLoader.dismiss();
    int statusCode = response.statusCode ?? 000;

    Map<String, dynamic> responseBody = response.data;
    if (response.data["status"]) {
      print(":::::::::$responseBody");
      return AppResponse<dynamic>(true, statusCode, responseBody, responseBody);
    }
    return AppResponse(false, statusCode, responseBody);
  }

  Future<AppResponse<dynamic>> updateCustomer(
      Map<String, dynamic> requestBody, String id) async {
    CustomLoader.show();
    Response response =
        await locator<InvoiceRepositoryImpl>().updateCustomer(requestBody, id);
    print(response);
    CustomLoader.dismiss();
    int statusCode = response.statusCode ?? 000;

    Map<String, dynamic> responseBody = response.data;
    if (response.data["status"]) {
      print(":::::::::$responseBody");
      return AppResponse<dynamic>(true, statusCode, responseBody, responseBody);
    }
    return AppResponse(false, statusCode, responseBody);
  }

  Future<AppResponse<InvoiceBusinessInfo>> getInvoiceBusinessInfo() async {
    CustomLoader.show();
    Response response =
        await locator<InvoiceRepositoryImpl>().getInvoiceBusinessInfo();
    CustomLoader.dismiss();
    int statusCode = response.statusCode ?? 000;
    Map<String, dynamic> responseBody = response.data;
    if (statusCode >= 200 && statusCode <= 300) {
      print("vvv$responseBody");
      return AppResponse<InvoiceBusinessInfo>(
          true, statusCode, responseBody, responseBody["data"]);
    }

    return AppResponse(false, statusCode, {});
  }

  Future<AppResponse<InvoiceBusinessInfo>> uploadInvoiceBusinessLogo(
      File? file) async {
    CustomLoader.show();
    Response response =
        await locator<InvoiceRepositoryImpl>().uploadInvoiceBusinessLogo(file);
    CustomLoader.dismiss();
    int statusCode = response.statusCode ?? 000;

    Map<String, dynamic> responseBody = response.data;
    if (statusCode >= 200 && statusCode <= 300) {
      print(":::::::::$responseBody");
      return AppResponse<InvoiceBusinessInfo>(
          true, statusCode, responseBody, responseBody["data"]);
    }
    return AppResponse(false, statusCode, responseBody);
  }

  Future<AppResponse<InvoiceBusinessInfo>> removeInvoiceBusinessLogo() async {
    CustomLoader.show();
    Response response =
        await locator<InvoiceRepositoryImpl>().removeInvoiceBusinessLogo();
    CustomLoader.dismiss();
    int statusCode = response.statusCode ?? 000;

    Map<String, dynamic> responseBody = response.data;
    if (statusCode >= 200 && statusCode <= 300) {
      print(":::::::::$responseBody");
      return AppResponse<InvoiceBusinessInfo>(
          true, statusCode, responseBody, responseBody["data"]);
    }
    return AppResponse(false, statusCode, responseBody);
  }
}
