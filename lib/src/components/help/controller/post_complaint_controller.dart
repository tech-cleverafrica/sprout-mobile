import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sprout_mobile/src/api-setup/api_setup.dart';
import 'package:sprout_mobile/src/api/api_response.dart';
import 'package:sprout_mobile/src/components/help/model/issues_sub_category_model.dart';
import 'package:sprout_mobile/src/components/help/service/help_service.dart';
import 'package:sprout_mobile/src/public/model/file_model.dart';
import 'package:sprout_mobile/src/components/help/model/issues_model.dart';
import 'package:sprout_mobile/src/public/services/shared_service.dart';
import 'package:sprout_mobile/src/public/widgets/custom_toast_notification.dart';
import 'package:sprout_mobile/src/utils/app_colors.dart';

class PostComplaintController extends GetxController {
  final storage = GetStorage();
  TextEditingController descriptionController = new TextEditingController();
  File? file;
  RxList<NamedFile> files = <NamedFile>[].obs;
  RxString fileError = "".obs;
  RxBool loading = false.obs;
  List<IssuesSubCategory> issuesSubCategories = [];
  RxList subCategoriesname = [].obs;
  final issuesSubCategory = Rxn<IssuesSubCategory>();
  final dispenseSubCategory = Rxn<IssuesSubCategory>();
  RxBool isFileRequired = false.obs;
  String category = "";

  @override
  void onInit() {
    super.onInit();
    file = null;
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void setDescription(Issues issue) {
    descriptionController = TextEditingController(text: issue.issueDescription);
  }

  void addFiles(Issues issue) {
    issue.supportingFiles.forEach(
      (e) =>
          files.add(NamedFile.fromJson({"name": e.split("/").last, "file": e})),
    );
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

  void setCategory(String parentCategory) {
    category = parentCategory;
  }

  Future<List<String>> allSubCategories(List<IssuesSubCategory> p) async {
    if (p.length > 0) {
      List<String> ps = p.map<String>((e) => e.name ?? "").toList();
      return ps;
    }
    return [];
  }

  Future<void> getSubCategories(String id) async {
    AppResponse<List<IssuesSubCategory>> response =
        await locator.get<HelpService>().getSubCategories(id, "Please wait");
    issuesSubCategories.clear();
    subCategoriesname.clear();
    if (response.status) {
      issuesSubCategories.assignAll(response.data!);
      var names = await allSubCategories(issuesSubCategories);
      subCategoriesname.addAll(names);
    } else {
      CustomToastNotification.show(response.message, type: ToastType.error);
    }
  }

  Future<String> sortPackage(String value) async {
    IssuesSubCategory x =
        issuesSubCategories.firstWhere((i) => i.name == value);
    isFileRequired.value = false;
    if (x.subcategory == 'DISPENSE_ERROR') {
      issuesSubCategory.value = null;
      dispenseSubCategory.value = x;
      return x.subcategory ?? "";
    } else {
      issuesSubCategory.value = x;
    }

    if (x.subcategory == 'APPROVED_TRANSACTION_NOT_SETTLED_TO_THE_WALLET') {
      isFileRequired.value = true;
    }
    return "";
  }

  Future uploadAndCommit(File image, String fileType) async {
    AppResponse response = await locator
        .get<SharedService>()
        .uploadAndCommit(image, fileType, "Please wait");
    if (response.status) {
      addFile(image, response.data["data"]);
      loading.value = false;
    } else {
      CustomToastNotification.show(response.message, type: ToastType.error);
    }
  }

  Future<Issues?> validate() async {
    if (descriptionController.text.isNotEmpty &&
        descriptionController.text.length >= 20 &&
        descriptionController.text.length <= 500 &&
        (!isFileRequired.value || isFileRequired.value && files.length > 0)) {
      List<String> supportingDocuments =
          await locator.get<SharedService>().allFilesUrl(files);
      Issues? returneedIssue = await submitIssue(
          buildRequestModel(descriptionController.text, supportingDocuments));
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
    } else if (isFileRequired.value) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
          content: Text("Please attach receipt or evidence"),
          backgroundColor: AppColors.errorRed));
    } else {
      ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
          content: Text("All fields are required"),
          backgroundColor: AppColors.errorRed));
    }
    return null;
  }

  Future<Issues?> submitIssue(Map<String, dynamic> model) async {
    AppResponse<Issues> response =
        await locator.get<HelpService>().submitIssue(model, "Please wait");
    if (response.status) {
      final Issues issue = response.data;
      return issue;
    } else {
      CustomToastNotification.show(response.message, type: ToastType.error);
    }
    return null;
  }

  buildRequestModel(String issueDescription, List<String> supportingDocuments) {
    String agentId = storage.read("agentId");
    String profileId = storage.read("userId");
    return {
      "issueCategory": category,
      "agentId": agentId,
      "profileId": profileId,
      "issueSubCategory": issuesSubCategory.value?.subcategory,
      "sla": issuesSubCategory.value?.sla,
      "issueDescription": issueDescription,
      "supportingDocuments": supportingDocuments,
    };
  }
}
