import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sprout_mobile/src/api/api_constant.dart';
import 'package:sprout_mobile/src/components/authentication/view/sign_up_create_login.dart';
import 'package:sprout_mobile/src/components/authentication/view/sign_up_personal2.dart';
import 'package:sprout_mobile/src/utils/app_svgs.dart';
import 'package:sprout_mobile/src/utils/nav_function.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../api-setup/api_setup.dart';
import '../../../api/api_response.dart';
import '../../../public/widgets/custom_toast_notification.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/global_function.dart';
import '../service/auth_service.dart';
import '../view/sign_in_screen.dart';

class SignUpController extends GetxController {
  TextEditingController firstnameController = new TextEditingController();
  TextEditingController lastNameController = new TextEditingController();
  TextEditingController genderController = new TextEditingController();
  TextEditingController dateOfBirthController = new TextEditingController();

  late String firstName;
  late String lastName;
  late String gender;
  late String dob;

  TextEditingController businessNameController = new TextEditingController();
  TextEditingController fullAddressController = new TextEditingController();
  TextEditingController cityController = new TextEditingController();
  TextEditingController stateController = new TextEditingController();
  TextEditingController referralController = new TextEditingController();

  String businessName = "";
  late String fullAddress;
  late String city;
  late String state;
  String referral = "";

  TextEditingController emailController = new TextEditingController();
  TextEditingController phoneController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  TextEditingController confirmPasswordController = new TextEditingController();

  late String email;
  late String phone;
  late String password;

  RxString birthDate = "YYYY/    MM/     DAY".obs;
  DateTime? pickedStartDate;
  RxInt currentIndex = 0.obs;
  List<String> genders = ["Male", "Female"];

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  buildSignUpRequest() {
    return {
      "firstName": firstName,
      "lastName": lastName,
      "email": email,
      "password": password,
      "phoneNumber": phone,
      "gender": gender,
      "roleGroup": "agent",
      "dateOfBirth": dob,
      "businessName": businessName,
      "address": fullAddress,
      "city": city,
      "state": state,
      "refferalCode": referral,
      "agentDeviceId": "767867yuj778"
    };
  }

  validatePersonalDetails() {
    if (firstnameController.text.isEmpty ||
        lastNameController.text.isEmpty ||
        birthDate.value.isEmpty) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
          content: Text("Please supply all required inputs"),
          backgroundColor: AppColors.errorRed));
    } else {
      firstName = firstnameController.text;
      lastName = lastNameController.text;
      dob = birthDate.value;
      gender = "Male";
      push(page: SignupPersonal2());
    }
  }

  validateBusinessInfo() {
    if (fullAddressController.text.isEmpty ||
        cityController.text.isEmpty ||
        stateController.text.isEmpty) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
          content: Text("Please supply all required inputs"),
          backgroundColor: AppColors.errorRed));
    } else {
      businessName = businessNameController.text;
      fullAddress = fullAddressController.text;
      city = cityController.text;
      state = stateController.text;
      referral = referralController.text;
      push(page: SignUpCreateLogin());
    }
  }

  validateLoginDetails() {
    print(emailController.text +
        " " +
        phoneController.text +
        " " +
        passwordController.text +
        " " +
        confirmPasswordController.text);
    if (emailController.text.isEmpty ||
        phoneController.text.isEmpty ||
        passwordController.text.isEmpty ||
        confirmPasswordController.text.isEmpty) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
          content: Text("Please supply all required inputs"),
          backgroundColor: AppColors.errorRed));
    } else if (passwordController.text != confirmPasswordController.text) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
          content: Text("Passwords are not matching"),
          backgroundColor: AppColors.errorRed));
    } else {
      email = emailController.text;
      phone = phoneController.text;
      password = confirmPasswordController.text;
      createUser(buildSignUpRequest());
    }
  }

  selectDob() async {
    pickedStartDate = await showRangeDatePicker();
    if (pickedStartDate != null) {
      birthDate.value = DateFormat('yyyy-MM-dd').format(pickedStartDate!);
    }
  }

  createUser(Map<String, dynamic> request) async {
    AppResponse response = await locator
        .get<AuthService>()
        .createUser(request, "Creating account");
    if (response.status) {
      print(response.message);
      CustomToastNotification.show("Account creation successful",
          type: ToastType.success);
      push(page: SignInScreen());
    } else {
      CustomToastNotification.show(response.message, type: ToastType.error);
    }
  }

  showGenderList(context, isDarkMode) {
    return showModalBottomSheet(
        backgroundColor: AppColors.transparent,
        context: context,
        isScrollControlled: true,
        builder: (context) {
          return FractionallySizedBox(
            heightFactor: 0.4,
            child: Container(
              decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20))),
              child: Container(
                  child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 17.h,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 10.h, horizontal: 20.w),
                            child: Text(
                              "Select Gender",
                              style: TextStyle(
                                  fontFamily: "DMSans",
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w700,
                                  color: isDarkMode
                                      ? AppColors.mainGreen
                                      : AppColors.primaryColor),
                            ),
                          ),
                        ]),
                  ),
                  Expanded(
                      child: ListView.builder(
                          itemCount: genders.length,
                          shrinkWrap: true,
                          physics: BouncingScrollPhysics(),
                          itemBuilder: ((context, index) {
                            return Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 10.h, horizontal: 20.w),
                              child: GestureDetector(
                                onTap: () {
                                  pop();
                                  genderController.text = genders[index];
                                  gender = genders[index];
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: isDarkMode
                                          ? AppColors.inputBackgroundColor
                                          : AppColors.grey,
                                      borderRadius: BorderRadius.circular(15)),
                                  child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 15.w, vertical: 16.h),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                genders[index],
                                                style: TextStyle(
                                                    fontFamily: "DMSans",
                                                    fontSize: 12.sp,
                                                    fontWeight: genderController
                                                                    .text !=
                                                                "" &&
                                                            genderController
                                                                    .text ==
                                                                genders[index]
                                                        ? FontWeight.w700
                                                        : FontWeight.w600,
                                                    color: isDarkMode
                                                        ? AppColors.mainGreen
                                                        : AppColors
                                                            .primaryColor),
                                              ),
                                              Text(
                                                genders[index],
                                                style: TextStyle(
                                                    fontFamily: "DMSans",
                                                    fontSize: 10.sp,
                                                    fontWeight: FontWeight.w500,
                                                    color: isDarkMode
                                                        ? AppColors.white
                                                        : AppColors.black),
                                              )
                                            ],
                                          ),
                                          genderController.text != "" &&
                                                  genderController.text ==
                                                      genders[index]
                                              ? SvgPicture.asset(
                                                  AppSvg.mark_green,
                                                  height: 20,
                                                  color: isDarkMode
                                                      ? AppColors.mainGreen
                                                      : AppColors.primaryColor,
                                                )
                                              : SizedBox()
                                        ],
                                      )),
                                ),
                              ),
                            );
                          })))
                ],
              )),
            ),
          );
        });
  }

  @override
  void onClose() {
    super.onClose();
  }
}
