import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nfc_manager/nfc_manager.dart';
import 'package:sprout_mobile/src/components/borow/controller/nfc_controller.dart';
import 'package:sprout_mobile/src/components/borow/view/nfc_amount_page.dart';
import 'package:sprout_mobile/src/components/borow/view/widgets.dart';
import 'package:sprout_mobile/src/public/widgets/custom_loader.dart';
import 'package:sprout_mobile/src/public/widgets/general_widgets.dart';
import 'package:sprout_mobile/src/utils/app_colors.dart';
import 'package:sprout_mobile/src/utils/app_svgs.dart';
import 'package:sprout_mobile/src/utils/helper_widgets.dart';
import 'package:get/get.dart';
import 'package:sprout_mobile/src/utils/nav_function.dart';

// ignore: must_be_immutable
class NFCScreen extends StatelessWidget {
  NFCScreen({super.key});

  late NfcController nfcController;
  static const platform = const MethodChannel('flutter.native/helper');

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    nfcController = Get.put(NfcController());

    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              getHeader(isDarkMode),
              addVerticalSpace(52.h),
              Container(
                alignment: Alignment.center,
                width: 162.w,
                child: Text("Please tap the icon below to initiate payment",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontFamily: "DMSans",
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w500,
                        color:
                            isDarkMode ? AppColors.greyText : AppColors.black)),
              ),
              addVerticalSpace(56.h),
              InkWell(
                onTap: () => initializeNetPOS(context),
                child: Container(
                  height: 222.h,
                  width: 222.w,
                  decoration: BoxDecoration(
                      color: isDarkMode
                          ? AppColors.greyDot.withOpacity(0.5)
                          : AppColors.grey.withOpacity(0.3),
                      shape: BoxShape.circle),
                  child: Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Container(
                      decoration: BoxDecoration(
                          color: isDarkMode
                              ? AppColors.greyDot.withOpacity(0.7)
                              : AppColors.grey.withOpacity(0.5),
                          shape: BoxShape.circle),
                      child: Padding(
                        padding: const EdgeInsets.all(30.0),
                        child: Container(
                          decoration: BoxDecoration(
                              color: isDarkMode
                                  ? AppColors.greyDot.withOpacity(0.9)
                                  : AppColors.grey.withOpacity(0.7),
                              shape: BoxShape.circle),
                          child: Center(
                            child: SvgPicture.asset(AppSvg.nfc),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> initializeNetPOS(BuildContext context) async {
    nfcController = Get.put(NfcController());
    if (Platform.isIOS) {
      print("HEY 1");
      showNFCFeedback(
          context,
          "Tap-to-Pay Service",
          "An NFC enabled android device will be required to use this service. The Tap-to-Pay (Soft POS) service enables you to process card transactions through your Clevermoni app.\n\nThank you.",
          false);
    } else {
      print("HEY 2");
      bool isNFCEnabled = await NfcManager.instance.isAvailable();
      if (isNFCEnabled && nfcController.bankTID == "") {
        print("HEY 3");
        nfcController.getUserInfo().then((value) => setUserData(context));
      } else if (isNFCEnabled) {
        // } else if (!isNFCEnabled) {
        print("HEY 4");
        print(nfcController.bankTID);
        showNFCFeedback(
            context,
            "Tap-to-Pay Service",
            "An NFC enabled android device will be required to use this service. The Tap-to-Pay (Soft POS) service enables you to process card transactions through your Clevermoni app.\n\nThank you.",
            false);
      } else {
        setUserData(context);
      }
    }
  }

  Future<void> setUserData(BuildContext context) async {
    nfcController = Get.put(NfcController());
    if (nfcController.bankTID == "") {
      showNFCFeedback(
          context,
          "Tap-to-Pay Service",
          'The Tap-to-Pay (Soft POS) service enables you to process card transactions through your Clevermoni app. To request for this service, please click the "Request" button below. You will be notified once your request has been approved.\n\nThank you.',
          true);
    } else {
      try {
        CustomLoader.show(message: "Please wait");
        final result = await platform.invokeMethod("setUserData", {
          "terminalId": nfcController.bankTID,
          "businessName": nfcController.businessName,
          "businessAddress": nfcController.businessAddress,
          "customerName": nfcController.customerName,
        });
        if (result != null) {
          CustomLoader.dismiss();
          push(page: NfcAmountScreen());
        }
      } on PlatformException catch (e) {
        CustomLoader.dismiss();
        submitCallback(context, e.code, e.message ?? "");
      }
    }
  }

  void showNFCFeedback(
      BuildContext context, String title, String message, bool expanded) {
    nfcController = Get.put(NfcController());
    Future.delayed(
        Duration(microseconds: 500),
        () => showDialog(
              context: (context),
              builder: (BuildContext context) => NFCFeedback(
                  title: title,
                  message: message,
                  expanded: expanded,
                  request: nfcController.requestTerminalId),
            ));
  }

  void submitCallback(BuildContext context, String title, String message) {
    Future.delayed(
        Duration(microseconds: 500),
        () => showDialog(
              context: context,
              barrierDismissible: true,
              builder: (BuildContext context) =>
                  CardlessFeedback(title: title, message: message),
            ));
  }
}
