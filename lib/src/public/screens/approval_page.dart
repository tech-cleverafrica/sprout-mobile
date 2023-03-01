import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sprout_mobile/src/components/home/view/homepage.dart';

import '../../utils/app_colors.dart';
import '../../utils/app_images.dart';
import '../../utils/app_svgs.dart';
import '../../utils/helper_widgets.dart';
import '../widgets/custom_button.dart';
import 'package:get/get.dart';

class ApprovalScreen extends StatelessWidget {
  const ApprovalScreen(
      {super.key,
      this.containShare = true,
      this.heading = "Successful",
      this.subHeading = "Approved",
      this.messages = ""});

  final String heading;
  final String subHeading;
  final String messages;
  final bool containShare;

  @override
  Widget build(BuildContext context) {
    return Container(
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
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.15,
              ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.end,
              //   children: [
              Text(
                heading,
                style: TextStyle(
                    color: AppColors.white,
                    fontFamily: "DMSans",
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
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.03,
              ),
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
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.03,
              ),
              Container(
                  child: Text(
                subHeading,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontFamily: "DMSans",
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w500,
                    color: AppColors.white),
              )),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.01,
              ),
              Container(
                  child: Text(
                messages,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontFamily: "DMSans",
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    color: AppColors.white),
              )),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.25,
              ),
              containShare
                  ? Row(
                      children: [
                        Container(
                          width: 246.w,
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
                    )
                  : Row(
                      children: [
                        Expanded(
                          child: Container(
                            child: CustomButton(
                                title: "Back To Home",
                                onTap: () {
                                  Get.to(() => HomePage());
                                }),
                          ),
                        ),
                      ],
                    ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.03,
              ),
              Image.asset(
                AppImages.sprout_dark,
                height: 27.h,
              )
            ],
          ),
        ),
      ),
    );
  }
}
