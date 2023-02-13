import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sprout_mobile/src/utils/app_colors.dart';

class CustomLoader {
  static show({String? message, bool dismissOnTap = false}) async {
    // Dismiss previous loader if any
    if (EasyLoading.isShow) EasyLoading.dismiss();
    message == null
        ? EasyLoading.show(dismissOnTap: dismissOnTap)
        : EasyLoading.show(status: message, dismissOnTap: dismissOnTap);
  }

  static dismiss() async {
    // Dismiss previous loader if any
    if (EasyLoading.isShow) EasyLoading.dismiss();
  }
}

class CustomLoadingContainer extends StatelessWidget {
  Widget build(context) {
    return Column(
      children: [
        ListTile(
          title: buildContainer(),
          subtitle: buildContainer(),
        ),
        Text("fetching record(s)..."),
        Divider(height: 10.0),
      ],
    );
  }

  Widget buildContainer() {
    return Container(
      color: Colors.grey[200],
      height: 24.0,
      width: 150.0,
      margin: EdgeInsets.only(top: 5.0, bottom: 5.0),
    );
  }
}

Widget buildShimmer(count) {
  return Shimmer.fromColors(
    baseColor: AppColors.primaryColor.withOpacity(0.7),
    highlightColor: Colors.grey.withOpacity(0.7),
    enabled: true,
    child: ListView.builder(
      padding: EdgeInsets.only(top: 10),
      physics: ScrollPhysics(),
      shrinkWrap: true,
      itemCount: count,
      itemBuilder: (context, index) {
        return buildLoadingContainer();
      },
    ),
  );
}

Widget buildLoadingContainer() {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 10),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(8),
      color: AppColors.primaryColor.withOpacity(0.1),
    ),
    child: Padding(
      padding: const EdgeInsets.fromLTRB(30, 15, 15, 15),
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.primaryColor.withOpacity(0.1),
              ),
            ),
          ),
          SizedBox(width: 15),
          Expanded(
            flex: 4,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 25,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.grey.withOpacity(0.1),
                  ),
                ),
                SizedBox(height: 15),
                Text(
                  'Loading',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey.withOpacity(0.1),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
