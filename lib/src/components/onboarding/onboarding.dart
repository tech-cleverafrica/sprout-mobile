import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sprout_mobile/src/components/authentication/view/sign_in_screen.dart';
import 'package:sprout_mobile/src/components/authentication/view/sign_up_start.dart';
import 'package:sprout_mobile/src/components/notification/service/notification_service.dart';
import 'package:sprout_mobile/src/components/onboarding/onboarding_content_model.dart';
import 'package:sprout_mobile/src/public/services/device_service.dart';
import 'package:sprout_mobile/src/utils/app_colors.dart';
import 'package:sprout_mobile/src/utils/app_images.dart';

class Onboarding extends StatefulWidget {
  const Onboarding({Key? key}) : super(key: key);

  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  int currentIndex = 0;
  PageController? _controller = PageController(initialPage: 0);
  static final DeviceInfoPlugin device = DeviceInfoPlugin();
  final push = PushNotificationService();
  final deviceService = DeviceService(device);

  @override
  void initState() {
    super.initState();
    push.initialise();
    deviceService.getDeviceInfo();
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return SafeArea(
      child: Scaffold(
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
                            height: 122.h,
                          ),
                          Image.asset(
                            AppImages.onboarding1,
                            height: 200.h,
                            width: 200.w,
                          ),
                          SizedBox(
                            height: 72.h,
                          ),
                          Container(
                            width: 305.w,
                            child: Text(
                                "One app for all your payments and business needs",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontFamily: "Mont",
                                    fontSize: 20.sp,
                                    fontWeight: FontWeight.w900,
                                    color: isDarkMode
                                        ? AppColors.white
                                        : AppColors.black)),
                          ),
                          SizedBox(
                            height: 12.h,
                          ),
                          Container(
                            width: 271.w,
                            child: Text(
                                "Access all business payment solutions like contactless pos, scheduled payments, transfers",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontFamily: "Mont",
                                    fontSize: 12.sp,
                                    color: isDarkMode
                                        ? AppColors.semi_white
                                        : AppColors.black,
                                    fontWeight: FontWeight.w400)),
                          ),
                        ],
                      ),
                    );
                  } else if (currentIndex == 1) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 29),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 134.h,
                          ),
                          Image.asset(
                            AppImages.onboarding2,
                            height: 200.h,
                            width: 200.w,
                          ),
                          SizedBox(
                            height: 84.h,
                          ),
                          Container(
                            width: 305.w,
                            child: Text("Banking that sorts your lifestyle",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontFamily: "Mont",
                                    fontSize: 20.sp,
                                    fontWeight: FontWeight.w900,
                                    color: isDarkMode
                                        ? AppColors.white
                                        : AppColors.black)),
                          ),
                          SizedBox(
                            height: 12.h,
                          ),
                          Container(
                            width: 271.w,
                            child: Text(
                                "Send money, request money and pay bills seamlessly",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontFamily: "Mont",
                                    fontSize: 12.sp,
                                    color: isDarkMode
                                        ? AppColors.semi_white
                                        : AppColors.black,
                                    fontWeight: FontWeight.w400)),
                          ),
                        ],
                      ),
                    );
                  } else if (currentIndex == 2) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 29),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 134.h,
                          ),
                          Image.asset(
                            AppImages.onboarding3,
                            height: 200.h,
                            width: 200.w,
                          ),
                          SizedBox(
                            height: 84.h,
                          ),
                          Container(
                            width: 305.w,
                            child: Text("Secured Service",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontFamily: "Mont",
                                    fontSize: 20.sp,
                                    fontWeight: FontWeight.w900,
                                    color: isDarkMode
                                        ? AppColors.white
                                        : AppColors.black)),
                          ),
                          SizedBox(
                            height: 12.h,
                          ),
                          Container(
                            width: 271.w,
                            child: Text(
                                "We comply with all guideline by regulators to protect your funds",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontFamily: "Mont",
                                    fontSize: 12.sp,
                                    color: isDarkMode
                                        ? AppColors.semi_white
                                        : AppColors.black,
                                    fontWeight: FontWeight.w400)),
                          ),
                        ],
                      ),
                    );
                  }

                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 29),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 134.h,
                        ),
                        Image.asset(
                          AppImages.onboarding4,
                          height: 200.h,
                          width: 200.w,
                        ),
                        SizedBox(
                          height: 84.h,
                        ),
                        Container(
                          width: 305.w,
                          child: Text("Here for business",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontFamily: "Mont",
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.w900,
                                  color: isDarkMode
                                      ? AppColors.white
                                      : AppColors.black)),
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
                                  fontFamily: "Mont",
                                  fontSize: 12.sp,
                                  color: isDarkMode
                                      ? AppColors.semi_white
                                      : AppColors.black,
                                  fontWeight: FontWeight.w400)),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
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
            SizedBox(height: 64.h),
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 29),
                child: Column(
                  children: [
                    InkWell(
                        onTap: () {
                          Get.to(() => SignUpStart());
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
                                  fontFamily: 'Mont',
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
                                fontFamily: 'Mont',
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
                )),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.08,
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
