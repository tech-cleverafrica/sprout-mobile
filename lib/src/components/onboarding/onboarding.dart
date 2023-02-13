import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sprout_mobile/src/components/onboarding/onboarding_content_model.dart';

import '../../theme/theme_manager.dart';

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
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text(
            "Switch theme",
            style: TextStyle(
              color: theme.accentColor,
            ),
          ),
          actions: [
            IconButton(
              icon: const Icon(
                Icons.brightness_4_rounded,
                color: Colors.black,
              ),
              onPressed: () {
                currentTheme.toggleTheme();
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
                              style: TextStyle(
                                  fontSize: 24.sp,
                                  fontWeight: FontWeight.w700,
                                  // color: AppColors.white,
                                  fontFamily: 'DMSans'),
                            ),
                          ),
                          SizedBox(
                            height: 16.h,
                          ),
                          Container(
                            width: 271.w,
                            child: Text(
                              "Access all business payment solutions like contactless pos, scheduled payments, transfers",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 12.sp,
                                fontFamily: 'DMSans',

                                // color: AppColors.greyText,
                              ),
                            ),
                          ),
                          SizedBox(height: 30.h),
                          Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: List.generate(
                                contents.length,
                                (index) => buildDot(index, context),
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
                                          //color: AppColors.primaryColor,
                                          width: 1.0)),
                                  child: Center(
                                    child: Text(
                                      "Login",
                                      style: TextStyle(
                                          fontFamily: 'DMSans',
                                          // color: AppColors.white,
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
                              style: TextStyle(
                                  fontSize: 24.sp,
                                  fontWeight: FontWeight.w700,
                                  // color: AppColors.white,
                                  fontFamily: 'DMSans'),
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
                              style: TextStyle(
                                fontSize: 12.sp,
                                fontFamily: 'DMSans',

                                // color: AppColors.greyText,
                              ),
                            ),
                          ),
                          SizedBox(height: 30.h),
                          Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: List.generate(
                                contents.length,
                                (index) => buildDot(index, context),
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
                                          //color: AppColors.primaryColor,
                                          width: 1.0)),
                                  child: Center(
                                    child: Text(
                                      "Login",
                                      style: TextStyle(
                                          fontFamily: 'DMSans',
                                          // color: AppColors.white,
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
                            child: Text(
                              "Secured Service",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 24.sp,
                                  fontWeight: FontWeight.w700,
                                  // color: AppColors.white,
                                  fontFamily: 'DMSans'),
                            ),
                          ),
                          SizedBox(
                            height: 16.h,
                          ),
                          Container(
                            width: 271.w,
                            child: Text(
                              "We comply with all guideline by regulators to protect your funds",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 12.sp,
                                fontFamily: 'DMSans',

                                // color: AppColors.greyText,
                              ),
                            ),
                          ),
                          SizedBox(height: 30.h),
                          Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: List.generate(
                                contents.length,
                                (index) => buildDot(index, context),
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
                                          //color: AppColors.primaryColor,
                                          width: 1.0)),
                                  child: Center(
                                    child: Text(
                                      "Login",
                                      style: TextStyle(
                                          fontFamily: 'DMSans',
                                          // color: AppColors.white,
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
                          child: Text(
                            "Here for business",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 24.sp,
                                fontWeight: FontWeight.w700,
                                // color: AppColors.white,
                                fontFamily: 'DMSans'),
                          ),
                        ),
                        SizedBox(
                          height: 16.h,
                        ),
                        Container(
                          width: 271.w,
                          child: Text(
                            "Access all business payment solutions like contactless pos, scheduled payments, transfers",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 12.sp,
                              fontFamily: 'DMSans',

                              // color: AppColors.greyText,
                            ),
                          ),
                        ),
                        SizedBox(height: 30.h),
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: List.generate(
                              contents.length,
                              (index) => buildDot(index, context),
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
                                        //color: AppColors.primaryColor,
                                        width: 1.0)),
                                child: Center(
                                  child: Text(
                                    "Login",
                                    style: TextStyle(
                                        fontFamily: 'DMSans',
                                        // color: AppColors.white,
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

  Container buildDot(int index, BuildContext context) {
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
}
