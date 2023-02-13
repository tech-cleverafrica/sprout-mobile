import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:get/get.dart';
import 'package:sprout_mobile/src/app_controller.dart';
import 'package:sprout_mobile/src/components/onboarding/splash_screen.dart';
import 'package:sprout_mobile/src/theme/theme_manager.dart';
import 'package:sprout_mobile/src/utils/navigation_service.dart';

class App extends StatefulWidget {
  App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  final AppController appController = Get.put(AppController());

  void initState() {
    super.initState();
    currentTheme.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Listener(
        behavior: HitTestBehavior.translucent,
        onPointerDown: (_) {
          // appController.startTimer();
        },
        child: StyledToast(
          locale: const Locale('en', 'US'),
          toastAnimation: StyledToastAnimation.slideFromTop,
          reverseAnimation: StyledToastAnimation.fade,
          toastPositions: StyledToastPosition.top,
          animDuration: Duration(seconds: 1),
          duration: Duration(seconds: 7),
          curve: Curves.elasticOut,
          reverseCurve: Curves.fastLinearToSlowEaseIn,
          dismissOtherOnShow: true,
          child: ScreenUtilInit(
              designSize: Size(275, 812),
              minTextAdapt: true,
              splitScreenMode: true,
              builder: (context, child) {
                return GetMaterialApp(
                  navigatorKey: NavigationService.navigatorKey,
                  debugShowCheckedModeBanner: false,
                  builder: EasyLoading.init(),
                  theme: CustomTheme.lightTheme,
                  darkTheme: CustomTheme.darkTheme,
                  themeMode: currentTheme.currentTheme,
                  home: SplashScreen(),
                );
              }),
        ));
  }
}
