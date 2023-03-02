import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../utils/app_colors.dart';
import '../../../utils/app_svgs.dart';
import '../../../utils/helper_widgets.dart';

class NotificationCard extends StatelessWidget {
  const NotificationCard({
    Key? key,
    required this.theme,
    required this.isDarkMode,
    required this.date,
    required this.notification,
  }) : super(key: key);

  final ThemeData theme;
  final bool isDarkMode;
  final String date;
  final String notification;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 0),
      child: Container(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SvgPicture.asset(
                      AppSvg.message,
                      color: AppColors.primaryColor,
                      height: 18,
                      width: 18,
                    ),
                    addHorizontalSpace(5.w),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          date,
                          style: TextStyle(
                              fontFamily: "DMSans",
                              fontSize: 12.sp,
                              color: isDarkMode
                                  ? AppColors.inputLabelColor
                                  : AppColors.deepGrey,
                              fontWeight: FontWeight.w400),
                        ),
                        addVerticalSpace(5.h),
                        Container(
                          width: MediaQuery.of(context).size.width * .7,
                          child: Text(
                            notification,
                            style: TextStyle(
                                fontFamily: "DMSans",
                                fontSize: 12.sp,
                                color: isDarkMode
                                    ? AppColors.white
                                    : AppColors.black,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  size: 16,
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Divider(
                thickness: 1,
              ),
            )
          ],
        ),
      ),
    );
  }
}
