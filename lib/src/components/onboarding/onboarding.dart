import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sprout_mobile/src/components/authentication/view/sign_in_screen.dart';
import 'package:sprout_mobile/src/components/onboarding/onboarding_content_model.dart';
import 'package:sprout_mobile/src/utils/app_colors.dart';

import '../../theme/theme_service.dart';

class Onboarding extends StatefulWidget {
  const Onboarding({Key? key}) : super(key: key);

  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  int currentIndex = 0;
  PageController? _controller = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: isDarkMode ? AppColors.black : AppColors.white,
          title: Text(
            "Switch theme",
            style: TextStyle(
              color: isDarkMode ? AppColors.white : AppColors.black,
            ),
          ),
          actions: [
            IconButton(
              icon: Icon(
                Icons.brightness_4_rounded,
                color: isDarkMode ? AppColors.white : AppColors.black,
              ),
              onPressed: () {
                ThemeService().changeThemeMode();
              },
            ),
          ],
        ),
        body: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: _controller,
                itemCount: contents.length,
                onPageChanged: (int index) {
                  setState(() {
                    currentIndex = index;
                  });
                },
                itemBuilder: (_, i) {
                  if (currentIndex == 0) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 29),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 350.h,
                          ),
                          Container(
                            width: 305.w,
                            child: Text(
                                "One app for all your payments and business needs",
                                textAlign: TextAlign.center,
                                style: theme.textTheme.headline1),
                          ),
                          SizedBox(
                            height: 16.h,
                          ),
                          Container(
                            width: 271.w,
                            child: Text(
                                "Access all business payment solutions like contactless pos, scheduled payments, transfers",
                                textAlign: TextAlign.center,
                                style: theme.textTheme.bodyText2),
                          ),
                          SizedBox(height: 30.h),
                          isDarkMode
                              ? Container(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: List.generate(
                                      contents.length,
                                      (index) => buildDarkDot(index, context),
                                    ),
                                  ),
                                )
                              : Container(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: List.generate(
                                      contents.length,
                                      (index) => buildLightDot(index, context),
                                    ),
                                  ),
                                ),
                          SizedBox(
                            height: 20.h,
                          ),
                          Column(
                            children: [
                              InkWell(
                                  onTap: () {
                                    // box.write('isExisting', true);
                                    // Get.to(() => RegEmailVerification());
                                  },
                                  child: Container(
                                    height: 50,
                                    decoration: BoxDecoration(
                                        color: Color(0xFF3D02E6),
                                        borderRadius: BorderRadius.circular(5)),
                                    child: Center(
                                      child: Text(
                                        "Get Started",
                                        style: TextStyle(
                                            color: Color(0xFFF2f2f2),
                                            fontWeight: FontWeight.w400,
                                            fontFamily: 'DMSans',
                                            fontSize: 15.sp),
                                      ),
                                    ),
                                  )),
                              SizedBox(
                                height: 10.h,
                              ),
                              InkWell(
                                onTap: () {
                                  //Get.to(() => SignIn());
                                },
                                child: Container(
                                  height: 48,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      border: Border.all(
                                        width: 1.0,
                                        color: isDarkMode
                                            ? AppColors.white
                                            : AppColors.black,
                                      )),
                                  child: Center(
                                    child: Text(
                                      "Login",
                                      style: TextStyle(
                                          fontFamily: 'DMSans',
                                          color: isDarkMode
                                              ? AppColors.white
                                              : AppColors.black,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 15.sp),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    );
                  } else if (currentIndex == 1) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 29),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 380.h,
                          ),
                          Container(
                            width: 305.w,
                            child: Text(
                              "Banking that sorts your lifestyle",
                              textAlign: TextAlign.center,
                              style: theme.textTheme.headline1,
                            ),
                          ),
                          SizedBox(
                            height: 16.h,
                          ),
                          Container(
                            width: 271.w,
                            child: Text(
                                "Send money, request money pay bills seamlessly",
                                textAlign: TextAlign.center,
                                style: theme.textTheme.bodyText2),
                          ),
                          SizedBox(height: 30.h),
                          isDarkMode
                              ? Container(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: List.generate(
                                      contents.length,
                                      (index) => buildDarkDot(index, context),
                                    ),
                                  ),
                                )
                              : Container(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: List.generate(
                                      contents.length,
                                      (index) => buildLightDot(index, context),
                                    ),
                                  ),
                                ),
                          SizedBox(
                            height: 20.h,
                          ),
                          Column(
                            children: [
                              InkWell(
                                  onTap: () {
                                    // box.write('isExisting', true);
                                    // Get.to(() => RegEmailVerification());
                                  },
                                  child: Container(
                                    height: 50,
                                    decoration: BoxDecoration(
                                        color: Color(0xFF3D02E6),
                                        borderRadius: BorderRadius.circular(5)),
                                    child: Center(
                                      child: Text(
                                        "Get Started",
                                        style: TextStyle(
                                            color: Color(0xFFF2f2f2),
                                            fontWeight: FontWeight.w400,
                                            fontFamily: 'DMSans',
                                            fontSize: 15.sp),
                                      ),
                                    ),
                                  )),
                              SizedBox(
                                height: 10.h,
                              ),
                              InkWell(
                                onTap: () {
                                  //Get.to(() => SignIn());
                                },
                                child: Container(
                                  height: 48,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      border: Border.all(
                                        width: 1.0,
                                        color: isDarkMode
                                            ? AppColors.white
                                            : AppColors.black,
                                      )),
                                  child: Center(
                                    child: Text(
                                      "Login",
                                      style: TextStyle(
                                          fontFamily: 'DMSans',
                                          color: isDarkMode
                                              ? AppColors.white
                                              : AppColors.black,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 15.sp),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    );
                  } else if (currentIndex == 2) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 29),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 380.h,
                          ),
                          Container(
                            width: 305.w,
                            child: Text("Secured Service",
                                textAlign: TextAlign.center,
                                style: theme.textTheme.headline1),
                          ),
                          SizedBox(
                            height: 16.h,
                          ),
                          Container(
                            width: 271.w,
                            child: Text(
                                "We comply with all guideline by regulators to protect your funds",
                                textAlign: TextAlign.center,
                                style: theme.textTheme.bodyText2),
                          ),
                          SizedBox(height: 30.h),
                          isDarkMode
                              ? Container(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: List.generate(
                                      contents.length,
                                      (index) => buildDarkDot(index, context),
                                    ),
                                  ),
                                )
                              : Container(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: List.generate(
                                      contents.length,
                                      (index) => buildLightDot(index, context),
                                    ),
                                  ),
                                ),
                          SizedBox(
                            height: 20.h,
                          ),
                          Column(
                            children: [
                              InkWell(
                                  onTap: () {
                                    // box.write('isExisting', true);
                                    // Get.to(() => RegEmailVerification());
                                  },
                                  child: Container(
                                    height: 50,
                                    decoration: BoxDecoration(
                                        color: Color(0xFF3D02E6),
                                        borderRadius: BorderRadius.circular(5)),
                                    child: Center(
                                      child: Text(
                                        "Get Started",
                                        style: TextStyle(
                                            color: Color(0xFFF2f2f2),
                                            fontWeight: FontWeight.w400,
                                            fontFamily: 'DMSans',
                                            fontSize: 15.sp),
                                      ),
                                    ),
                                  )),
                              SizedBox(
                                height: 10.h,
                              ),
                              InkWell(
                                onTap: () {
                                  //Get.to(() => SignIn());
                                },
                                child: Container(
                                  height: 48,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      border: Border.all(
                                        width: 1.0,
                                        color: isDarkMode
                                            ? AppColors.white
                                            : AppColors.black,
                                      )),
                                  child: Center(
                                    child: Text(
                                      "Login",
                                      style: TextStyle(
                                          fontFamily: 'DMSans',
                                          color: isDarkMode
                                              ? AppColors.white
                                              : AppColors.black,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 15.sp),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    );
                  }

                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 29),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 380.h,
                        ),
                        Container(
                          width: 305.w,
                          child: Text("Here for business",
                              textAlign: TextAlign.center,
                              style: theme.textTheme.headline1),
                        ),
                        SizedBox(
                          height: 16.h,
                        ),
                        Container(
                          width: 271.w,
                          child: Text(
                              "Access all business payment solutions like contactless pos, scheduled payments, transfers",
                              textAlign: TextAlign.center,
                              style: theme.textTheme.bodyText2),
                        ),
                        SizedBox(height: 30.h),
                        isDarkMode
                            ? Container(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: List.generate(
                                    contents.length,
                                    (index) => buildDarkDot(index, context),
                                  ),
                                ),
                              )
                            : Container(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: List.generate(
                                    contents.length,
                                    (index) => buildLightDot(index, context),
                                  ),
                                ),
                              ),
                        SizedBox(
                          height: 20.h,
                        ),
                        Column(
                          children: [
                            InkWell(
                                onTap: () {
                                  // box.write('isExisting', true);
                                  // Get.to(() => RegEmailVerification());
                                },
                                child: Container(
                                  height: 50,
                                  decoration: BoxDecoration(
                                      color: Color(0xFF3D02E6),
                                      borderRadius: BorderRadius.circular(5)),
                                  child: Center(
                                    child: Text(
                                      "Get Started",
                                      style: TextStyle(
                                          color: Color(0xFFF2f2f2),
                                          fontWeight: FontWeight.w400,
                                          fontFamily: 'DMSans',
                                          fontSize: 15.sp),
                                    ),
                                  ),
                                )),
                            SizedBox(
                              height: 10.h,
                            ),
                            InkWell(
                              onTap: () {
                                Get.to(() => SignInScreen());
                              },
                              child: Container(
                                height: 48,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    border: Border.all(
                                      width: 1.0,
                                      color: isDarkMode
                                          ? AppColors.white
                                          : AppColors.black,
                                    )),
                                child: Center(
                                  child: Text(
                                    "Login",
                                    style: TextStyle(
                                        fontFamily: 'DMSans',
                                        color: isDarkMode
                                            ? AppColors.white
                                            : AppColors.black,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 15.sp),
                                  ),
                                ),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container buildLightDot(int index, BuildContext context) {
    return Container(
      height: 10,
      width: 10,
      margin: EdgeInsets.only(right: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: currentIndex == index
            ? Color(0xFF00DAAC)
            : Color(0xFF222222).withOpacity(0.15),
      ),
    );
  }

  Container buildDarkDot(int index, BuildContext context) {
    return Container(
      height: 10,
      width: 10,
      margin: EdgeInsets.only(right: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: currentIndex == index
            ? Color(0xFF00DAAC)
            : AppColors.grey.withOpacity(0.15),
      ),
    );
  }
}
