import 'package:get/get.dart';
import 'package:sprout_mobile/src/api-setup/api_setup.dart';
import 'package:sprout_mobile/src/api/api_response.dart';
import 'package:sprout_mobile/src/components/home/model/transactions_model.dart';
import 'package:sprout_mobile/src/components/pay-bills/controller/billers_controller.dart';
import 'package:sprout_mobile/src/components/pay-bills/controller/packages_controller.dart';
import 'package:sprout_mobile/src/components/pay-bills/service/pay_bills_service.dart';
import 'package:sprout_mobile/src/components/authentication/service/auth_service.dart';
import 'package:sprout_mobile/src/public/widgets/custom_toast_notification.dart';

class PaymentController extends GetxController {
  final BillersController billersController = Get.put(BillersController());
  final PackagesController packagesController = Get.put(PackagesController());

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
    String route = packagesController.getPaymentRoute();
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
    String digitKey = packagesController.getDigitKey();
    return {
      "transactionPin": transactionPin,
      digitKey: packagesController.digitController.text,
      "packageSlug": packagesController.package.value!.slug,
      "biller": packagesController.biller.value!.slug,
      "amount":
          packagesController.amountController.value!.text.split(",").join(),
      "subscriberPhone": packagesController.phoneNumberController.text,
      "customerName": customer.value != true
          ? customer.value["customer"]['customerName']
          : "",
      "beneficiaryName":
          packagesController.beneficiaryNameController.text.isEmpty
              ? customer.value == true
                  ? packagesController.biller.value!.slug
                  : customer.value["customer"]['customerName']
              : packagesController.beneficiaryNameController.text,
    };
  }
}
