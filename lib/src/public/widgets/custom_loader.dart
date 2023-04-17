import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sprout_mobile/src/utils/app_colors.dart';

class CustomLoader {
  static show({bool dismissOnTap = false}) async {
    // Dismiss previous loader if any
    if (EasyLoading.isShow) EasyLoading.dismiss();
    EasyLoading.show(dismissOnTap: dismissOnTap);
  }

  // static show({String? message, bool dismissOnTap = false}) async {
  //   // Dismiss previous loader if any
  //   if (EasyLoading.isShow) EasyLoading.dismiss();
  //   message == null
  //       ? EasyLoading.show(dismissOnTap: dismissOnTap)
  //       : EasyLoading.show(status: message, dismissOnTap: dismissOnTap);
  // }

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

Widget buildBillsShimmer() {
  return Shimmer.fromColors(
    baseColor: AppColors.primaryColor.withOpacity(0.7),
    highlightColor: Colors.grey.withOpacity(0.7),
    enabled: true,
    child: Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: AppColors.primaryColor.withOpacity(0.1),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          children: [
            Container(
              height: 35,
              width: 35,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.primaryColor.withOpacity(0.1),
              ),
            ),
          ],
        ),
      ),
    ),
  );
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

Widget buildSlimShimmer(count) {
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
        return buildSlimLoadingContainer();
      },
    ),
  );
}

Widget buildSlimLoadingContainer() {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 10),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(8),
      color: AppColors.primaryColor.withOpacity(0.1),
    ),
    child: Padding(
      padding: const EdgeInsets.all(12),
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.primaryColor.withOpacity(0.1),
              ),
            ),
          ),
          SizedBox(width: 10),
          Expanded(
            flex: 4,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 15,
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

Widget buildLargeShimmer() {
  return Shimmer.fromColors(
    baseColor: AppColors.primaryColor.withOpacity(0.7),
    highlightColor: Colors.grey.withOpacity(0.7),
    enabled: true,
    child: buildLargeLoadingContainer(),
  );
}

Widget buildLargeLoadingContainer() {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 10),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      color: AppColors.primaryColor.withOpacity(0.1),
    ),
    child: Padding(
      padding: const EdgeInsets.fromLTRB(30, 15, 15, 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 175,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
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
          Container(
            height: 40,
            width: 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: AppColors.primaryColor.withOpacity(0.1),
            ),
          ),
        ],
      ),
    ),
  );
}
