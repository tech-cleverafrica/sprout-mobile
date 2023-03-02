import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sprout_mobile/src/utils/app_colors.dart';

class ComplaintTab extends StatelessWidget {
  ComplaintTab(
      {required this.title,
      required this.index,
      required this.currentIndex,
      required this.setIndex,
      required this.withBadge,
      required this.badge});
  final String title;
  final int index;
  final int currentIndex;
  final Function(int) setIndex;
  final bool withBadge;
  final String badge;

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return GestureDetector(
      onTap: () => setIndex(index),
      child: Container(
        child: Column(
          children: [
            withBadge
                ? Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          color: currentIndex == index
                              ? isDarkMode
                                  ? AppColors.white
                                  : AppColors.black
                              : isDarkMode
                                  ? Color.fromRGBO(110, 113, 120, 1)
                                  : Color.fromRGBO(12, 31, 69, 1)
                                      .withOpacity(0.3),
                          fontWeight: FontWeight.w900,
                          fontSize: 12.sp,
                        ),
                      ),
                      badge != ""
                          ? Container(
                              height: 12,
                              width: 12,
                              margin: EdgeInsets.only(left: 8, top: 0),
                              alignment: Alignment.center,
                              child: Text(
                                badge,
                                style: TextStyle(
                                  color: isDarkMode
                                      ? AppColors.white
                                      : AppColors.black,
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                            )
                          : SizedBox(),
                    ],
                  )
                : Text(
                    title,
                    style: TextStyle(
                      color: currentIndex == index
                          ? isDarkMode
                              ? AppColors.white
                              : AppColors.black
                          : isDarkMode
                              ? Color.fromRGBO(110, 113, 120, 1)
                              : Color.fromRGBO(12, 31, 69, 1).withOpacity(0.3),
                      fontWeight: FontWeight.w900,
                      fontSize: 12.sp,
                    ),
                  ),
            SizedBox(height: 5),
            currentIndex == index
                ? Container(
                    height: 4,
                    width: MediaQuery.of(context).size.width * 0.25,
                    decoration: BoxDecoration(
                      color: isDarkMode ? AppColors.white : AppColors.black,
                      borderRadius: BorderRadius.circular(5),
                    ),
                  )
                : Container(
                    margin: EdgeInsets.only(top: 2),
                    height: 1,
                    width: MediaQuery.of(context).size.width * 0.25,
                    color: isDarkMode ? AppColors.white : AppColors.black),
          ],
        ),
      ),
    );
  }
}
