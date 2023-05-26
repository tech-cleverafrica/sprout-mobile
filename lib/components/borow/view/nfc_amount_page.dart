import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sprout_mobile/components/borow/controller/nfc_controller.dart';
import 'package:sprout_mobile/components/borow/view/widgets.dart';
import 'package:sprout_mobile/public/widgets/general_widgets.dart';
import 'package:sprout_mobile/utils/global_function.dart';
import 'package:sprout_mobile/utils/helper_widgets.dart';

import '../../../utils/app_colors.dart';

// ignore: must_be_immutable
class NfcAmountScreen extends StatelessWidget {
  NfcAmountScreen({super.key});

  late NfcController nfcController;
  static const platform = const MethodChannel('flutter.native/helper');

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    nfcController = Get.put(NfcController());

    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: Padding(
            padding: const EdgeInsets.only(left: 24, right: 24, bottom: 24),
            child: DecisionButton(
              isDarkMode: isDarkMode,
              buttonText: "Continue",
              onTap: () {
                nfcController.validate().then((value) => {
                      if (value != null)
                        {
                          startNetPOS(context, nfcController.amountToSend,
                              nfcController.bankTID, value["remark"]),
                        }
                    });
              },
            )),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                getHeader(isDarkMode),
                addVerticalSpace(90.h),
                Text(
                  "Enter Amount ($currencySymbol)",
                  style: TextStyle(
                      fontFamily: "Mont",
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w500,
                      color: isDarkMode ? AppColors.white : AppColors.black),
                ),
                Container(
                  child: TextFormField(
                    controller: nfcController.amountController,
                    enabled: true,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontFamily: "Mont",
                        fontSize: 40.sp,
                        fontWeight: FontWeight.w700,
                        color: isDarkMode ? AppColors.white : AppColors.black),
                    keyboardType: TextInputType.number,
                    onChanged: (val) {},
                    onSaved: (val) {},
                    decoration: InputDecoration(
                      border: InputBorder.none,
                    ),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) {
                      if (value!.length == 0)
                        return "Amount is required";
                      else if (double.parse(value.split(",").join("")) == 0) {
                        return "Invalid amount";
                      } else if (double.parse(value.split(",").join("")) < 10) {
                        return "Amount too small";
                      }
                      return null;
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void startNetPOS(BuildContext context, String amountToSend, String bankTID,
      String remark) async {
    nfcController = Get.put(NfcController());
    try {
      final String result = await platform.invokeMethod("virtualPOS",
          {"amount": amountToSend, "terminalId": bankTID, "remark": remark});
      nfcController.validateNext(result);
    } on PlatformException catch (e) {
      submitCallback(context, e.code, e.message ?? "");
    }
  }

  void submitCallback(BuildContext context, String title, String message) {
    Future.delayed(
        Duration(microseconds: 500),
        () => showDialog(
              context: (context),
              builder: (BuildContext context) =>
                  CardlessFeedback(title: title, message: message),
            ));
  }
}
