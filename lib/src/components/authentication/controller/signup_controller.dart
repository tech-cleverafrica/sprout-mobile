import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sprout_mobile/src/api/api_constant.dart';
import 'package:sprout_mobile/src/components/authentication/model/response_model.dart';
import 'package:sprout_mobile/src/components/authentication/view/sign_up_create_login.dart';
import 'package:sprout_mobile/src/components/authentication/view/sign_up_personal2.dart';
import 'package:sprout_mobile/src/components/authentication/view/signup_otp_screen.dart';
import 'package:sprout_mobile/src/components/home/view/bottom_nav.dart';
import 'package:sprout_mobile/src/utils/app_svgs.dart';
import 'package:sprout_mobile/src/utils/constants.dart';
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

  TextEditingController otpController = new TextEditingController();

  RxString birthDate = "YYYY/    MM/     DAY".obs;
  DateTime? pickedStartDate;
  RxInt currentIndex = 0.obs;
  List<String> genders = ["Male", "Female"];
  bool matched = false;
  final List<String> states = <String>[
    "Abia",
    "Abuja",
    "Adamawa",
    "Akwa Ibom",
    "Anambra",
    "Bauchi",
    "Bayelsa",
    "Benue",
    "Borno",
    "Cross River",
    "Delta",
    "Ebonyi",
    "Edo",
    "Ekiti",
    "Enugu",
    "Gombe",
    "Imo",
    "Jigawa",
    "Kaduna",
    "Kano",
    "Katsina",
    "Kebbi",
    "Kogi",
    "Kwara",
    "Lagos",
    "Nasarawa",
    "Niger",
    "Ogun",
    "Ondo",
    "Osun",
    "Oyo",
    "Plateau",
    "Rivers",
    "Sokoto",
    "Taraba",
    "Yobe",
    "Zamfara",
  ]..sort();

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
      "firstName": firstName.trim(),
      "lastName": lastName.trim(),
      "email": email.trim(),
      "password": password.trim(),
      "phoneNumber": phone.trim(),
      "gender": gender.trim(),
      "roleGroup": "agent",
      "dateOfBirth": dob.trim(),
      "businessName": businessName.trim(),
      "address": fullAddress.trim(),
      "city": city.trim(),
      "state": state.trim(),
      "refferalCode": referral.trim(),
      "otp": otpController.text.trim(),
      "agentDeviceId": "767867yuj778",
    };
  }

  buildEmailVerificationModel() {
    return {
      "email": email.trim(),
    };
  }

  buildRequestModel() {
    return {"username": email.trim(), "password": password.trim()};
  }

  validatePersonalDetails() {
    if (firstnameController.text.length > 1 &&
        lastNameController.text.length > 1 &&
        birthDate.value.isNotEmpty &&
        genderController.text.isNotEmpty) {
      firstName = firstnameController.text;
      lastName = lastNameController.text;
      dob = birthDate.value;
      push(page: SignupPersonal2());
    } else if (firstnameController.text.isEmpty &&
        lastNameController.text.isEmpty &&
        birthDate.value.isEmpty &&
        genderController.text.isEmpty) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
          content: Text("Please supply all required inputs"),
          backgroundColor: AppColors.errorRed));
    } else if (firstnameController.text.isEmpty) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
          content: Text("First name is required"),
          backgroundColor: AppColors.errorRed));
    } else if (lastNameController.text.isEmpty) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
          content: Text("Last name is required"),
          backgroundColor: AppColors.errorRed));
    } else if (firstnameController.text.length < 1) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
          content: Text("First name is too short"),
          backgroundColor: AppColors.errorRed));
    } else if (lastNameController.text.length < 1) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
          content: Text("Last name is too short"),
          backgroundColor: AppColors.errorRed));
    } else if (birthDate.value.isEmpty) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
          content: Text("Date of Birth is required"),
          backgroundColor: AppColors.errorRed));
    } else if (genderController.text.isEmpty) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
          content: Text("Gender is required"),
          backgroundColor: AppColors.errorRed));
    } else {
      ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
          content: Text("Please supply all required inputs"),
          backgroundColor: AppColors.errorRed));
    }
  }

  validateBusinessInfo() {
    if (fullAddressController.text.length > 5 &&
        cityController.text.length > 1 &&
        stateController.text.isNotEmpty &&
        (businessNameController.text.isEmpty ||
            (businessNameController.text.isNotEmpty &&
                businessNameController.text.length > 2))) {
      businessName = businessNameController.text;
      fullAddress = fullAddressController.text;
      city = cityController.text;
      state = stateController.text;
      referral = referralController.text;
      push(page: SignUpCreateLogin());
    } else if (fullAddressController.text.isEmpty &&
        cityController.text.isEmpty &&
        stateController.text.isEmpty) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
          content: Text("Please supply all required inputs"),
          backgroundColor: AppColors.errorRed));
    } else if (fullAddressController.text.isEmpty) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
          content: Text("Address is required"),
          backgroundColor: AppColors.errorRed));
    } else if (cityController.text.isEmpty) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
          content: Text("City is required"),
          backgroundColor: AppColors.errorRed));
    } else if (stateController.text.isEmpty) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
          content: Text("State is required"),
          backgroundColor: AppColors.errorRed));
    } else if (fullAddressController.text.length < 6) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
          content: Text("Address should be at least 6 characters"),
          backgroundColor: AppColors.errorRed));
    } else if (cityController.text.length < 2) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
          content: Text("City should be at least 2 characters"),
          backgroundColor: AppColors.errorRed));
    } else if (businessNameController.text.isNotEmpty &&
        businessNameController.text.length < 3) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
          content: Text("Business name should be at least 3 characters"),
          backgroundColor: AppColors.errorRed));
    } else {
      ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
          content: Text("Please supply all required inputs"),
          backgroundColor: AppColors.errorRed));
    }
  }

  validateLoginDetails() {
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    print(emailController.text +
        " " +
        phoneController.text +
        " " +
        passwordController.text +
        " " +
        confirmPasswordController.text);
    if (emailController.text.isNotEmpty &&
        phoneController.text.length == 11 &&
        (regex.hasMatch(emailController.text)) &&
        matched &&
        passwordController.text.isNotEmpty &&
        confirmPasswordController.text.isNotEmpty &&
        passwordController.text == confirmPasswordController.text) {
      email = emailController.text;
      phone = phoneController.text;
      password = confirmPasswordController.text;
      verifyEmail(buildEmailVerificationModel());
    } else if (emailController.text.isEmpty) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
          content: Text("Email Address is required"),
          backgroundColor: AppColors.errorRed));
    } else if (!(regex.hasMatch(emailController.text))) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
          content: Text("Please enter a valid email"),
          backgroundColor: AppColors.errorRed));
    } else if (phoneController.text.isEmpty) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
          content: Text("Phone Number is required"),
          backgroundColor: AppColors.errorRed));
    } else if (phoneController.text.length != 11) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
          content: Text("Phone number must be 11 digits"),
          backgroundColor: AppColors.errorRed));
    } else if (passwordController.text.isEmpty) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
          content: Text("Password is required"),
          backgroundColor: AppColors.errorRed));
    } else if (!matched) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
          content: Text("Invalid password"),
          backgroundColor: AppColors.errorRed));
    } else if (confirmPasswordController.text.isEmpty) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
          content: Text("Confirm password is required"),
          backgroundColor: AppColors.errorRed));
    } else if (passwordController.text != confirmPasswordController.text) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
          content: Text("Passwords does not match"),
          backgroundColor: AppColors.errorRed));
    } else {
      ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
          content: Text("Please supply all required inputs"),
          backgroundColor: AppColors.errorRed));
    }
  }

  selectDob() async {
    pickedStartDate = await showRangeDatePicker();
    if (pickedStartDate != null) {
      birthDate.value = DateFormat('yyyy-MM-dd').format(pickedStartDate!);
    }
  }

  verifyEmail(Map<String, dynamic> request) async {
    AppResponse response =
        await locator.get<AuthService>().verifyEmail(request);
    if (response.status) {
      push(page: SignupOtpScreen());
    } else {
      CustomToastNotification.show(response.message, type: ToastType.error);
    }
  }

  createUser() async {
    Map<String, dynamic> request = buildSignUpRequest();
    AppResponse response = await locator.get<AuthService>().createUser(request);
    if (response.status) {
      CustomToastNotification.show("Account creation successful",
          type: ToastType.success);
      signIn(buildRequestModel());
    } else {
      CustomToastNotification.show(response.message, type: ToastType.error);
    }
  }

  signIn(Map<String, dynamic> model) async {
    AppResponse<SignInResponseModel> response =
        await locator.get<AuthService>().signIn(model);
    if (response.status) {
      saveLoginDetailsToSharePref(model);
      preferenceRepository.setStringPref("storedMail", model['username']);
      setLoginStatus(true);
      getUserInfo();
    } else {
      CustomToastNotification.show(response.message, type: ToastType.error);
    }
  }

  getUserInfo() async {
    AppResponse response = await locator.get<AuthService>().getUserDetails();
    if (response.status) {
      setLoginStatus(true);
      pushUntil(page: BottomNav());
      CustomToastNotification.show(response.message, type: ToastType.success);
    } else {
      CustomToastNotification.show(response.message, type: ToastType.error);
    }
  }

  saveLoginDetailsToSharePref(model) {
    preferenceRepository.setStringPref(SECURED_USER_MAIL, model["username"]);
    preferenceRepository.setStringPref(SECURED_PASSWORD, model["password"]);
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

  showStateList(context, isDarkMode) {
    return showModalBottomSheet(
        backgroundColor: AppColors.transparent,
        context: context,
        isScrollControlled: true,
        builder: (context) {
          return FractionallySizedBox(
            heightFactor: 0.6,
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
                              "Select State",
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
                          itemCount: states.length,
                          shrinkWrap: true,
                          physics: BouncingScrollPhysics(),
                          itemBuilder: ((context, index) {
                            return Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 10.h, horizontal: 20.w),
                              child: GestureDetector(
                                onTap: () {
                                  pop();
                                  stateController.text = states[index];
                                  state = states[index];
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
                                                states[index],
                                                style: TextStyle(
                                                    fontFamily: "DMSans",
                                                    fontSize: 12.sp,
                                                    fontWeight: stateController
                                                                    .text !=
                                                                "" &&
                                                            stateController
                                                                    .text ==
                                                                states[index]
                                                        ? FontWeight.w700
                                                        : FontWeight.w600,
                                                    color: isDarkMode
                                                        ? AppColors.mainGreen
                                                        : AppColors
                                                            .primaryColor),
                                              ),
                                              Text(
                                                states[index],
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
                                          stateController.text != "" &&
                                                  stateController.text ==
                                                      states[index]
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
