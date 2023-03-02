import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:sprout_mobile/src/public/widgets/custom_text_form_field.dart';
import 'package:sprout_mobile/src/public/widgets/general_widgets.dart';
import 'package:sprout_mobile/src/utils/app_colors.dart';
import 'package:sprout_mobile/src/utils/app_images.dart';
import 'package:sprout_mobile/src/utils/helper_widgets.dart';

class DispenseErrorScreen extends StatefulWidget {
  DispenseErrorScreen({
    super.key,
    required this.title,
    required this.category,
    required this.data,
    required this.onSubmit,
  });
  final String title;
  final String category;
  final void data;
  final Function(void issue) onSubmit;

  @override
  _DispenseErrorScreenState createState() => _DispenseErrorScreenState();
}

class _DispenseErrorScreenState extends State<DispenseErrorScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  String dateToDisplay = "DD-MM-YYYY";
  String? transactionDate;

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return SafeArea(
      child: Scaffold(
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.only(left: 24, right: 24, bottom: 24),
            child: DecisionButton(
              isDarkMode: isDarkMode,
              buttonText: "Submit",
              onTap: () {
                submitDispenseError();
              },
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  getHeader(isDarkMode, hideHelp: true),
                  addVerticalSpace(15.h),
                  Container(
                    width: double.infinity,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                            width: MediaQuery.of(context).size.width * 0.42,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "Transaction date",
                                      style: TextStyle(
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.w700,
                                          color: AppColors.inputLabelColor),
                                    ),
                                    Text(' *',
                                        style: TextStyle(
                                            color: Colors.red,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 10))
                                  ],
                                ),
                                SizedBox(height: 10),
                                Container(
                                  height: 55,
                                  padding: EdgeInsets.symmetric(horizontal: 15),
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: isDarkMode
                                        ? AppColors.inputBackgroundColor
                                        : AppColors.grey,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: GestureDetector(
                                    onTap: () => showDatePicker(
                                            context: context,
                                            builder: (context, child) => Theme(
                                                  data: ThemeData.light()
                                                      .copyWith(
                                                    colorScheme:
                                                        ColorScheme.dark(
                                                      primary: isDarkMode
                                                          ? AppColors.white
                                                          : AppColors.black,
                                                      surface: isDarkMode
                                                          ? AppColors.white
                                                          : AppColors.black,
                                                      onSurface: isDarkMode
                                                          ? AppColors.white
                                                          : AppColors.black,
                                                      onPrimary:
                                                          AppColors.white,
                                                    ),
                                                    dialogBackgroundColor:
                                                        isDarkMode
                                                            ? AppColors.black
                                                            : AppColors.white,
                                                  ),
                                                  child: Container(
                                                    child: child,
                                                  ),
                                                ),
                                            firstDate: DateTime(
                                                DateTime.now().year - 10),
                                            lastDate: DateTime.now(),
                                            initialDate: DateTime.now())
                                        .then((date) {
                                      setState(
                                        () => {
                                          if (date != null)
                                            {
                                              DateFormat('date'),
                                              dateToDisplay =
                                                  DateFormat('dd-MM-yyyy')
                                                      .format(date)
                                                      .toString(),
                                              transactionDate = DateFormat(
                                                      'yyyy-MM-ddTHH:mm:ss')
                                                  .format(date)
                                                  .toString(),
                                            }
                                        },
                                      );
                                    }),
                                    child: Container(
                                      color: Colors.transparent,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(dateToDisplay,
                                              style: TextStyle(
                                                  fontSize: 12.sp,
                                                  fontWeight: FontWeight.w500,
                                                  color: AppColors
                                                      .inputLabelColor)),
                                          Icon(
                                            Icons.keyboard_arrow_down,
                                            size: 18,
                                            color: AppColors.inputLabelColor,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            )),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.42,
                          child: CustomTextFormField(
                            label: "Transaction amount",
                            hintText: "Amount",
                            fillColor: isDarkMode
                                ? AppColors.inputBackgroundColor
                                : AppColors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                  CustomTextFormField(
                    label: "Card PAN",
                    required: true,
                    hintText: "Enter last 4 digits of the Card PAN",
                    fillColor: isDarkMode
                        ? AppColors.inputBackgroundColor
                        : AppColors.grey,
                  ),
                  CustomTextFormField(
                    label: "Name on Card",
                    hintText: "Enter Card Name",
                    required: true,
                    fillColor: isDarkMode
                        ? AppColors.inputBackgroundColor
                        : AppColors.grey,
                  ),
                  CustomTextFormField(
                    label: "Cardholder Phone No.",
                    hintText: "Enter Phone Number",
                    required: true,
                    fillColor: isDarkMode
                        ? AppColors.inputBackgroundColor
                        : AppColors.grey,
                  ),
                  CustomTextFormField(
                    label: "RRN",
                    hintText: "Enter RRN",
                    required: true,
                    fillColor: isDarkMode
                        ? AppColors.inputBackgroundColor
                        : AppColors.grey,
                  ),
                  addVerticalSpace(20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Attach receipt or evidence",
                            style: TextStyle(
                                fontFamily: "DMSans",
                                fontSize: 13.sp,
                                color: isDarkMode
                                    ? AppColors.white
                                    : AppColors.black,
                                fontWeight: FontWeight.w700),
                          ),
                        ],
                      ),
                      Container(
                        height: 24,
                        color: Colors.transparent,
                        child: Image.asset(isDarkMode
                            ? AppImages.upload_dark
                            : AppImages.upload),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          )),
    );
  }

  Future submitDispenseError() async {
    Future.delayed(const Duration(milliseconds: 500),
        () => {widget.onSubmit(null), Navigator.pop(context)});
  }
}
