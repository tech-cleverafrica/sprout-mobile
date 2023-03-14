import 'dart:io';

import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sprout_mobile/src/components/fund-wallet/controller/fund_wallet_controller.dart';
import 'package:sprout_mobile/src/components/fund-wallet/view/widget.dart';
import 'package:sprout_mobile/src/public/widgets/custom_toast_notification.dart';
import 'package:sprout_mobile/src/public/widgets/general_widgets.dart';
import 'package:sprout_mobile/src/utils/app_colors.dart';
import 'package:sprout_mobile/src/utils/app_svgs.dart';
import 'package:sprout_mobile/src/utils/helper_widgets.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class FundWalletScreen extends StatelessWidget {
  FundWalletScreen({super.key});

  late FundWalletController fundWalletController;

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    fundWalletController = Get.put(FundWalletController());

    return SafeArea(
      child: Scaffold(
          body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              getHeader(isDarkMode),
              addVerticalSpace(35.h),
              FundWalletCard(
                isDarkMode: isDarkMode,
                flag: AppSvg.nigeria,
                currency: "Naira",
                title: "Available Balance",
                symbol: "N",
                naira: fundWalletController.walletBalance.toString(),
                kobo: "",
                bank: fundWalletController.bankToUse,
                accountNumber: fundWalletController.accountNumberToUse,
                onTap: () => {},
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.07,
              ),
              FundingCard(
                isDarkMode: isDarkMode,
                title: "Transfer from Bank",
                text: "Fund your wallet through bank transfer",
                onTap: () => fundFromBank(
                    context,
                    fundWalletController.accountNumberToUse,
                    fundWalletController.bankToUse,
                    fundWalletController.fullname),
              ),
              addVerticalSpace(24.h),
              FundingCard(
                isDarkMode: isDarkMode,
                title: "Transfer from Card",
                text: "Fund your wallet through debit card",
                onTap: () => {},
              ),
            ],
          ),
        ),
      )),
    );
  }
}

void fundFromBank(BuildContext context, String accountNumberToUse,
    String bankToUse, String fullname) {
  final isDarkMode = Theme.of(context).brightness == Brightness.dark;
  showDialog(
      context: context,
      barrierDismissible: true,
      builder: ((context) {
        return Dialog(
          backgroundColor: isDarkMode ? AppColors.blackBg : AppColors.white,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          child: Container(
            height: 230,
            alignment: Alignment.topLeft,
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: 12),
            margin: EdgeInsets.symmetric(horizontal: 25),
            decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    width: double.infinity,
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Transfer From Bank",
                      style: TextStyle(
                        color: isDarkMode ? AppColors.white : AppColors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.w900,
                        height: 1.5,
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    width: double.infinity,
                    alignment: Alignment.topLeft,
                    color: Colors.transparent,
                    child: Text(
                      "Kindly transfer money to the bank account\ndisplayed below and it will automatically reflect in your wallet.",
                      style: TextStyle(
                        color: isDarkMode ? AppColors.white : AppColors.black,
                        fontSize: 12.sp,
                        height: 1.5,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  SizedBox(height: 5),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(width: 40),
                        Text(
                          bankToUse,
                          style: TextStyle(
                            color:
                                isDarkMode ? AppColors.white : AppColors.black,
                            fontSize: 14.sp,
                            letterSpacing: 1,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        // SizedBox(width: 50),
                        GestureDetector(
                            onTap: () => Platform.isIOS
                                ? Clipboard.setData(
                                        ClipboardData(text: accountNumberToUse))
                                    .then((value) => {
                                          CustomToastNotification.show(
                                              "Account number has been copied successfully",
                                              type: ToastType.success),
                                        })
                                : FlutterClipboard.copy(accountNumberToUse)
                                    .then((value) => {
                                          CustomToastNotification.show(
                                              "Account number has been copied successfully",
                                              type: ToastType.success),
                                        }),
                            child: Container(
                              margin: EdgeInsets.only(top: 15),
                              color: Colors.transparent,
                              width: 40,
                              alignment: Alignment.center,
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SvgPicture.asset(
                                      AppSvg.copy,
                                      height: 20,
                                    ),
                                  ]),
                            ))
                      ]),
                  // SizedBox(height: 5),
                  Text(
                    accountNumberToUse,
                    style: TextStyle(
                      color: isDarkMode ? AppColors.white : AppColors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w900,
                      height: 1.5,
                    ),
                  ),
                  SizedBox(height: 7),
                  Text(
                    fullname,
                    style: TextStyle(
                      color: isDarkMode ? AppColors.white : AppColors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      height: 1.5,
                      letterSpacing: 1,
                    ),
                  ),
                ]),
          ),
        );
      }));
}
