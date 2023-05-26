import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sprout_mobile/api-setup/api_setup.dart';
import 'package:sprout_mobile/api/api_response.dart';
import 'package:sprout_mobile/components/help/model/issues_sub_category_model.dart';
import 'package:sprout_mobile/components/authentication/service/auth_service.dart';
import 'package:sprout_mobile/components/help/service/help_service.dart';
import 'package:sprout_mobile/public/model/file_model.dart';
import 'package:sprout_mobile/components/help/model/issues_model.dart';
import 'package:sprout_mobile/public/services/shared_service.dart';
import 'package:sprout_mobile/public/widgets/custom_toast_notification.dart';
import 'package:sprout_mobile/utils/app_colors.dart';

class PostComplaintController extends GetxController {
  final storage = GetStorage();
  TextEditingController descriptionController = new TextEditingController();
  TextEditingController transactionAmountController =
      new TextEditingController();
  TextEditingController cardPANController = new TextEditingController();
  TextEditingController cardNameController = new TextEditingController();
  TextEditingController phoneNumberController = new TextEditingController();
  TextEditingController rrnController = new TextEditingController();
  RxString dateToDisplay = "DD-MM-YYYY".obs;
  RxString transactionDate = "".obs;
  final receipt = Rxn<NamedFile>();
  File? file;
  RxList<NamedFile> files = <NamedFile>[].obs;
  RxString fileError = "".obs;
  RxBool loading = false.obs;
  List<IssuesSubCategory> issuesSubCategories = [];
  RxList subCategoriesname = [].obs;
  RxString subCategoryName = "".obs;
  final issuesSubCategory = Rxn<IssuesSubCategory>();
  final dispenseSubCategory = Rxn<IssuesSubCategory>();
  RxBool isFileRequired = false.obs;
  String category = "";
  IssuesSubCategory? subCategory;

  @override
  void onInit() {
    super.onInit();
    file = null;
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
    receipt.value = NamedFile.fromJson(data);
  }

  removeFile(int? index) {
    if (index == null) {
      receipt.value = null;
    } else {
      files.removeAt(index);
    }
  }

  void setCategory(String parentCategory) {
    category = parentCategory;
  }

  void setSubCategory(IssuesSubCategory? parentSubCategory) {
    subCategory = parentSubCategory;
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
    } else if (response.statusCode == 999) {
      AppResponse res = await locator.get<AuthService>().refreshUserToken();
      if (res.status) {
        getSubCategories(id);
      }
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

  Future<Issues?> validateDispenseError() async {
    if (transactionDate.value == "" ||
        transactionAmountController.text.isEmpty ||
        cardPANController.text.isEmpty ||
        cardNameController.text.isEmpty ||
        phoneNumberController.text.isEmpty ||
        rrnController.text.isEmpty) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
          content: Text("Fields marked (*) are required"),
          backgroundColor: AppColors.errorRed));
    } else if (int.parse(
            transactionAmountController.text.split(",").join("")) ==
        0) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
          content: Text("Invalid amount"),
          backgroundColor: AppColors.errorRed));
    } else if (cardPANController.text.length < 4) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
          content: Text("Card PAN must be 4 digits"),
          backgroundColor: AppColors.errorRed));
    } else if (phoneNumberController.text.length < 11) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
          content: Text("Phone number must be 11 digits"),
          backgroundColor: AppColors.errorRed));
    } else if (rrnController.text.length < 11) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
          content: Text("RRN must be 12 digits"),
          backgroundColor: AppColors.errorRed));
    } else {
      Issues? returneedIssue =
          await submitDispenseError(buildDispenseErrorRequestModel());
      return returneedIssue;
    }
    return null;
  }

  Future<Issues?> submitIssue(Map<String, dynamic> model) async {
    AppResponse<Issues> response =
        await locator.get<HelpService>().submitIssue(model);
    if (response.status) {
      final Issues issue = response.data;
      return issue;
    } else if (response.statusCode == 999) {
      AppResponse res = await locator.get<AuthService>().refreshUserToken();
      if (res.status) {
        submitIssue(model);
      }
    } else {
      CustomToastNotification.show(response.message, type: ToastType.error);
    }
    return null;
  }

  Future<Issues?> submitDispenseError(Map<String, dynamic> model) async {
    AppResponse<Issues> response =
        await locator.get<HelpService>().submitDispenseError(model);
    if (response.status) {
      final Issues issue = response.data;
      return issue;
    } else if (response.statusCode == 999) {
      AppResponse res = await locator.get<AuthService>().refreshUserToken();
      if (res.status) {
        submitDispenseError(model);
      }
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

  buildDispenseErrorRequestModel() {
    String agentId = storage.read("agentId");
    return {
      "category": category,
      "subCategory": subCategory?.subcategory,
      "transactionDate": transactionDate.value,
      "transactionAmount": transactionAmountController.text.split(",").join(),
      "cardName": cardNameController.text,
      "cardPAN": cardPANController.text,
      "cardHolderPhoneNumber": phoneNumberController.text,
      "rrn": rrnController.text,
      "receipt": receipt,
      "agentId": agentId,
      "issueDescription": ""
    };
  }
}
