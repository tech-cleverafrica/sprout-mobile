import 'package:flutter/material.dart';
import 'package:sprout_mobile/src/utils/app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sprout_mobile/src/utils/app_images.dart';
import 'package:url_launcher/url_launcher.dart' as launcher;

class ContactUs extends StatefulWidget {
  ContactUs({required this.heading, required this.title, required this.phone});
  final String heading;
  final String title;
  final String phone;
  @override
  _ContactUsState createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> scaleAnimation;

  @override
  void initState() {
    super.initState();

    controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 200));
    scaleAnimation =
        CurvedAnimation(parent: controller, curve: Curves.easeInOut);
    controller.addListener(() {
      setState(() {});
    });
    controller.forward();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void launchWhatsapp() async {
    String url = "whatsapp://send?phone=${widget.phone}";
    await launcher.launchUrl(Uri.parse(url));
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Material(
        color: AppColors.transparent,
        child: Stack(alignment: Alignment.center, children: [
          GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Container(
                height: MediaQuery.of(context).size.height,
                alignment: Alignment.center,
                color: Colors.transparent,
                width: double.infinity,
              )),
          ScaleTransition(
            scale: scaleAnimation,
            child: Container(
              height: 180.h,
              width: MediaQuery.of(context).size.width * 0.85,
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: isDarkMode ? AppColors.black : AppColors.white,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    widget.heading,
                    style: TextStyle(
                      color: isDarkMode ? AppColors.white : AppColors.black,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      height: 1.5,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    "Please call our customer support line or contact us on WhatsApp",
                    style: TextStyle(
                      color: isDarkMode ? AppColors.white : AppColors.black,
                      fontSize: 12.sp,
                      height: 1.5,
                    ),
                  ),
                  SizedBox(height: 20),
                  GestureDetector(
                    onTap: () =>
                        launcher.launchUrl(Uri.parse("tel:${widget.phone}")),
                    child: Container(
                      color: AppColors.transparent,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            widget.title,
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: isDarkMode
                                  ? AppColors.white
                                  : AppColors.black,
                            ),
                          ),
                          Image.asset(
                            isDarkMode
                                ? AppImages.call_light
                                : AppImages.call_dark,
                            height: 14,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  GestureDetector(
                    onTap: () => launchWhatsapp(),
                    child: Container(
                      color: AppColors.transparent,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            widget.title,
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: isDarkMode
                                  ? AppColors.white
                                  : AppColors.black,
                            ),
                          ),
                          Image.asset(
                            AppImages.whatsapp,
                            height: 14,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ]));
  }
}
