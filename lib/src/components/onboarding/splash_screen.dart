import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sprout_mobile/src/components/onboarding/onboarding.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  initialize(BuildContext context) async {
    WidgetsFlutterBinding.ensureInitialized();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? firstTime = prefs.getBool('first_time');
    if (firstTime != null && !firstTime) {
      // Not first time
      Timer(Duration(seconds: 3), () async {
        Get.offAll(Onboarding());
      });
    } else {
      // First time
      prefs.setBool('first_time', false);
      Timer(Duration(seconds: 3), () async {
        Get.offAll(() => Onboarding());
      });
    }
  }

  @override
  void initState() {
    super.initState();
    initialize(context);
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height * 0.94,
        child: Stack(
          children: [
            Center(
              child: Image(
                height: 180.0.h,
                width: 120.w,
                image: AssetImage(isDarkMode
                    ? "assets/images/logo-light.png"
                    : "assets/images/logo-dark.png"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
