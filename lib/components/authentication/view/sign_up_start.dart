import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sprout_mobile/components/authentication/controller/signup_controller.dart';
import 'package:sprout_mobile/components/authentication/view/sign_in_screen.dart';
import 'package:sprout_mobile/components/authentication/view/sign_up_personal.dart';
import 'package:sprout_mobile/config/Config.dart';
import 'package:sprout_mobile/public/widgets/custom_button.dart';
import 'package:sprout_mobile/public/widgets/general_widgets.dart';
import 'package:sprout_mobile/utils/app_colors.dart';

import '../../../utils/app_images.dart';
import '../../../utils/helper_widgets.dart';

// ignore: must_be_immutable
class SignUpStart extends StatelessWidget {
  SignUpStart({super.key});

  late SignUpController signUpController;

  @override
  Widget build(BuildContext context) {
    signUpController = Get.put(SignUpController());
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: Container(
                height: MediaQuery.of(context).size.height * 0.9,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Center(
                            child: Image.asset(
                          isDarkMode
                              ? AppImages.sprout_dark
                              : AppImages.sprout_light,
                          height: 27.h,
                        )),
                        addVerticalSpace(30.h),
                        for (int i = 0; i < SIGN_UP_OPTIONS.length; i++)
                          Column(children: [
                            TypeCard(
                              isDarkMode: isDarkMode,
                              text: SIGN_UP_OPTIONS[i],
                              index: i + 1,
                            ),
                            i < SIGN_UP_OPTIONS.length - 1
                                ? addVerticalSpace(10.h)
                                : SizedBox(),
                          ]),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.05,
                        ),
                        Obx((() => signUpController.currentIndex.value != 0
                            ? DecisionButton(
                                isDarkMode: isDarkMode,
                                buttonText: "Continue",
                                onTap: (() =>
                                    Get.to(() => SignupPersonalScreen())))
                            : SizedBox())),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Already have an account?",
                          style: TextStyle(
                              fontFamily: "Mont",
                              fontSize: 13.sp,
                              color: isDarkMode
                                  ? AppColors.white
                                  : AppColors.black,
                              fontWeight: FontWeight.w700),
                        ),
                        addHorizontalSpace(10.w),
                        Container(
                            width: 130,
                            child: CustomButton(
                              title: "Login",
                              onTap: () {
                                Get.to(() => SignInScreen());
                              },
                            ))
                      ],
                    ),
                  ],
                ),
              )),
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class TypeCard extends StatelessWidget {
  TypeCard(
      {Key? key,
      required this.isDarkMode,
      required this.text,
      required this.index})
      : super(key: key);

  final bool isDarkMode;
  final String text;
  final int index;

  late SignUpController signUpController;

  @override
  Widget build(BuildContext context) {
    signUpController = Get.put(SignUpController());
    return InkWell(
      onTap: () {
        signUpController.currentIndex.value = index;
      },
      child: Obx((() => Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                    color: index != signUpController.currentIndex.value
                        ? isDarkMode
                            ? AppColors.grey
                            : AppColors.black
                        : isDarkMode
                            ? AppColors.mainGreen
                            : AppColors.primaryColor,
                    width: 0.64)),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                children: [
                  Container(
                    height: 20,
                    width: 20,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: index != signUpController.currentIndex.value
                          ? isDarkMode
                              ? AppColors.grey
                              : AppColors.grey
                          : isDarkMode
                              ? AppColors.mainGreen
                              : AppColors.primaryColor,
                    ),
                  ),
                  addHorizontalSpace(11.5.w),
                  Container(
                    width: MediaQuery.of(context).size.width * .65,
                    child: Text(
                      text,
                      style: TextStyle(
                          fontFamily: "Mont",
                          fontSize: 13.sp,
                          height: 2,
                          color: index != signUpController.currentIndex.value
                              ? isDarkMode
                                  ? AppColors.grey
                                  : AppColors.black
                              : isDarkMode
                                  ? AppColors.mainGreen
                                  : AppColors.primaryColor,
                          fontWeight: FontWeight.w400),
                    ),
                  )
                ],
              ),
            ),
          ))),
    );
  }
}
