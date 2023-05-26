import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:neon_circular_timer/neon_circular_timer.dart';
import 'package:sprout_mobile/public/widgets/general_widgets.dart';
import 'package:sprout_mobile/utils/app_svgs.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

import '../../../utils/app_colors.dart';
import '../../../utils/app_images.dart';
import '../../../utils/helper_widgets.dart';

class OTPScreen extends StatefulWidget {
  OTPScreen({super.key});

  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  //for the timer
  final CountDownController controller = new CountDownController();

  // for the onscreen pad
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
    borderSide: BorderSide(color: AppColors.black, width: 5.0),
  );

  int pinIndex = 0;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                StepProgressIndicator(
                  totalSteps: 4,
                  currentStep: 4,
                  size: 3,
                  roundedEdges: Radius.circular(10),
                  selectedColor: AppColors.mainGreen,
                  unselectedColor: AppColors.grey,
                  padding: 4,
                ),
                addVerticalSpace(24.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                        onPressed: () {
                          Get.back();
                        },
                        icon: Icon(
                          Icons.arrow_back,
                          size: 30,
                        )),
                    Image.asset(
                      AppImages.question,
                      height: 20,
                      color: isDarkMode ? AppColors.white : AppColors.black,
                    ),
                  ],
                ),
                addVerticalSpace(20.h),
                Text(
                  'Enter OTP',
                  style: theme.textTheme.headline1,
                ),
                addVerticalSpace(10.h),
                Container(
                  width: 300.w,
                  child: Text(
                    "Confirm your email address by entering otp sent to your mail",
                    style: TextStyle(
                        fontFamily: "Mont",
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w500,
                        color: isDarkMode
                            ? AppColors.white
                            : AppColors.inputLabelColor),
                  ),
                ),
                addVerticalSpace(40.h),

                //buildExitButton(),
                // Expanded(
                // child:
                Container(
                  // alignment: Alignment(0, 0.5),
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      buildPinRow(),
                      addVerticalSpace(34.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Resend otp in",
                            style: theme.textTheme.subtitle2,
                          ),
                          addHorizontalSpace(15.w),
                          NeonCircularTimer(
                            width: 50,
                            duration: 20,
                            controller: controller,
                            isTimerTextShown: true,
                            neumorphicEffect: false,
                            strokeWidth: 2,
                            neon: 1,
                            textStyle: TextStyle(color: AppColors.greyText),
                            textFormat: TextFormat.S,
                            innerFillColor: AppColors.grey,
                            outerStrokeColor: AppColors.black,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                addVerticalSpace(37.h),
                //),
                buildnumberPad(isDarkMode),
              ],
            ),
          ),
        ),
      ),
    );
  }

  buildnumberPad(bool isDark) {
    return Container(
      //alignment: Alignment.bottomCenter,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 20.0),
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
    //);
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
    if (pinIndex == 4) {
      log(":::::::::: navigation here");
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
