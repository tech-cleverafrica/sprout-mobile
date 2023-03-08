import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sprout_mobile/src/components/complete-account-setup/controller/complete_account_setup_controller.dart';
import 'package:sprout_mobile/src/components/complete-account-setup/view/upload_container.dart';
import 'package:sprout_mobile/src/public/widgets/general_widgets.dart';
import 'package:sprout_mobile/src/utils/app_images.dart';
import 'package:sprout_mobile/src/utils/helper_widgets.dart';

import '../../../public/widgets/custom_text_form_field.dart';
import '../../../utils/app_colors.dart';

// ignore: must_be_immutable
class DocumentUpload extends StatelessWidget {
  DocumentUpload({super.key});

  late CompleteAccountSetupController cASCtrl;
  final picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    cASCtrl = Get.put(CompleteAccountSetupController());

    return SafeArea(
      child: Scaffold(
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.only(left: 24, right: 24, bottom: 24),
            child: DecisionButton(
              isDarkMode: isDarkMode,
              buttonText: "Done",
              onTap: () {
                cASCtrl.validate();
                // Get.to(() => ApprovalScreen(
                //       containShare: false,
                //       heading:
                //           "Your information has been successfully submitted",
                //       messages:
                //           "You will be notified once your account is verified",
                //     ));
              },
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  getHeader(isDarkMode),
                  addVerticalSpace(15.h),
                  CustomTextFormField(
                    controller: cASCtrl.bvnController,
                    label: "BVN",
                    hintText: "Enter your BVN",
                    maxLength: 11,
                    maxLengthEnforced: true,
                    showCounterText: false,
                    required: true,
                    validator: (value) {
                      if (value?.length != 11)
                        return "BVN must be ${11} digits";
                    },
                    fillColor: isDarkMode
                        ? AppColors.inputBackgroundColor
                        : AppColors.grey,
                  ),
                  SizedBox(height: 20),
                  Stack(alignment: Alignment.topRight, children: [
                    UploadContainer(
                      onTap: () => showDialog(
                          context: (context),
                          builder: (BuildContext context) => Dialog(
                              backgroundColor: isDarkMode
                                  ? AppColors.blackBg
                                  : AppColors.white,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0)),
                              child: Container(
                                height: Platform.isIOS ? 200 : 150,
                                width: MediaQuery.of(context).size.width * 0.85,
                                padding: EdgeInsets.symmetric(
                                    vertical: 15, horizontal: 20),
                                decoration: BoxDecoration(
                                  color:
                                      Theme.of(context).scaffoldBackgroundColor,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Upload your preferred ID",
                                      style: TextStyle(
                                        color: isDarkMode
                                            ? AppColors.white
                                            : AppColors.black,
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    SizedBox(height: 35),
                                    GestureDetector(
                                      onTap: () async {
                                        await picker
                                            .pickImage(
                                                source: ImageSource.camera,
                                                imageQuality: 25)
                                            .then(
                                          (value) {
                                            Navigator.pop(context);
                                            if (value != null) {
                                              cASCtrl.processIdUpload(
                                                  File(value.path));
                                            }
                                          },
                                        );
                                      },
                                      child: Container(
                                        color: Colors.transparent,
                                        child: Row(
                                          children: [
                                            Image.asset(
                                              isDarkMode
                                                  ? AppImages.camera_dark
                                                  : AppImages.camera,
                                              height: 20,
                                            ),
                                            SizedBox(width: 15),
                                            Text(
                                              " Camera",
                                              style: TextStyle(
                                                color: isDarkMode
                                                    ? AppColors.white
                                                    : AppColors.black,
                                                fontSize: 14.sp,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 15),
                                    GestureDetector(
                                      onTap: () async {
                                        await FilePicker.platform.pickFiles(
                                            type: FileType.custom,
                                            allowedExtensions: [
                                              'jpg',
                                              'pdf',
                                              'jpeg',
                                              'png',
                                            ]).then((value) {
                                          Navigator.pop(context);
                                          if (value != null) {
                                            cASCtrl.processIdUpload(File(
                                                value.files.single.path ?? ""));
                                          }
                                        });
                                      },
                                      child: Container(
                                        color: Colors.transparent,
                                        child: Row(
                                          children: [
                                            Image.asset(
                                              isDarkMode
                                                  ? AppImages.file_upload_dark
                                                  : AppImages.file_upload,
                                              height: 25,
                                            ),
                                            SizedBox(width: 15),
                                            Text(
                                              "Choose file",
                                              style: TextStyle(
                                                color: isDarkMode
                                                    ? AppColors.white
                                                    : AppColors.black,
                                                fontSize: 14.sp,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Platform.isIOS
                                        ? SizedBox(height: 15)
                                        : SizedBox(),
                                    Platform.isIOS
                                        ? GestureDetector(
                                            onTap: () async {
                                              await FilePicker.platform
                                                  .pickFiles(
                                                type: FileType.media,
                                              )
                                                  .then((value) {
                                                Navigator.pop(context);
                                                if (value != null) {
                                                  cASCtrl.processIdUpload(File(
                                                      value.files.single.path ??
                                                          ""));
                                                }
                                              });
                                            },
                                            child: Container(
                                              color: Colors.transparent,
                                              child: Row(
                                                children: [
                                                  Image.asset(
                                                    isDarkMode
                                                        ? AppImages.gallery_dark
                                                        : AppImages.gallery,
                                                    height: 25,
                                                  ),
                                                  SizedBox(width: 15),
                                                  Text(
                                                    "Choose image",
                                                    style: TextStyle(
                                                      color: isDarkMode
                                                          ? AppColors.white
                                                          : AppColors.black,
                                                      fontSize: 14.sp,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          )
                                        : SizedBox(),
                                  ],
                                ),
                              ))),
                      title: Obx(
                        () => Text(
                          cASCtrl.uploadIdText.value.toString().split("/").last,
                        ),
                      ),
                      error: cASCtrl.identityCardUploadError != null
                          ? true
                          : false,
                    ),
                  ]),
                  SizedBox(height: 40),
                  Stack(alignment: Alignment.topRight, children: [
                    UploadContainer(
                      onTap: () => showDialog(
                          context: (context),
                          builder: (BuildContext context) => Dialog(
                              backgroundColor: isDarkMode
                                  ? AppColors.blackBg
                                  : AppColors.white,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0)),
                              child: Container(
                                height: Platform.isIOS ? 200 : 150,
                                width: MediaQuery.of(context).size.width * 0.85,
                                padding: EdgeInsets.symmetric(
                                    vertical: 15, horizontal: 20),
                                decoration: BoxDecoration(
                                  color:
                                      Theme.of(context).scaffoldBackgroundColor,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Upload your preferred Utility Bill",
                                      style: TextStyle(
                                        color: isDarkMode
                                            ? AppColors.white
                                            : AppColors.black,
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    SizedBox(height: 35),
                                    GestureDetector(
                                      onTap: () async => await picker
                                          .pickImage(
                                              source: ImageSource.camera,
                                              imageQuality: 25)
                                          .then(
                                        (value) {
                                          Navigator.pop(context);
                                          if (value != null) {
                                            cASCtrl.processUtilityUpload(
                                                File(value.path));
                                          }
                                        },
                                      ),
                                      child: Container(
                                        color: Colors.transparent,
                                        child: Row(
                                          children: [
                                            Image.asset(
                                              isDarkMode
                                                  ? AppImages.camera_dark
                                                  : AppImages.camera,
                                              height: 20,
                                            ),
                                            SizedBox(width: 15),
                                            Text(
                                              " Camera",
                                              style: TextStyle(
                                                color: isDarkMode
                                                    ? AppColors.white
                                                    : AppColors.black,
                                                fontSize: 14.sp,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 15),
                                    GestureDetector(
                                      onTap: () async {
                                        await FilePicker.platform.pickFiles(
                                            type: FileType.custom,
                                            allowedExtensions: [
                                              'jpg',
                                              'pdf',
                                              'jpeg',
                                              'png',
                                            ]).then((value) {
                                          Navigator.pop(context);
                                          if (value != null) {
                                            cASCtrl.processUtilityUpload(File(
                                                value.files.single.path ?? ""));
                                          }
                                        });
                                      },
                                      child: Container(
                                        color: Colors.transparent,
                                        child: Row(
                                          children: [
                                            Image.asset(
                                              isDarkMode
                                                  ? AppImages.file_upload_dark
                                                  : AppImages.file_upload,
                                              height: 25,
                                            ),
                                            SizedBox(width: 15),
                                            Text(
                                              "Choose file",
                                              style: TextStyle(
                                                color: isDarkMode
                                                    ? AppColors.white
                                                    : AppColors.black,
                                                fontSize: 14.sp,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Platform.isIOS
                                        ? SizedBox(height: 15)
                                        : SizedBox(),
                                    Platform.isIOS
                                        ? GestureDetector(
                                            onTap: () async {
                                              await FilePicker.platform
                                                  .pickFiles(
                                                type: FileType.media,
                                              )
                                                  .then((value) {
                                                Navigator.pop(context);
                                                if (value != null) {
                                                  cASCtrl.processUtilityUpload(
                                                      File(value.files.single
                                                              .path ??
                                                          ""));
                                                }
                                              });
                                            },
                                            child: Container(
                                              color: Colors.transparent,
                                              child: Row(
                                                children: [
                                                  Image.asset(
                                                    isDarkMode
                                                        ? AppImages.gallery_dark
                                                        : AppImages.gallery,
                                                    height: 25,
                                                  ),
                                                  SizedBox(width: 15),
                                                  Text(
                                                    "Choose image",
                                                    style: TextStyle(
                                                      color: isDarkMode
                                                          ? AppColors.white
                                                          : AppColors.black,
                                                      fontSize: 14.sp,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          )
                                        : SizedBox(),
                                  ],
                                ),
                              ))),
                      title: Obx(
                        () => Text(
                          cASCtrl.uploadBillText.value
                              .toString()
                              .split("/")
                              .last,
                        ),
                      ),
                      error:
                          cASCtrl.utilityBillUploadError != null ? true : false,
                    ),
                  ]),
                ],
              ),
            ),
          )),
    );
  }
}
