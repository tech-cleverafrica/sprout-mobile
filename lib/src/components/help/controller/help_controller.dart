import 'dart:io';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sprout_mobile/src/api-setup/api_setup.dart';
import 'package:sprout_mobile/src/api/api_response.dart';
import 'package:sprout_mobile/src/components/help/model/catergories_model.dart';
import 'package:sprout_mobile/src/components/help/service/help_service.dart';
import 'package:sprout_mobile/src/components/help/view/dispense_error.dart';
import 'package:sprout_mobile/src/public/widgets/custom_toast_notification.dart';
import 'package:sprout_mobile/src/utils/nav_function.dart';

class HelpController extends GetxController {
  RxInt currentIndex = 0.obs;
  bool loading = false;
  RxBool categoriesLoading = false.obs;
  bool pendingIssuesLoading = false;
  bool resolvedIssuesLoading = false;
  RxList<Categories> categories = <Categories>[].obs;
  var overview = {};
  String status = "";
  String pending = "";
  String resolved = "";
  List pendingIssues = [
    {"id": 1, "caseId": "CVL-960228000-FAI253"},
    {"id": 1, "caseId": "CVL-960228000-FAI253"},
    {"id": 1, "caseId": "CVL-960228000-FAI253"},
    {"id": 1, "caseId": "CVL-960228000-FAI253"},
    {"id": 1, "caseId": "CVL-960228000-FAI253"},
    {"id": 1, "caseId": "CVL-960228000-FAI253"},
    {"id": 1, "caseId": "CVL-960228000-FAI253"},
    {"id": 1, "caseId": "CVL-960228000-FAI253"},
    {"id": 1, "caseId": "CVL-960228000-FAI253"},
    {"id": 1, "caseId": "CVL-960228000-FAI253"},
    {"id": 1, "caseId": "CVL-960228000-FAI253"},
    {"id": 1, "caseId": "CVL-960228000-FAI253"},
    {"id": 1, "caseId": "CVL-960228000-FAI253"},
    {"id": 1, "caseId": "CVL-960228000-FAI253"},
  ];
  List resolvedIssues = [
    {"id": 1, "caseId": "CVL-960228000-FAI253"},
    {"id": 1, "caseId": "CVL-960228000-FAI253"},
    {"id": 1, "caseId": "CVL-960228000-FAI253"},
    {"id": 1, "caseId": "CVL-960228000-FAI253"},
    {"id": 1, "caseId": "CVL-960228000-FAI253"},
    {"id": 1, "caseId": "CVL-960228000-FAI253"},
    {"id": 1, "caseId": "CVL-960228000-FAI253"},
    {"id": 1, "caseId": "CVL-960228000-FAI253"},
    {"id": 1, "caseId": "CVL-960228000-FAI253"},
    {"id": 1, "caseId": "CVL-960228000-FAI253"},
    {"id": 1, "caseId": "CVL-960228000-FAI253"},
    {"id": 1, "caseId": "CVL-960228000-FAI253"},
    {"id": 1, "caseId": "CVL-960228000-FAI253"},
    {"id": 1, "caseId": "CVL-960228000-FAI253"},
  ];
  int size = 15;

  final storage = GetStorage();
  // RxBool uploadingIdentityCard = false.obs;
  // RxBool uploadingUtilityBill = false.obs;
  bool isIDValid = false;
  bool isUtilityValid = false;

  RxString uploadBillText = "Upload your preferred Utility Bill".obs;
  RxString uploadIdText = "Upload your preferred ID".obs;

  @override
  void onInit() {
    super.onInit();
    getCategories();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  validate() {}

  Future getCategories() async {
    categoriesLoading.value = true;
    AppResponse<List<Categories>> response =
        await locator.get<HelpService>().getCategories();
    categoriesLoading.value = false;
    if (response.status) {
      print(response.data);
      categories.assignAll(response.data!);
    } else {
      CustomToastNotification.show(response.message, type: ToastType.error);
      pop();
    }
  }

  Future uploadAndCommit(File? image, String fileType) async {}

  void processIdUpload(File file) {}

  void processUtilityUpload(File file) {}

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
    //               height: 200.h,
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
    //                           "Your complaint has been received. This will be resolved within 24hrs.",
    //                           style: theme.textTheme.subtitle2,
    //                         ),
    //                         addVerticalSpace(5.h),
    //                         Text(
    //                           "Your Case ID is:",
    //                           style: theme.textTheme.subtitle2,
    //                         ),
    //                         addVerticalSpace(5.h),
    //                         Text(
    //                           "CLV-492250000-APP124",
    //                           style: theme.textTheme.headline6,
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

  Future<void> getPendingIssues() async {}
}
