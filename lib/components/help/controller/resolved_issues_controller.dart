import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sprout_mobile/api-setup/api_setup.dart';
import 'package:sprout_mobile/api/api_response.dart';
import 'package:sprout_mobile/components/help/service/help_service.dart';
import 'package:sprout_mobile/components/authentication/service/auth_service.dart';
import 'package:sprout_mobile/public/model/file_model.dart';
import 'package:sprout_mobile/components/help/model/issues_model.dart';
import 'package:sprout_mobile/public/services/shared_service.dart';
import 'package:sprout_mobile/public/widgets/custom_toast_notification.dart';
import 'package:sprout_mobile/utils/app_colors.dart';

class ResolvedIssuesController extends GetxController {
  final storage = GetStorage();
  TextEditingController descriptionController = new TextEditingController();
  File? file;
  RxList<NamedFile> files = <NamedFile>[].obs;
  RxString fileError = "".obs;
  RxBool loading = false.obs;
  RxBool reopened = false.obs;

  @override
  void onInit() {
    super.onInit();
    // storage.remove("removeAll");
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
    // storage.write('removeAll', "1");
  }

  void setDescription(Issues issue) {
    descriptionController = TextEditingController(text: issue.issueDescription);
  }

  void addFiles(Issues issue) {
    files.clear();
    if (issue.supportingFiles != null) {
      issue.supportingFiles.forEach(
        (e) => files
            .add(NamedFile.fromJson({"name": e.split("/").last, "file": e})),
      );
    }
  }

  processFile(File file) {
    String message = locator.get<SharedService>().validateFileSize(file, 1);
    if (message == "") {
      fileError.value = "";
      loading.value = true;
      uploadAndCommit(file, "issue");
    } else {
      fileError.value = message;
    }
  }

  addFile(File file, String url) {
    var name = file.path.split("/").last;
    var data = {"name": name, "file": url};
    files.add(NamedFile.fromJson(data));
  }

  removeFile(int index) {
    files.removeAt(index);
  }

  Future<Issues?> validate(Issues issue) async {
    if (descriptionController.text.isNotEmpty &&
        descriptionController.text.length >= 20 &&
        descriptionController.text.length <= 500) {
      List<String> supportingDocuments =
          await locator.get<SharedService>().allFilesUrl(files);
      String agentProfileId = storage.read("userId");
      Issues? returneedIssue = await reopenIssue(
          buildRequestModel(
              agentProfileId, descriptionController.text, supportingDocuments),
          issue.id ?? "");
      return returneedIssue;
    } else if (descriptionController.text.isEmpty) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
          content: Text("Issue description cannot be empty"),
          backgroundColor: AppColors.errorRed));
    } else if (descriptionController.text.length < 20) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
          content: Text("Issue description is too short"),
          backgroundColor: AppColors.errorRed));
    } else if (descriptionController.text.length > 500) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
          content: Text("Issue description should be more than 500 characters"),
          backgroundColor: AppColors.errorRed));
    } else {
      ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
          content: Text("All fields are required"),
          backgroundColor: AppColors.errorRed));
    }
    return null;
  }

  Future<Issues?> reopenIssue(Map<String, dynamic> model, String id) async {
    AppResponse<Issues> response =
        await locator.get<HelpService>().reopenIssue(model, id);
    if (response.status) {
      final Issues issue = response.data;
      return issue;
    } else if (response.statusCode == 999) {
      AppResponse res = await locator.get<AuthService>().refreshUserToken();
      if (res.status) {
        reopenIssue(model, id);
      }
    } else {
      CustomToastNotification.show(response.message, type: ToastType.error);
    }
    return null;
  }

  Future uploadAndCommit(File image, String fileType) async {
    AppResponse response =
        await locator.get<SharedService>().uploadAndCommit(image, fileType);
    if (response.status) {
      addFile(image, response.data["data"]);
      loading.value = false;
    } else if (response.statusCode == 999) {
      AppResponse res = await locator.get<AuthService>().refreshUserToken();
      if (res.status) {
        uploadAndCommit(image, fileType);
      }
    } else {
      CustomToastNotification.show(response.message, type: ToastType.error);
    }
  }

  buildRequestModel(String agentProfileId, String issueDescription,
      List<String> supportingDocuments) {
    return {
      "agentProfileId": agentProfileId,
      "supportingFiles": supportingDocuments,
      "description": issueDescription
    };
  }
}
