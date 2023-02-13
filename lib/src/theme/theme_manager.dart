import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_storage/get_storage.dart';

CustomTheme currentTheme = CustomTheme();

class CustomTheme with ChangeNotifier {
  static final box = GetStorage();
  static bool _isDarkTheme = box.read('isDark') ?? false;
  ThemeMode get currentTheme => _isDarkTheme ? ThemeMode.dark : ThemeMode.light;

  void toggleTheme() {
    _isDarkTheme = !_isDarkTheme;
    box.write('isDark', _isDarkTheme);
    notifyListeners();
  }

  static ThemeData get lightTheme {
    return ThemeData(
      primaryColor: Color(0xFF3D02E6),
      backgroundColor: Colors.white,
      scaffoldBackgroundColor: Colors.white,
      textTheme: TextTheme(
          headline1: TextStyle(
              color: Colors.black, fontFamily: "DMSans", fontSize: 24.sp),
          headline2: TextStyle(color: Colors.black),
          bodyText1: TextStyle(color: Colors.black),
          bodyText2: TextStyle(
              color: Color(
                0xFF8d8d8d,
              ),
              fontFamily: "DMSans",
              fontSize: 12,
              fontWeight: FontWeight.w400)),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      primaryColor: Color(0xFF3D02E6),
      backgroundColor: Colors.black,
      scaffoldBackgroundColor: Colors.black,
      textTheme: TextTheme(
          headline1: TextStyle(color: Colors.white),
          headline2: TextStyle(color: Colors.white),
          bodyText1: TextStyle(color: Colors.white),
          bodyText2: TextStyle(
              color: Color(
                0xFFFDFDFD,
              ),
              fontFamily: "DMSans",
              fontSize: 12,
              fontWeight: FontWeight.w400)),
    );
  }
}
