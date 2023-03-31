import 'dart:io';

import 'package:clipboard/clipboard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sprout_mobile/src/components/profile/controller/profile_controller.dart';
import 'package:sprout_mobile/src/components/profile/view/security_settings.dart';
import 'package:sprout_mobile/src/components/profile/view/support.dart';
import 'package:sprout_mobile/src/public/widgets/custom_toast_notification.dart';
import 'package:sprout_mobile/src/public/widgets/general_widgets.dart';
import 'package:sprout_mobile/src/utils/app_colors.dart';
import 'package:sprout_mobile/src/utils/app_images.dart';
import 'package:sprout_mobile/src/utils/app_svgs.dart';
import 'package:sprout_mobile/src/utils/helper_widgets.dart';
import 'package:image_picker/image_picker.dart';

import '../../../theme/theme_service.dart';

// ignore: must_be_immutable
class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});

  bool isTapped = false;
  late ProfileController profileController;

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    profileController = Get.put(ProfileController());
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                getHeader(isDarkMode),
                addVerticalSpace(15.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Obx((() => Row(
                          children: [
                            GestureDetector(
                              onTap: () async {
                                await profileController.picker
                                    .pickImage(
                                        source: ImageSource.camera,
                                        imageQuality: 25)
                                    .then(
                                  (value) {
                                    if (value != null) {
                                      profileController.profilePicture =
                                          File(value.path);
                                      profileController.uploadAndCommit();
                                    }
                                  },
                                );
                              },
                              child: Container(
                                alignment: Alignment.topLeft,
                                child: profileController
                                        .uploadingProfilePicture.value
                                    ? Container(
                                        height: 50,
                                        width: 50,
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Theme.of(context)
                                              .scaffoldBackgroundColor,
                                        ),
                                        child: SpinKitFadingCircle(
                                          color: isDarkMode
                                              ? AppColors.white
                                              : AppColors.primaryColor,
                                          size: 30,
                                        ),
                                      )
                                    : ClipRRect(
                                        borderRadius: BorderRadius.circular(50),
                                        child: Container(
                                          height: 50,
                                          width: 50,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: AppColors.transparent,
                                          ),
                                          child: profileController
                                                  .profileImage.value.isNotEmpty
                                              ? Image.network(
                                                  profileController
                                                      .profileImage.value,
                                                  loadingBuilder: (context,
                                                          child,
                                                          loadingProgress) =>
                                                      loadingProgress == null
                                                          ? child
                                                          : Container(
                                                              height: 50,
                                                              width: 50,
                                                              alignment:
                                                                  Alignment
                                                                      .center,
                                                              decoration:
                                                                  BoxDecoration(
                                                                shape: BoxShape
                                                                    .circle,
                                                                color: Theme.of(
                                                                        context)
                                                                    .scaffoldBackgroundColor,
                                                              ),
                                                              child:
                                                                  SpinKitThreeBounce(
                                                                color: isDarkMode
                                                                    ? AppColors
                                                                        .white
                                                                    : AppColors
                                                                        .primaryColor,
                                                                size: 15,
                                                              ),
                                                            ),
                                                  fit: BoxFit.cover,
                                                )
                                              : Image.asset(
                                                  isDarkMode
                                                      ? AppImages.account_light
                                                      : AppImages.account_white,
                                                  fit: BoxFit.cover),
                                        ),
                                      ),
                              ),
                            ),
                            addHorizontalSpace(15.w),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  profileController.fullname.value,
                                  style: TextStyle(
                                      fontFamily: "DMSans",
                                      fontSize: 18.sp,
                                      color: isDarkMode
                                          ? AppColors.white
                                          : AppColors.black,
                                      fontWeight: FontWeight.w700),
                                ),
                                Text(
                                  profileController.email.value,
                                  style: TextStyle(
                                      fontFamily: "DMSans",
                                      fontSize: 13.sp,
                                      color: isDarkMode
                                          ? AppColors.greyText
                                          : AppColors.greyText,
                                      fontWeight: FontWeight.w400),
                                )
                              ],
                            )
                          ],
                        ))),
                  ],
                ),
                addVerticalSpace(12.h),
                Divider(
                  thickness: 0.3,
                  color: isDarkMode
                      ? AppColors.semi_white.withOpacity(0.3)
                      : AppColors.inputLabelColor.withOpacity(0.6),
                ),
                addVerticalSpace(10.h),
                Obx((() => Row(
                      children: [
                        Text(
                          "Customer ID:",
                          style: TextStyle(
                              fontFamily: "DMSans",
                              fontSize: 13.sp,
                              color: isDarkMode
                                  ? AppColors.greyText
                                  : AppColors.greyText,
                              fontWeight: FontWeight.w400),
                        ),
                        addHorizontalSpace(5.w),
                        Text(
                          profileController.agentId.value,
                          style: TextStyle(
                              fontFamily: "DMSans",
                              fontSize: 13.sp,
                              color: isDarkMode
                                  ? AppColors.greyText
                                  : AppColors.greyText,
                              fontWeight: FontWeight.w700),
                        )
                      ],
                    ))),
                addVerticalSpace(5.h),
                Obx((() => Row(
                      children: [
                        Text(
                          "Account Number",
                          style: TextStyle(
                              fontFamily: "DMSans",
                              fontSize: 13.sp,
                              color: isDarkMode
                                  ? AppColors.greyText
                                  : AppColors.greyText,
                              fontWeight: FontWeight.w400),
                        ),
                        addHorizontalSpace(5.w),
                        Text(
                          profileController.accountNumberToUse.value,
                          style: TextStyle(
                              fontFamily: "DMSans",
                              fontSize: 13.sp,
                              color: isDarkMode
                                  ? AppColors.greyText
                                  : AppColors.greyText,
                              fontWeight: FontWeight.w700),
                        ),
                        addHorizontalSpace(15.w),
                        GestureDetector(
                            onTap: () => Platform.isIOS
                                ? Clipboard.setData(ClipboardData(
                                        text: profileController
                                            .accountNumberToUse.value))
                                    .then((value) => {
                                          CustomToastNotification.show(
                                              "Account number has been copied successfully",
                                              type: ToastType.success),
                                        })
                                : FlutterClipboard.copy(profileController
                                        .accountNumberToUse.value)
                                    .then((value) => {
                                          CustomToastNotification.show(
                                              "Account number has been copied successfully",
                                              type: ToastType.success),
                                        }),
                            child: SvgPicture.asset(
                              AppSvg.copy,
                              color: AppColors.mainGreen,
                              height: 14,
                            ))
                      ],
                    ))),
                addVerticalSpace(5.h),
                Obx((() => Row(
                      children: [
                        Text(
                          "Bank",
                          style: TextStyle(
                              fontFamily: "DMSans",
                              fontSize: 13.sp,
                              color: isDarkMode
                                  ? AppColors.greyText
                                  : AppColors.greyText,
                              fontWeight: FontWeight.w400),
                        ),
                        addHorizontalSpace(5.w),
                        Text(
                          profileController.bankToUse.value,
                          style: TextStyle(
                              fontFamily: "DMSans",
                              fontSize: 13.sp,
                              color: isDarkMode
                                  ? AppColors.greyText
                                  : AppColors.greyText,
                              fontWeight: FontWeight.w700),
                        ),
                      ],
                    ))),
                addVerticalSpace(10.h),
                Divider(
                  thickness: 0.3,
                  color: isDarkMode
                      ? AppColors.semi_white.withOpacity(0.3)
                      : AppColors.inputLabelColor.withOpacity(0.6),
                ),
                addVerticalSpace(15.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      isDarkMode
                          ? "Switch to light mode"
                          : "Switch to dark mode",
                      style: TextStyle(
                          fontFamily: "DMSans",
                          fontSize: 13.sp,
                          color: isDarkMode
                              ? AppColors.semi_white.withOpacity(0.8)
                              : AppColors.greyText,
                          fontWeight: FontWeight.w700),
                    ),
                    CupertinoSwitch(
                        activeColor: AppColors.primaryColor,
                        thumbColor: AppColors.white,
                        value: isTapped,
                        onChanged: (val) {
                          ThemeService().changeThemeMode();
                          isTapped = !isTapped;
                        })
                  ],
                ),
                addVerticalSpace(20.h),
                InkWell(
                  onTap: () => Get.to(() => SecuritySettings()),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          SvgPicture.asset(
                            AppSvg.security,
                            height: 35,
                          ),
                          addHorizontalSpace(10.w),
                          Text(
                            "Security settings",
                            style: TextStyle(
                                color: isDarkMode
                                    ? AppColors.white
                                    : AppColors.greyDot,
                                fontWeight: FontWeight.w700,
                                fontSize: 14.sp),
                          )
                        ],
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        size: 16,
                      )
                    ],
                  ),
                ),
                addVerticalSpace(20.h),
                InkWell(
                  onTap: () => {},
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          SvgPicture.asset(
                            AppSvg.download_statement,
                            height: 35,
                          ),
                          addHorizontalSpace(10.w),
                          Text(
                            "Download statement",
                            style: TextStyle(
                                color: isDarkMode
                                    ? AppColors.white
                                    : AppColors.greyDot,
                                fontWeight: FontWeight.w700,
                                fontSize: 14.sp),
                          )
                        ],
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        size: 16,
                      )
                    ],
                  ),
                ),
                addVerticalSpace(20.h),
                InkWell(
                  onTap: () => Get.to(() => SupportScreen()),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          SvgPicture.asset(
                            AppSvg.support,
                            height: 35,
                          ),
                          addHorizontalSpace(10.w),
                          Text(
                            "Support",
                            style: TextStyle(
                                color: isDarkMode
                                    ? AppColors.white
                                    : AppColors.greyDot,
                                fontWeight: FontWeight.w700,
                                fontSize: 14.sp),
                          )
                        ],
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        size: 16,
                      )
                    ],
                  ),
                ),
                addVerticalSpace(20.h),
                Row(
                  children: [
                    SvgPicture.asset(
                      AppSvg.privacy,
                      height: 35,
                    ),
                    addHorizontalSpace(10.w),
                    Text(
                      "Terms & Condition",
                      style: TextStyle(
                          color:
                              isDarkMode ? AppColors.white : AppColors.greyDot,
                          fontWeight: FontWeight.w700,
                          fontSize: 14.sp),
                    )
                  ],
                ),
                addVerticalSpace(20.h),
                Row(
                  children: [
                    SvgPicture.asset(
                      AppSvg.privacy,
                      height: 35,
                    ),
                    addHorizontalSpace(10.w),
                    Text(
                      "Privacy Policy",
                      style: TextStyle(
                          color:
                              isDarkMode ? AppColors.white : AppColors.greyDot,
                          fontWeight: FontWeight.w700,
                          fontSize: 14.sp),
                    )
                  ],
                ),
                addVerticalSpace(20.h),
                InkWell(
                  onTap: () => {},
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Row(
                      children: [
                        Image.asset(
                          AppImages.rateApp,
                          height: 25,
                        ),
                        addHorizontalSpace(10.w),
                        Text(
                          "Rate App",
                          style: TextStyle(
                              color: isDarkMode
                                  ? AppColors.white
                                  : AppColors.greyDot,
                              fontWeight: FontWeight.w700,
                              fontSize: 14.sp),
                        )
                      ],
                    ),
                  ),
                ),
                addVerticalSpace(50.h),
                InkWell(
                  onTap: () => profileController.logout(),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          AppSvg.logout,
                          color:
                              isDarkMode ? AppColors.white : AppColors.greyDot,
                        ),
                        addHorizontalSpace(10.w),
                        Text(
                          "Log out",
                          style: TextStyle(
                              color: isDarkMode
                                  ? AppColors.white
                                  : AppColors.greyDot,
                              fontWeight: FontWeight.w700,
                              fontSize: 14.sp),
                        )
                      ],
                    ),
                  ),
                ),
                addVerticalSpace(50.h),
                Center(
                  child: Text(
                    "V.S.1.0.0",
                    style: TextStyle(
                        fontFamily: "DMSans",
                        fontSize: 13.sp,
                        color:
                            isDarkMode ? AppColors.white : AppColors.greyText,
                        fontWeight: FontWeight.w700),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
