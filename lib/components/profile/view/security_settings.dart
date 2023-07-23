import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sprout_mobile/components/profile/view/change_password.dart';
import 'package:sprout_mobile/components/profile/view/change_pin.dart';
import 'package:sprout_mobile/components/profile/view/create_pin.dart';
import 'package:sprout_mobile/public/widgets/general_widgets.dart';
import 'package:sprout_mobile/utils/app_svgs.dart';
import 'package:sprout_mobile/utils/constants.dart';
import 'package:sprout_mobile/utils/helper_widgets.dart';

import '../../../reources/db_provider.dart';
import '../../../utils/app_colors.dart';

class SecuritySettings extends StatefulWidget {
  SecuritySettings({super.key});

  @override
  State<SecuritySettings> createState() => _SecuritySettingsState();
}

class _SecuritySettingsState extends State<SecuritySettings> {
  final storage = GetStorage();
  bool _isFingerPrintEnabled = false;
  DBProvider sharePreference = DBProvider();
  bool isApproved = false;
  bool inReview = false;
  bool hasPin = false;

  @override
  initState() {
    storage.remove("removeAll");
    checkIsFingerPrintEnabled();
    String approvalStatus = storage.read("approvalStatus");
    setState(() {
      isApproved = approvalStatus == "APPROVED" ? true : false;
      inReview = approvalStatus == "IN_REVIEW" ? true : false;
      hasPin = storage.read("hasPin");
    });
    super.initState();
  }

  @override
  void dispose() {
    storage.write('removeAll', "1");
    super.dispose();
  }

  void checkIsFingerPrintEnabled() async {
    bool? isFingerPrintEnabled = await sharePreference
        .getBooleanStoredInSharedPreference(useBiometricAuth);
    _isFingerPrintEnabled =
        isFingerPrintEnabled == null ? false : isFingerPrintEnabled;
    setState(() {});
  }

  void _saveFingerPrintSetting() {
    sharePreference.setBooleanPref(useBiometricAuth, _isFingerPrintEnabled);
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              getHeader(isDarkMode),
              addVerticalSpace(15.h),
              isApproved && !inReview && !hasPin
                  ? InkWell(
                      onTap: () {
                        Get.to(() => CreatePin());
                      },
                      child: Row(
                        children: [
                          SvgPicture.asset(
                            AppSvg.create_pin,
                          ),
                          Text(
                            "Create PIN",
                            style: TextStyle(
                                fontFamily: "Mont",
                                fontSize: 14.sp,
                                color: isDarkMode
                                    ? AppColors.white
                                    : AppColors.black,
                                fontWeight: FontWeight.w500),
                          )
                        ],
                      ),
                    )
                  : SizedBox(),
              isApproved && !inReview && !hasPin
                  ? Divider(
                      color: isDarkMode ? AppColors.white : AppColors.white,
                    )
                  : SizedBox(),
              isApproved && !inReview && !hasPin
                  ? addVerticalSpace(10.h)
                  : SizedBox(),
              isApproved && !inReview && hasPin
                  ? InkWell(
                      onTap: () {
                        Get.to(() => ChangePin());
                      },
                      child: Row(
                        children: [
                          SvgPicture.asset(AppSvg.change_pin),
                          Text(
                            "Change PIN",
                            style: TextStyle(
                                fontFamily: "Mont",
                                fontSize: 14.sp,
                                color: isDarkMode
                                    ? AppColors.white
                                    : AppColors.black,
                                fontWeight: FontWeight.w500),
                          )
                        ],
                      ),
                    )
                  : SizedBox(),
              isApproved && !inReview && hasPin
                  ? Divider(
                      color: isDarkMode ? AppColors.white : AppColors.white,
                    )
                  : SizedBox(),
              isApproved && !inReview && hasPin
                  ? addVerticalSpace(10.h)
                  : SizedBox(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      SvgPicture.asset(AppSvg.face_id),
                      Text(
                        "Enable Biometric Login",
                        style: TextStyle(
                            fontFamily: "Mont",
                            fontSize: 14.sp,
                            color:
                                isDarkMode ? AppColors.white : AppColors.black,
                            fontWeight: FontWeight.w500),
                      )
                    ],
                  ),
                  CupertinoSwitch(
                    activeColor: AppColors.deepOrange,
                    value: _isFingerPrintEnabled,
                    onChanged: (bool value) {
                      setState(() => _isFingerPrintEnabled = value);
                      _saveFingerPrintSetting();
                    },
                  )
                ],
              ),
              Divider(
                color: isDarkMode ? AppColors.white : AppColors.white,
              ),
              addVerticalSpace(10.h),
              InkWell(
                onTap: () {
                  Get.to(() => ChangePassword());
                },
                child: Row(
                  children: [
                    SvgPicture.asset(AppSvg.change_password),
                    Text(
                      "Change Login Password",
                      style: TextStyle(
                          fontFamily: "Mont",
                          fontSize: 14.sp,
                          color: isDarkMode ? AppColors.white : AppColors.black,
                          fontWeight: FontWeight.w500),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
