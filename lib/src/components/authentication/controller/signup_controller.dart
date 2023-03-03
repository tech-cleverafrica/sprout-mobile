import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sprout_mobile/src/components/authentication/view/sign_up_personal2.dart';
import 'package:sprout_mobile/src/utils/nav_function.dart';

import '../../../utils/app_colors.dart';

class SignUpController extends GetxController {
  TextEditingController firstnameController = new TextEditingController();
  TextEditingController lastNameController = new TextEditingController();
  TextEditingController genderController = new TextEditingController();
  TextEditingController dateOfBirthController = new TextEditingController();

  late String firstName;
  late String lastName;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }

  validatePersonalDetails() {
    if (firstnameController.text.isEmpty ||
        lastNameController.text.isEmpty ||
        dateOfBirthController.text.isEmpty) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
          content: Text("Please supply all required inputs"),
          backgroundColor: AppColors.errorRed));
    } else {
      push(page: SignupPersonal2());
    }
  }
}
