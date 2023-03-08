import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sprout_mobile/src/api-setup/api_setup.dart';
import 'package:sprout_mobile/src/components/help/model/file_model.dart';
import 'package:sprout_mobile/src/components/help/model/issues_model.dart';
import 'package:sprout_mobile/src/components/help/service/help_service.dart';
import 'package:sprout_mobile/src/components/help/view/dispense_error.dart';

class ResolvedIssuesController extends GetxController {
  TextEditingController description = new TextEditingController();
  File? file, fileToUpload;
  RxList<NamedFile> files = <NamedFile>[].obs;
  RxString fileError = "".obs;
  RxBool loading = false.obs;
  RxBool reopened = false.obs;

  @override
  void onInit() {
    super.onInit();
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
    description = TextEditingController(text: issue.issueDescription);
  }

  void addFiles(Issues issue) {
    issue.supportingFiles.forEach(
      (e) =>
          files.add(NamedFile.fromJson({"name": e.split("/").last, "file": e})),
    );
  }

  processFile(File file) {
    String message = locator.get<HelpService>().validateFileSize(file, 1);
    if (message == "") {
      fileToUpload = file;
      fileError.value = "";
      loading.value = true;
      uploadAndCommit();
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

  Future uploadAndCommit() async {}

  void processIdUpload(File file) {}

  void processUtilityUpload(File file) {}

  Future<void> submitIssue(issue) async {}

  Future<void> updateIssue() async {
    submitCallback(null);
    // widget.refreshIssue();
  }

  Future<void> reopenIssue() async {
    // if (description.text.isNotEmpty &&
    //     description.text.length >= 20 &&
    //     description.text.length <= 500) {
    //   setState(() => loading = true);
    //   List<String> supportingDocuments =
    //       await ResolutionService().allFilesUrl(files);
    //   var response = await ResolutionService()
    //       .reopenIssue(
    //           context, widget.issue.id, description.text, supportingDocuments)
    //       .catchError((e) {
    //     setState(() => loading = false);
    //   });
    //   if (response.statusCode == 200 && jsonDecode(response.body)["status"]) {
    //     setState(() => loading = false);
    //     var data = jsonDecode(response.body)["data"];
    //     final Issue issue = Issue.fromJson(data);
    //     Future.delayed(const Duration(milliseconds: 500),
    //         () => {widget.onReopened(issue), Navigator.pop(context)});
    //   } else if (response.statusCode == 401) {
    //     refreshToken(context, reopenIssue);
    //   } else {
    //     setState(() => loading = false);
    //     try {
    //       if (jsonDecode(response.body)["message"] != '' ||
    //           jsonDecode(response.body)["message"] != null) {
    //         snackBar(jsonDecode(response.body)["message"]);
    //       } else {
    //         snackBar(jsonDecode(response.body)["message"]);
    //       }
    //     } catch (e) {
    //       snackBar(response.body);
    //     }
    //   }
    // } else if (description.text.isEmpty) {
    //   snackBar('Issue description cannot be empty');
    // } else if (description.text.length < 20) {
    //   snackBar('Issue description is too short');
    // } else if (description.text.length > 500) {
    //   snackBar('Issue description should be more than 500 characters');
    // }
  }

  buildRequestModel(bvn, identityCard, utilityBill) {
    return {
      "bvn": bvn,
      "identityCard": identityCard,
      "utilityBill": utilityBill
    };
  }

  void submitCallback(void issue) {
    // final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    // final theme = Theme.of(context);
    // Future.delayed(
    //     Duration(seconds: 1),
    //     () => showDialog(
    //         context: context,
    //         barrierDismissible: true,
    //         builder: ((context) {
    //           return Dialog(
    //             backgroundColor:
    //                 isDarkMode ? AppColors.blackBg : AppColors.white,
    //             shape: RoundedRectangleBorder(
    //                 borderRadius: BorderRadius.circular(10.0)),
    //             child: Container(
    //               height: 130.h,
    //               child: Padding(
    //                 padding: const EdgeInsets.symmetric(
    //                     vertical: 20, horizontal: 20),
    //                 child: Column(
    //                   children: [
    //                     addVerticalSpace(5.h),
    //                     Column(
    //                       crossAxisAlignment: CrossAxisAlignment.start,
    //                       children: [
    //                         Text(
    //                           "Dear Oluwaseun,",
    //                           style: theme.textTheme.subtitle2,
    //                         ),
    //                         addVerticalSpace(5.h),
    //                         Text(
    //                           "Your complaint has been updated successfully.",
    //                           style: theme.textTheme.subtitle2,
    //                         ),
    //                         addVerticalSpace(10.h),
    //                         Text(
    //                           "Thank You!",
    //                           style: theme.textTheme.subtitle2,
    //                         ),
    //                       ],
    //                     )
    //                   ],
    //                 ),
    //               ),
    //             ),
    //           );
    //         })));
  }

  void navigateNext(String title, String category, void dispenseSubCategory) {
    Future.delayed(
      const Duration(seconds: 1),
      () => {
        Get.to(() => DispenseErrorScreen(
              title: "",
              category: "",
              data: null,
              onSubmit: ((issue) => {submitCallback(issue)}),
            ))
      },
    );
  }
}
