import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sprout_mobile/utils/app_colors.dart';
import 'package:sprout_mobile/utils/app_images.dart';
import '../controller/complete_account_setup_controller.dart';

// ignore: must_be_immutable
class UploadContainer extends StatelessWidget {
  UploadContainer(
      {required this.title, required this.onTap, required this.error});
  final Widget? title;
  final GestureTapCallback onTap;
  final bool error;

  late CompleteAccountSetupController cASCtrl;
  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    cASCtrl = Get.put(CompleteAccountSetupController());
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 126,
        width: double.infinity,
        alignment: Alignment.bottomCenter,
        decoration: BoxDecoration(
          color: AppColors.transparent,
          image: DecorationImage(
            image: AssetImage(isDarkMode
                ? AppImages.upload_container_light
                : AppImages.upload_container),
            fit: BoxFit.contain,
          ),
        ),
        child: Container(
            height: 40,
            padding: EdgeInsets.symmetric(horizontal: 30),
            alignment: Alignment.topCenter,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                title!,
                Text(' *',
                    style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                        fontSize: 10))
              ],
            )),
      ),
    );
  }
}
