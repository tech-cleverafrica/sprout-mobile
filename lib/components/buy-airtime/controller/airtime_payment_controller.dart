import 'package:get/get.dart';
import 'package:sprout_mobile/api-setup/api_setup.dart';
import 'package:sprout_mobile/api/api_response.dart';
import 'package:sprout_mobile/components/buy-airtime/controller/airtime_controller.dart';
import 'package:sprout_mobile/components/home/model/transactions_model.dart';
import 'package:sprout_mobile/components/pay-bills/service/pay_bills_service.dart';
import 'package:sprout_mobile/public/widgets/custom_toast_notification.dart';
import 'package:sprout_mobile/components/authentication/service/auth_service.dart';

class AirtimePaymentController extends GetxController {
  final AirtimeController airtimeController = Get.put(AirtimeController());
  // arguments
  var args;
  var customer = Rxn<dynamic>();

  RxBool loading = false.obs;

  @override
  void onInit() {
    super.onInit();
    args = Get.arguments;
    customer.value = args;
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<dynamic> pay(String pin) async {
    String route = "airtime/mobile/purchase";
    loading.value = true;
    AppResponse response = await locator
        .get<PayBillsService>()
        .makePayment(buildRequestModel(pin), route);
    loading.value = false;
    if (response.status) {
      Transactions trans = Transactions.fromJson(response.data["data"]);
      return trans;
    } else if (response.statusCode == 999) {
      AppResponse res = await locator.get<AuthService>().refreshUserToken();
      if (res.status) {
        pay(pin);
      }
    } else {
      CustomToastNotification.show(response.message, type: ToastType.error);
    }
    return false;
  }

  buildRequestModel(String transactionPin) {
    return {
      "transactionPin": transactionPin,
      "phoneNumber": airtimeController.phoneNumberController.text,
      "packageSlug": airtimeController.package.value!.slug,
      "biller": airtimeController.biller.value!.slug,
      "amount":
          airtimeController.amountController.value!.text.split(",").join(),
      "subscriberPhone": airtimeController.phoneNumberController.text,
      "customerName": customer.value != true
          ? customer.value["customer"]['customerName']
          : "",
      "beneficiaryName": customer.value == true
          ? airtimeController.biller.value!.slug
          : customer.value["customer"]['customerName']
    };
  }
}
