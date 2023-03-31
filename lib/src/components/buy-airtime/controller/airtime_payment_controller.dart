import 'package:get/get.dart';
import 'package:sprout_mobile/src/api-setup/api_setup.dart';
import 'package:sprout_mobile/src/api/api_response.dart';
import 'package:sprout_mobile/src/components/buy-airtime/controller/airtime_controller.dart';
import 'package:sprout_mobile/src/components/buy-airtime/controller/airtime_packages_controller.dart';
import 'package:sprout_mobile/src/components/home/model/transactions_model.dart';
import 'package:sprout_mobile/src/components/pay-bills/service/pay_bills_service.dart';
import 'package:sprout_mobile/src/public/widgets/custom_toast_notification.dart';

class AirtimePaymentController extends GetxController {
  final AirtimeController airtimeController = Get.put(AirtimeController());
  final AirtimePackagesController airtimePackagesController =
      Get.put(AirtimePackagesController());

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
        .makePayment(buildRequestModel(pin), route, "Please wait");
    loading.value = false;
    if (response.status) {
      Transactions trans = Transactions.fromJson(response.data["data"]);
      return trans;
    } else {
      CustomToastNotification.show(response.message, type: ToastType.error);
    }
    return false;
  }

  buildRequestModel(String transactionPin) {
    return {
      "transactionPin": transactionPin,
      "phoneNumber": airtimePackagesController.phoneNumberController.text,
      "packageSlug": airtimePackagesController.package.value!.slug,
      "biller": airtimePackagesController.biller.value!.slug,
      "amount": airtimePackagesController.amountController.value!.text
          .split(",")
          .join(),
      "subscriberPhone": airtimePackagesController.phoneNumberController.text,
      "customerName": customer.value != true
          ? customer.value["customer"]['customerName']
          : "",
      "beneficiaryName": customer.value == true
          ? airtimePackagesController.biller.value!.slug
          : customer.value["customer"]['customerName']
    };
  }
}
