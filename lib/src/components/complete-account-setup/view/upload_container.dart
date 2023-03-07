import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sprout_mobile/src/utils/app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sprout_mobile/src/utils/app_images.dart';

import '../controller/complete_account_setup_controller.dart';

class UploadContainer extends StatefulWidget {
  UploadContainer(
      {required this.title, required this.onTap, required this.error});
  final Widget? title;
  final GestureTapCallback onTap;
  final bool error;
  @override
  _UploadContainerState createState() => _UploadContainerState();
}

class _UploadContainerState extends State<UploadContainer> {
  late CompleteAccountSetupController cASCtrl;
  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    cASCtrl = Get.put(CompleteAccountSetupController());
    return GestureDetector(
      onTap: widget.onTap,
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
            // margin: EdgeInsets.only(bottom: 25),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Text(
                //   widget.title!,
                //   style: TextStyle(
                //     color: isDarkMode
                //         ? widget.error
                //             ? AppColors.red
                //             : AppColors.white.withAlpha(400)
                //         : widget.error
                //             ? AppColors.red
                //             : Color.fromRGBO(58, 58, 58, 0.7),
                //     fontSize: 12.sp,
                //     fontWeight: FontWeight.w500,
                //   ),
                //   textAlign: TextAlign.center,
                // ),
                widget.title!,
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
