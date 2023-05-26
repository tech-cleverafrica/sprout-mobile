import 'dart:io';

import 'package:dio/dio.dart';
import 'package:sprout_mobile/api-setup/api_setup.dart';
import 'package:sprout_mobile/api/api_response.dart';
import 'package:sprout_mobile/components/invoice/model/invoice_business_info_model.dart';
import 'package:sprout_mobile/components/invoice/model/invoice_customer_model.dart';
import 'package:sprout_mobile/components/invoice/model/invoice_model.dart';
import 'package:sprout_mobile/components/invoice/repository/invoice_repositoryImpl.dart';
import 'package:sprout_mobile/public/widgets/custom_loader.dart';

import '../model/invoice_detail_model.dart';

class InvoiceService {
  Future<AppResponse<List<Invoice>>> getInvoices(
      String statusFilter, Map<String, dynamic> timeFilter) async {
    Response response = await locator
        .get<InvoiceRepositoryImpl>()
        .getInvoices(statusFilter, timeFilter);

    int statusCode = response.statusCode ?? 000;
    Map<String, dynamic> responseBody = response.data;
    if (statusCode >= 200 && statusCode <= 300) {
      print("vvv$responseBody");
      return AppResponse<List<Invoice>>(true, statusCode, responseBody,
          Invoice.getList(responseBody["data"]));
    }

    return AppResponse(false, statusCode, responseBody);
  }

  Future<AppResponse<InvoiceDetail>> getInvoice(String invoiceId) async {
    Response response =
        await locator.get<InvoiceRepositoryImpl>().getInvoice(invoiceId);
    int statusCode = response.statusCode ?? 000;
    Map<String, dynamic> responseBody = response.data;

    if (statusCode >= 200 && statusCode <= 300) {
      print("vvv$responseBody");
      return AppResponse<InvoiceDetail>(
          true, statusCode, responseBody, responseBody);
    }
    return AppResponse(false, statusCode, responseBody);
  }

  Future<AppResponse<List<InvoiceCustomer>>> getInvoiceCustomer() async {
    Response response =
        await locator.get<InvoiceRepositoryImpl>().getCustomers();

    int statusCode = response.statusCode ?? 000;
    Map<String, dynamic> responseBody = response.data;
    if (statusCode >= 200 && statusCode <= 300) {
      print("vvv$responseBody");
      return AppResponse<List<InvoiceCustomer>>(true, statusCode, responseBody,
          InvoiceCustomer.getList(responseBody["data"]));
    }

    return AppResponse(false, statusCode, responseBody);
  }

  Future<AppResponse<dynamic>> addCustomer(
      Map<String, dynamic> requestBody) async {
    CustomLoader.show();
    Response response =
        await locator.get<InvoiceRepositoryImpl>().addCustomer(requestBody);
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
    Response response = await locator
        .get<InvoiceRepositoryImpl>()
        .updateCustomer(requestBody, id);
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
        await locator.get<InvoiceRepositoryImpl>().getInvoiceBusinessInfo();
    CustomLoader.dismiss();
    int statusCode = response.statusCode ?? 000;
    Map<String, dynamic> responseBody = response.data;
    if (statusCode >= 200 && statusCode <= 300) {
      print("vvv$responseBody");
      return AppResponse<InvoiceBusinessInfo>(
          true, statusCode, responseBody, responseBody["data"]);
    }

    return AppResponse(false, statusCode, responseBody);
  }

  Future<AppResponse<InvoiceBusinessInfo>> uploadInvoiceBusinessLogo(
      File? file) async {
    CustomLoader.show();
    Response response = await locator
        .get<InvoiceRepositoryImpl>()
        .uploadInvoiceBusinessLogo(file);
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
        await locator.get<InvoiceRepositoryImpl>().removeInvoiceBusinessLogo();
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

  Future<AppResponse<InvoiceBusinessInfo>> updateBusinessInfo(
      String name, String phone, String email, String address) async {
    CustomLoader.show();
    Response response = await locator
        .get<InvoiceRepositoryImpl>()
        .updateBusinessInfo(name, phone, email, address);
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

  Future<AppResponse<Invoice>> createInvoice(
      Map<String, dynamic> requestBody) async {
    CustomLoader.show();
    Response response =
        await locator.get<InvoiceRepositoryImpl>().createInvoice(requestBody);
    print(response);
    CustomLoader.dismiss();
    int statusCode = response.statusCode ?? 000;

    Map<String, dynamic> responseBody = response.data;
    if (response.data["status"]) {
      print(":::::::::$responseBody");
      return AppResponse<Invoice>(
          true, statusCode, responseBody, responseBody["data"]);
    }
    return AppResponse(false, statusCode, responseBody);
  }

  Future<AppResponse<Invoice>> markInvoiceAsPaid(String id) async {
    CustomLoader.show();
    Response response =
        await locator.get<InvoiceRepositoryImpl>().markInvoiceAsPaid(id);
    print(response);
    CustomLoader.dismiss();
    int statusCode = response.statusCode ?? 000;

    Map<String, dynamic> responseBody = response.data;
    if (response.data["status"]) {
      print(":::::::::$responseBody");
      return AppResponse<Invoice>(
          true, statusCode, responseBody, responseBody["data"]);
    }
    return AppResponse(false, statusCode, responseBody);
  }

  Future<AppResponse<Invoice>> markInvoiceAsNotPaid(String id) async {
    CustomLoader.show();
    Response response =
        await locator.get<InvoiceRepositoryImpl>().markInvoiceAsNotPaid(id);
    print(response);
    CustomLoader.dismiss();
    int statusCode = response.statusCode ?? 000;

    Map<String, dynamic> responseBody = response.data;
    if (response.data["status"]) {
      print(":::::::::$responseBody");
      return AppResponse<Invoice>(
          true, statusCode, responseBody, responseBody["data"]);
    }
    return AppResponse(false, statusCode, responseBody);
  }

  Future<AppResponse<Invoice>> markInvoiceAsPartialPaid(
      Map<String, dynamic> requestBody) async {
    CustomLoader.show();
    Response response = await locator
        .get<InvoiceRepositoryImpl>()
        .markInvoiceAsPartialPaid(requestBody);
    print(response);
    CustomLoader.dismiss();
    int statusCode = response.statusCode ?? 000;

    Map<String, dynamic> responseBody = response.data;
    if (response.data["status"]) {
      print(":::::::::$responseBody");
      return AppResponse<Invoice>(
          true, statusCode, responseBody, responseBody["data"]);
    }
    return AppResponse(false, statusCode, responseBody);
  }

  Future<AppResponse<dynamic>> downloadInvoice(String invoiceId) async {
    CustomLoader.show();
    Response response =
        await locator.get<InvoiceRepositoryImpl>().downloadInvoice(invoiceId);
    CustomLoader.dismiss();
    int statusCode = response.statusCode ?? 000;
    Map<String, dynamic> responseBody = response.data;
    if (statusCode >= 200 && statusCode <= 300) {
      print("vvv$responseBody");
      return AppResponse<dynamic>(true, statusCode, responseBody, responseBody);
    }
    return AppResponse(false, statusCode, responseBody);
  }

  Future<AppResponse<dynamic>> sendInvoice(
      Map<String, dynamic> requestBody) async {
    CustomLoader.show();
    Response response =
        await locator.get<InvoiceRepositoryImpl>().sendInvoice(requestBody);
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
}
