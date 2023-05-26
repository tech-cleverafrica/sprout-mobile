import 'dart:io';

import 'package:dio/dio.dart';
import 'package:get/get.dart' hide FormData, MultipartFile;
import 'package:sprout_mobile/api/api_constant.dart';
import 'package:mime/mime.dart';
import 'package:http_parser/http_parser.dart';
import 'package:sprout_mobile/components/invoice/repository/invoice_repository.dart';

import '../../../api/api.dart';

class InvoiceRepositoryImpl implements InvoiceRepository {
  final Api api = Get.find<Api>();
  @override
  getInvoices(String statusFilter, Map<String, dynamic> timeFilter) async {
    try {
      return await api.dio.get(
        timeFilter['startDate'] != null && timeFilter['endDate'] != null
            ? getInvoicesUrl +
                statusFilter +
                "&startDate=" +
                timeFilter['startDate'] +
                "&endDate=" +
                timeFilter['endDate']
            : getInvoicesUrl + statusFilter,
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

  @override
  getInvoiceBusinessInfo() async {
    try {
      return await api.dio.get(invoiceBusinessInfoUrl);
    } on DioError catch (e) {
      return api.handleError(e);
    }
  }

  @override
  uploadInvoiceBusinessLogo(File? image) async {
    try {
      final mimeTypeData =
          lookupMimeType(image!.path, headerBytes: [0xFF, 0xD8])!.split('/');
      FormData formData = FormData.fromMap({
        "business_logo": await MultipartFile.fromFile(image.path,
            contentType: MediaType(mimeTypeData[0], mimeTypeData[1])),
      });
      return await api.dio.patch(uploadInvoiceBusinessLogoUrl, data: formData);
    } on DioError catch (e) {
      return api.handleError(e);
    } catch (e) {
      e.printError();
    }
  }

  @override
  removeInvoiceBusinessLogo() async {
    try {
      return await api.dio.patch(removeInvoiceBusinessLogoUrl);
    } on DioError catch (e) {
      return api.handleError(e);
    } catch (e) {
      e.printError();
    }
  }

  @override
  updateBusinessInfo(
      String name, String phone, String email, String address) async {
    try {
      FormData formData = FormData.fromMap({
        "businessAddress": address,
        "businessName": name,
        "phone": phone,
        "email": email,
      });
      return await api.dio.patch(updateBusinessInfoUrl, data: formData);
    } on DioError catch (e) {
      return api.handleError(e);
    } catch (e) {
      e.printError();
    }
  }

  @override
  createInvoice(Map<String, dynamic> requestBody) async {
    try {
      return await api.dio.post(createInvoiceUrl, data: requestBody);
    } on DioError catch (e) {
      return api.handleError(e);
    } catch (e) {
      e.printError();
    }
  }

  @override
  markInvoiceAsPaid(String id) async {
    try {
      return await api.dio.patch(markInvoiceAsPaidUrl + id);
    } on DioError catch (e) {
      return api.handleError(e);
    } catch (e) {
      e.printError();
    }
  }

  @override
  markInvoiceAsNotPaid(String id) async {
    try {
      return await api.dio.patch(markInvoiceAsNotPaidUrl + id);
    } on DioError catch (e) {
      return api.handleError(e);
    } catch (e) {
      e.printError();
    }
  }

  @override
  markInvoiceAsPartialPaid(Map<String, dynamic> requestBody) async {
    try {
      return await api.dio
          .patch(markInvoiceAsPartialPaidUrl, data: requestBody);
    } on DioError catch (e) {
      return api.handleError(e);
    } catch (e) {
      e.printError();
    }
  }

  @override
  downloadInvoice(String invoiceId) async {
    try {
      return await api.dio.get(downloadInvoiceUrl + invoiceId);
    } on DioError catch (e) {
      return api.handleError(e);
    } catch (e) {
      e.printError();
    }
  }

  @override
  sendInvoice(Map<String, dynamic> requestBody) async {
    try {
      return await api.dio.post(sendInvoiceUrl, data: requestBody);
    } on DioError catch (e) {
      return api.handleError(e);
    } catch (e) {
      e.printError();
    }
  }
}