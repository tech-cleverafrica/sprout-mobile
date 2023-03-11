import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sprout_mobile/src/components/send-money/controller/send_money_controller.dart';
import 'package:sprout_mobile/src/public/screens/successful_transaction.dart';
import 'package:sprout_mobile/src/utils/app_colors.dart';

import '../../utils/app_images.dart';
import '../../utils/app_svgs.dart';
import '../../utils/helper_widgets.dart';
import '../widgets/general_widgets.dart';

// ignore: must_be_immutable
class PinPage extends StatefulWidget {
  String? process;
  PinPage({super.key, required this.process});

  @override
  State<PinPage> createState() => _PinPageState();
}

class _PinPageState extends State<PinPage> {
  List<String> currentPin = ["", "", "", ""];

  TextEditingController pinOneController = TextEditingController();

  TextEditingController pinTwoController = TextEditingController();

  TextEditingController pinThreeController = TextEditingController();

  TextEditingController pinFourController = TextEditingController();

  String pinOneValue = "";

  String pinTwoValue = "";

  String pinThreeValue = "";

  String pinFourValue = "";

  var outlineInputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(100.0),
    borderSide: BorderSide(color: AppColors.transparent, width: 5.0),
  );

  int pinIndex = 0;

  late SendMoneyController sendMoneyController;

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    sendMoneyController = Get.put(SendMoneyController());

    return SafeArea(
      child: Scaffold(
          bottomNavigationBar: Container(
            height: MediaQuery.of(context).size.height * 0.2,
            child: Column(
              children: [
                Image.asset(
                  isDarkMode ? AppImages.sprout_dark : AppImages.sprout_light,
                  height: MediaQuery.of(context).size.height * 0.05,
                ),
                addVerticalSpace(10.h),
                Text("Forgotten Pin?",
                    style: TextStyle(
                      fontFamily: "DMSans",
                      fontSize: 12.sp,
                      fontStyle: FontStyle.italic,
                      color: isDarkMode ? AppColors.grey : AppColors.greyText,
                    ))
              ],
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 24),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  getHeader(isDarkMode),
                  addVerticalSpace(15.h),
                  Center(
                    child: Text(
                      "Enter PIN",
                      style: Theme.of(context).textTheme.headline1,
                    ),
                  ),
                  addVerticalSpace(40.h),
                  buildPinRow(),
                  addVerticalSpace(80.h),
                  buildnumberPad(isDarkMode),
                  addVerticalSpace(30.h),
                ],
              ),
            ),
          )),
    );
  }

  buildnumberPad(bool isDark) {
    return Container(
      //alignment: Alignment.bottomCenter,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 100.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                KeyboardNumber(
                  n: 1,
                  onPressed: () {
                    pinIndexSetup("1");
                  },
                ),
                KeyboardNumber(
                  n: 2,
                  onPressed: () {
                    pinIndexSetup("2");
                  },
                ),
                KeyboardNumber(
                  n: 3,
                  onPressed: () {
                    pinIndexSetup("3");
                  },
                ),
              ],
            ),
            addVerticalSpace(30.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                KeyboardNumber(
                  n: 4,
                  onPressed: () {
                    pinIndexSetup("4");
                  },
                ),
                KeyboardNumber(
                  n: 5,
                  onPressed: () {
                    pinIndexSetup("5");
                  },
                ),
                KeyboardNumber(
                  n: 6,
                  onPressed: () {
                    pinIndexSetup("6");
                  },
                ),
              ],
            ),
            addVerticalSpace(30.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                KeyboardNumber(
                  n: 7,
                  onPressed: () {
                    pinIndexSetup("7");
                  },
                ),
                KeyboardNumber(
                  n: 8,
                  onPressed: () {
                    pinIndexSetup("8");
                  },
                ),
                KeyboardNumber(
                  n: 9,
                  onPressed: () {
                    pinIndexSetup("9");
                  },
                ),
              ],
            ),
            addVerticalSpace(30.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  width: 60.0,
                  child: MaterialButton(
                    onPressed: null,
                    child: SizedBox(),
                  ),
                ),
                KeyboardNumber(
                  n: 0,
                  onPressed: () {
                    pinIndexSetup("0");
                  },
                ),
                Container(
                  width: 60.0,
                  child: MaterialButton(
                    height: 60,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(60.0)),
                    onPressed: () {
                      clearPin();
                    },
                    child: SvgPicture.asset(
                      AppSvg.delete,
                      color: isDark ? AppColors.white : AppColors.black,
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  clearPin() {
    if (pinIndex == 0)
      pinIndex = 0;
    else if (pinIndex == 4) {
      setPin(pinIndex, "");
      currentPin[pinIndex - 1] = "";
      pinIndex--;
    } else {
      setPin(pinIndex, "");
      currentPin[pinIndex - 1] = "";
      pinIndex--;
    }
  }

  pinIndexSetup(String text) {
    if (pinIndex == 0)
      pinIndex = 1;
    else if (pinIndex < 4) pinIndex++;
    setPin(pinIndex, text);
    currentPin[pinIndex - 1] = text;
    String strPin = "";
    currentPin.forEach((e) {
      strPin += e;
    });
    if (pinIndex == 4) {
      print(strPin);
      switch (widget.process) {
        case "transfer":
          sendMoneyController.makeTransafer(strPin);
          break;
        default:
      }
    }
  }

  setPin(int n, String text) {
    switch (n) {
      case 1:
        pinOneController.text = text;
        setState(() {
          pinOneValue = text;
        });
        break;

      case 2:
        pinTwoController.text = text;
        setState(() {
          pinTwoValue = text;
        });
        break;
      case 3:
        pinThreeController.text = text;
        setState(() {
          pinThreeValue = text;
        });
        break;
      case 4:
        pinFourController.text = text;
        setState(() {
          pinFourValue = text;
        });
        break;
    }
  }

  buildPinRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        PINNumber(
          outlineInputBorder: outlineInputBorder,
          textEditingController: pinOneController,
          value: pinOneValue,
        ),
        PINNumber(
          outlineInputBorder: outlineInputBorder,
          textEditingController: pinTwoController,
          value: pinTwoValue,
        ),
        PINNumber(
          outlineInputBorder: outlineInputBorder,
          textEditingController: pinThreeController,
          value: pinThreeValue,
        ),
        PINNumber(
          outlineInputBorder: outlineInputBorder,
          textEditingController: pinFourController,
          value: pinFourValue,
        ),
      ],
    );
  }
}
