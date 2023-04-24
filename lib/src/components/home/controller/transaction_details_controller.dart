import 'package:get/get.dart';
import 'package:sprout_mobile/src/api-setup/api_setup.dart';
import 'package:sprout_mobile/src/api/api_response.dart';
import 'package:sprout_mobile/src/components/home/service/home_service.dart';
import 'package:sprout_mobile/src/components/authentication/service/auth_service.dart';
import 'package:sprout_mobile/src/public/services/pdf_service.dart';
import 'package:sprout_mobile/src/public/services/shared_service.dart';

import '../model/transactions_model.dart';

class TransactionDetailsController extends GetxController {
  Transactions? trnx;
  var transaction = Rxn<Transactions>();

  @override
  void onInit() {
    super.onInit();
    trnx = Get.arguments;
    transaction.value = trnx;
    getTransaction();
  }

  @override
  void onReady() async {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future getTransaction() async {
    AppResponse<Transactions> response = await locator
        .get<HomeService>()
        .getTransaction(transaction.value?.slug?.substring(1) ?? "");
    if (response.status) {
      transaction.value = response.data;
    } else if (response.statusCode == 999) {
      AppResponse res = await locator.get<AuthService>().refreshUserToken();
      if (res.status) {
        getTransaction();
      }
    }
  }

  Future<dynamic> shareReceipt(String type) async {
    if (type == "WALLET_TOP_UP") {
      await locator
          .get<SharedService>()
          .shareFile(await generateWalletReceipt());
    } else if (type == "AIRTIME_VTU") {
      await locator
          .get<SharedService>()
          .shareFile(await generateAirtimeReceipt());
    } else if (type == "DEBIT") {
      await locator
          .get<SharedService>()
          .shareFile(await generateDebitReceipt());
    } else {
      await locator.get<SharedService>().shareFile(await generateReceipt());
    }
  }

  Future<dynamic> generateReceipt() async {
    final pdfFile = await locator.get<PdfService>().generateReceipt(
        transaction.value?.transactionAmount.toString() ?? "",
        transaction.value?.type.toString() ?? "",
        transaction.value?.beneficiaryAccountNumber.toString() ?? "",
        transaction.value?.beneficiaryName.toString() ?? "",
        transaction.value?.beneficiaryBankName.toString() ?? "",
        transaction.value?.ref.toString() ?? "",
        transaction.value?.sessionID.toString() ?? "",
        transaction.value?.transactionFee.toString() ?? "",
        transaction.value?.createdAt.toString() ?? "",
        transaction.value?.narration.toString() ?? "",
        transaction.value?.rrn.toString() ?? "",
        transaction.value?.type == "CASH_OUT",
        transaction.value?.responseMessage.toString() ?? "");
    return pdfFile;
  }

  generateBillPaymentReceipt() async {
    final pdfFile = await locator.get<PdfService>().generateBillPaymentReceipt(
          transaction.value?.transactionAmount.toString() ?? "",
          transaction.value?.type.toString() ?? "",
          transaction.value?.smartCardNumber.toString() ?? "",
          transaction.value?.phoneNumber.toString() ?? "",
          transaction.value?.accountNumber.toString() ?? "",
          transaction.value?.group.toString() ?? "",
          transaction.value?.bundle.toString() ?? "",
          transaction.value?.ref.toString() ?? "",
          transaction.value?.transactionFee.toString() ?? "",
          transaction.value?.agentCut.toString() ?? "",
          transaction.value?.createdAt.toString() ?? "",
          transaction.value?.narration.toString() ?? "",
          transaction.value?.responseMessage.toString() ?? "",
        );
    return pdfFile;
  }

  generateDebitReceipt() async {
    final pdfFile = await locator.get<PdfService>().generateDebitReceipt(
          transaction.value?.totalAmount.toString() ?? "",
          transaction.value?.type.toString() ?? "",
          transaction.value?.ref.toString() ?? "",
          transaction.value?.transactionFee.toString() ?? "",
          transaction.value?.postBalance.toString() ?? "",
          transaction.value?.createdAt.toString() ?? "",
          transaction.value?.narration.toString() ?? "",
          transaction.value?.responseMessage.toString() ?? "",
        );
    return pdfFile;
  }

  generateAirtimeReceipt() async {
    final pdfFile = await locator.get<PdfService>().generateAirtimeReceipt(
        transaction.value?.transactionAmount.toString() ?? "",
        transaction.value?.type.toString() ?? "",
        transaction.value?.phoneNumber.toString() ?? "",
        transaction.value?.serviceType!.split("_").join(" ") ?? "",
        transaction.value?.ref.toString() ?? "",
        transaction.value?.transactionFee.toString() ?? "",
        transaction.value?.agentCut.toString() ?? "",
        transaction.value?.createdAt.toString() ?? "",
        transaction.value?.responseMessage.toString() ?? "");
    return pdfFile;
  }

  generateWalletReceipt() async {
    final pdfFile = await locator.get<PdfService>().generateWalletReceipt(
        transaction.value?.totalAmount.toString() ?? "",
        transaction.value?.type.toString() ?? "",
        transaction.value?.originatorAccountNumber.toString() ?? "",
        transaction.value?.originatorName.toString() ?? "",
        transaction.value?.bankName.toString() ?? "",
        transaction.value?.ref.toString() ?? "",
        transaction.value?.transactionFee.toString() ?? "",
        transaction.value?.createdAt.toString() ?? "",
        transaction.value?.narration.toString() ?? "",
        transaction.value?.responseMessage.toString() ?? "");
    return pdfFile;
  }
}
