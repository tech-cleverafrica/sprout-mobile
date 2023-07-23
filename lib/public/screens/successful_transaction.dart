import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sprout_mobile/components/home/view/bottom_nav.dart';
import 'package:sprout_mobile/utils/app_colors.dart';
import 'package:sprout_mobile/utils/app_svgs.dart';
import 'package:sprout_mobile/utils/helper_widgets.dart';
import 'package:sprout_mobile/utils/nav_function.dart';

import '../../utils/app_images.dart';
import '../widgets/custom_button.dart';

class SuccessfultransactionScreen extends StatelessWidget {
  const SuccessfultransactionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () {
          pushUntil(
              page: BottomNav(
            index: 0,
          ));
          return Future.value(true);
        },
        child: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppColors.mainGreen,
                  AppColors.black,
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
              image: DecorationImage(
                  image: AssetImage("assets/images/rough_background.png"),
                  fit: BoxFit.cover)),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  addVerticalSpace(60.h),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.end,
                  //   children: [
                  Text(
                    "Successful",
                    style: TextStyle(
                        color: AppColors.white,
                        fontFamily: "Mont",
                        fontSize: 22.sp,
                        fontWeight: FontWeight.w700),
                  ),
                  //     addHorizontalSpace(70.w),
                  //     InkWell(
                  //       onTap: () {},
                  //       child: Container(
                  //         height: 28,
                  //         width: 28,
                  //         decoration: BoxDecoration(
                  //             shape: BoxShape.circle,
                  //             border: Border.all(
                  //               color: AppColors.white,
                  //               width: 1.5,
                  //             )),
                  //         child: Center(
                  //             child: Icon(
                  //           Icons.more_horiz,
                  //           color: AppColors.white,
                  //         )),
                  //       ),
                  //     )
                  //   ],
                  // ),
                  addVerticalSpace(26.h),
                  Container(
                      height: 112.h,
                      width: 112.w,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(0xFFD9D9D9).withOpacity(0.4)),
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: SvgPicture.asset(
                          AppSvg.mark,
                          color: AppColors.white,
                        ),
                      )),
                  addVerticalSpace(20.h),
                  Container(
                      width: 150.w,
                      child: Text(
                        "You have successfully sent money to 06376*****",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontFamily: "Mont",
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w400,
                            color: AppColors.white),
                      )),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.08,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: AppColors.black,
                        borderRadius: BorderRadius.circular(10)),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Amount:",
                                style: titleStyle(),
                              ),
                              Text(
                                "N21,000",
                                style: detailStyle(),
                              )
                            ],
                          ),
                          addVerticalSpace(20.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Transaction charge:",
                                style: titleStyle(),
                              ),
                              Text(
                                "N53.4",
                                style: detailStyle(),
                              )
                            ],
                          ),
                          addVerticalSpace(20.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Bank name:",
                                style: titleStyle(),
                              ),
                              Text(
                                "First Bank",
                                style: detailStyle(),
                              )
                            ],
                          ),
                          addVerticalSpace(20.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Bank Account:",
                                style: titleStyle(),
                              ),
                              Text(
                                "3199886543",
                                style: detailStyle(),
                              )
                            ],
                          ),
                          addVerticalSpace(20.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Beneficiary name:",
                                style: titleStyle(),
                              ),
                              Text(
                                "John Doe",
                                style: detailStyle(),
                              )
                            ],
                          ),
                          addVerticalSpace(20.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Payment method:",
                                style: titleStyle(),
                              ),
                              Text(
                                "Wallet",
                                style: detailStyle(),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.1,
                  ),
                  Row(
                    children: [
                      Container(
                        width: 190.w,
                        child:
                            CustomButton(title: "Back To Home", onTap: () {}),
                      ),
                      addHorizontalSpace(8.w),
                      Expanded(
                          child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                            color: AppColors.inputBackgroundColor,
                            borderRadius: BorderRadius.circular(10)),
                        child: Center(child: SvgPicture.asset(AppSvg.share)),
                      ))
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.01,
                  ),
                  Image.asset(
                    AppImages.sprout_dark,
                    height: MediaQuery.of(context).size.height * 0.05,
                  ),
                ],
              ),
            ),
          ),
        ));
  }

  TextStyle titleStyle() {
    return TextStyle(
        fontFamily: "Mont",
        fontSize: 12.sp,
        fontWeight: FontWeight.w400,
        color: AppColors.inputLabelColor);
  }

  TextStyle detailStyle() {
    return TextStyle(
        fontFamily: "Mont",
        fontSize: 12.sp,
        fontWeight: FontWeight.w400,
        color: AppColors.white);
  }
}
