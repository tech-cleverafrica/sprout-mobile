import 'dart:io';

class InvoiceRepository {
  getInvoices(String statusFilter, Map<String, dynamic> timeFilter) {}
  getInvoice(String invoiceId) {}
  getCustomers() {}
  addCustomer(Map<String, dynamic> requestBody) async {}
  updateCustomer(Map<String, dynamic> requestBody, String id) async {}
  getInvoiceBusinessInfo() async {}
  uploadInvoiceBusinessLogo(File? file) async {}
  updateBusinessInfo(
      String name, String phone, String email, String address) async {}
  removeInvoiceBusinessLogo() async {}
  createInvoice(Map<String, dynamic> requestBody) async {}
  markInvoiceAsPaid(String id) async {}
  markInvoiceAsNotPaid(String id) async {}
  markInvoiceAsPartialPaid(Map<String, dynamic> requestBody) async {}
  downloadInvoice(String invoiceId) async {}
  sendInvoice(Map<String, dynamic> requestBody) async {}
}