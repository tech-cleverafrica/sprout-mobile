import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sprout_mobile/components/invoice/controller/create_invoice_controller.dart';
import 'package:sprout_mobile/public/widgets/custom_button.dart';
import 'package:sprout_mobile/public/widgets/general_widgets.dart';
import 'package:sprout_mobile/utils/app_svgs.dart';
import 'package:sprout_mobile/utils/global_function.dart';
import 'package:sprout_mobile/utils/helper_widgets.dart';

import '../../../public/widgets/custom_text_form_field.dart';
import '../../../utils/app_colors.dart';

// ignore: must_be_immutable
class CreateInvoice extends StatelessWidget {
  CreateInvoice({super.key});

  late CreateInvoiceController createInvoiceController;

  @override
  Widget build(BuildContext context) {
    createInvoiceController = Get.put(CreateInvoiceController());
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final theme = Theme.of(context);
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                getHeader(isDarkMode),
                addVerticalSpace(15.h),
                Text(
                  "Business Information:",
                  style: theme.textTheme.headline6,
                ),
                addVerticalSpace(15.h),
                Obx(
                  (() => createInvoiceController.info.value != null
                      ? Container(
                          width: double.infinity,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                  alignment: Alignment.topLeft,
                                  child: createInvoiceController
                                          .uploadingLogo.value
                                      ? Container(
                                          height: 28,
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Theme.of(context)
                                                .scaffoldBackgroundColor,
                                          ),
                                          child: SpinKitFadingCircle(
                                            color: isDarkMode
                                                ? AppColors.white
                                                : AppColors.primaryColor,
                                            size: 30,
                                          ),
                                        )
                                      : Container(
                                          height: createInvoiceController.info
                                                      .value!.businessLogo !=
                                                  null
                                              ? 40
                                              : 28,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: AppColors.transparent,
                                          ),
                                          child: createInvoiceController.info
                                                      .value!.businessLogo !=
                                                  null
                                              ? Row(
                                                  children: [
                                                    Container(
                                                      height: 40,
                                                      child: Image.network(
                                                        createInvoiceController
                                                                .info
                                                                .value
                                                                ?.businessLogo ??
                                                            "",
                                                        loadingBuilder: (context,
                                                                child,
                                                                loadingProgress) =>
                                                            loadingProgress ==
                                                                    null
                                                                ? child
                                                                : Container(
                                                                    height: 40,
                                                                    width: 40,
                                                                    alignment:
                                                                        Alignment
                                                                            .center,
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      shape: BoxShape
                                                                          .circle,
                                                                      color: Theme.of(
                                                                              context)
                                                                          .scaffoldBackgroundColor,
                                                                    ),
                                                                    child:
                                                                        SpinKitThreeBounce(
                                                                      color: isDarkMode
                                                                          ? AppColors
                                                                              .white
                                                                          : AppColors
                                                                              .primaryColor,
                                                                      size: 15,
                                                                    ),
                                                                  ),
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                                    addHorizontalSpace(10.w),
                                                    InkWell(
                                                      onTap: () {
                                                        createInvoiceController
                                                            .logoAction(
                                                                context,
                                                                isDarkMode,
                                                                theme);
                                                      },
                                                      child: Row(
                                                        children: [
                                                          SvgPicture.asset(
                                                            AppSvg.pendown,
                                                            color: isDarkMode
                                                                ? AppColors
                                                                    .mainGreen
                                                                : AppColors
                                                                    .primaryColor,
                                                            height: 10.h,
                                                          ),
                                                          addHorizontalSpace(
                                                              5.w),
                                                          Text(
                                                            "Edit",
                                                            style: TextStyle(
                                                                fontFamily:
                                                                    "Mont",
                                                                fontSize: 12.sp,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                                color: isDarkMode
                                                                    ? AppColors
                                                                        .mainGreen
                                                                    : AppColors
                                                                        .primaryColor),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                )
                                              : InkWell(
                                                  onTap: () async {
                                                    await createInvoiceController
                                                        .picker
                                                        .pickImage(
                                                            source: ImageSource
                                                                .gallery,
                                                            imageQuality: 25)
                                                        .then(
                                                      (value) {
                                                        if (value != null) {
                                                          createInvoiceController
                                                                  .logo =
                                                              File(value.path);
                                                          createInvoiceController
                                                              .uploadInvoiceBusinessLogo();
                                                        }
                                                      },
                                                    );
                                                  },
                                                  child: Container(
                                                    height: 32.h,
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 8),
                                                    decoration: BoxDecoration(
                                                        color: isDarkMode
                                                            ? AppColors
                                                                .mainGreen
                                                            : AppColors
                                                                .primaryColor,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10)),
                                                    child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          Icon(
                                                            Icons.add,
                                                            color:
                                                                AppColors.white,
                                                            size: 14,
                                                          ),
                                                          addHorizontalSpace(
                                                              5.w),
                                                          Text(
                                                            "Upload Logo",
                                                            style: TextStyle(
                                                                fontFamily:
                                                                    "Mont",
                                                                color: AppColors
                                                                    .white,
                                                                fontSize: 10.sp,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700),
                                                          )
                                                        ]),
                                                  ),
                                                ))),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    createInvoiceController
                                            .info.value?.businessName ??
                                        "",
                                    style: theme.textTheme.headline6,
                                  ),
                                  addVerticalSpace(5.h),
                                  Text(
                                    createInvoiceController
                                            .info.value?.businessAddress ??
                                        "",
                                    style: TextStyle(
                                        fontFamily: "Mont",
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w400,
                                        color: isDarkMode
                                            ? AppColors.white
                                            : AppColors.black),
                                  ),
                                  addVerticalSpace(5.h),
                                  Text(
                                    createInvoiceController.info.value?.email ??
                                        "",
                                    style: TextStyle(
                                        fontFamily: "Mont",
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w400,
                                        color: isDarkMode
                                            ? AppColors.white
                                            : AppColors.black),
                                  ),
                                  addVerticalSpace(5.h),
                                  Text(
                                    createInvoiceController.info.value?.phone ??
                                        "",
                                    style: TextStyle(
                                        fontFamily: "Mont",
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w400,
                                        color: isDarkMode
                                            ? AppColors.white
                                            : AppColors.black),
                                  ),
                                  addVerticalSpace(15.h),
                                  InkWell(
                                    onTap: () {
                                      createInvoiceController.editBusinessInfo(
                                          context, isDarkMode, theme);
                                    },
                                    child: Row(
                                      children: [
                                        SvgPicture.asset(
                                          AppSvg.pendown,
                                          color: isDarkMode
                                              ? AppColors.mainGreen
                                              : AppColors.primaryColor,
                                          height: 12.h,
                                        ),
                                        addHorizontalSpace(5.w),
                                        Text(
                                          "Edit Business Information",
                                          style: TextStyle(
                                              fontFamily: "Mont",
                                              fontSize: 12.sp,
                                              fontWeight: FontWeight.w400,
                                              color: isDarkMode
                                                  ? AppColors.mainGreen
                                                  : AppColors.primaryColor),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ))
                      : SizedBox()),
                ),
                Divider(
                  color: isDarkMode ? AppColors.white : AppColors.black,
                ),
                addVerticalSpace(15.h),
                Text(
                  "Bill To:",
                  style: theme.textTheme.headline6,
                ),
                addVerticalSpace(15.h),
                Obx((() => Column(
                      children: [
                        createInvoiceController.savedCustomer.value == null
                            ? InkWell(
                                onTap: () {
                                  createInvoiceController.showAddCustomer(
                                      context, isDarkMode, theme);
                                },
                                child: Row(
                                  children: [
                                    SvgPicture.asset(
                                      AppSvg.add,
                                      color: isDarkMode
                                          ? AppColors.white
                                          : AppColors.black,
                                    ),
                                    addHorizontalSpace(5.w),
                                    Text(
                                      "Add Customer",
                                      style: TextStyle(
                                          fontFamily: "Mont",
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.w400,
                                          color: isDarkMode
                                              ? AppColors.white
                                              : AppColors.black),
                                    )
                                  ],
                                ),
                              )
                            : SizedBox(),
                        createInvoiceController.savedCustomer.value != null
                            ? Container(
                                width: double.infinity,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Text(
                                          createInvoiceController
                                                  .savedCustomer.value?.name ??
                                              "",
                                          style: theme.textTheme.headline6,
                                        ),
                                        addVerticalSpace(5.h),
                                        Text(
                                          createInvoiceController.savedCustomer
                                                  .value?.address ??
                                              "",
                                          style: TextStyle(
                                              fontFamily: "Mont",
                                              fontSize: 12.sp,
                                              fontWeight: FontWeight.w400,
                                              color: isDarkMode
                                                  ? AppColors.white
                                                  : AppColors.black),
                                        ),
                                        addVerticalSpace(5.h),
                                        Text(
                                          createInvoiceController
                                                  .savedCustomer.value?.email ??
                                              "",
                                          style: TextStyle(
                                              fontFamily: "Mont",
                                              fontSize: 12.sp,
                                              fontWeight: FontWeight.w400,
                                              color: isDarkMode
                                                  ? AppColors.white
                                                  : AppColors.black),
                                        ),
                                        addVerticalSpace(5.h),
                                        Text(
                                          createInvoiceController
                                                  .savedCustomer.value?.phone ??
                                              "",
                                          style: TextStyle(
                                              fontFamily: "Mont",
                                              fontSize: 12.sp,
                                              fontWeight: FontWeight.w400,
                                              color: isDarkMode
                                                  ? AppColors.white
                                                  : AppColors.black),
                                        ),
                                        addVerticalSpace(15.h),
                                        InkWell(
                                          onTap: () {
                                            createInvoiceController
                                                .showAddCustomer(
                                                    context, isDarkMode, theme);
                                          },
                                          child: Row(
                                            children: [
                                              SvgPicture.asset(
                                                AppSvg.pendown,
                                                color: isDarkMode
                                                    ? AppColors.mainGreen
                                                    : AppColors.primaryColor,
                                                height: 12.h,
                                              ),
                                              addHorizontalSpace(5.w),
                                              Text(
                                                "Update Customer Information",
                                                style: TextStyle(
                                                    fontFamily: "Mont",
                                                    fontSize: 12.sp,
                                                    fontWeight: FontWeight.w400,
                                                    color: isDarkMode
                                                        ? AppColors.mainGreen
                                                        : AppColors
                                                            .primaryColor),
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ))
                            : SizedBox(),
                      ],
                    ))),
                Divider(
                  color: isDarkMode ? AppColors.white : AppColors.black,
                ),
                addVerticalSpace(15.h),
                Text(
                  "Items:",
                  style: theme.textTheme.headline6,
                ),
                addVerticalSpace(15.h),
                Obx((() => Column(
                      children: [
                        createInvoiceController.invoiceItems.length > 0
                            ? Container(
                                width: double.infinity,
                                child: ListView.builder(
                                    itemCount: createInvoiceController
                                        .invoiceItems.length,
                                    shrinkWrap: true,
                                    physics: BouncingScrollPhysics(),
                                    itemBuilder: ((context, index) {
                                      return Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "Name:",
                                                style: TextStyle(
                                                    fontFamily: "Mont",
                                                    fontSize: 12.sp,
                                                    fontWeight: FontWeight.w400,
                                                    color: isDarkMode
                                                        ? AppColors.white
                                                        : AppColors.black),
                                              ),
                                              Text(
                                                createInvoiceController
                                                        .invoiceItems[index]
                                                        .name ??
                                                    "",
                                                style:
                                                    theme.textTheme.headline6,
                                              ),
                                            ],
                                          ),
                                          addVerticalSpace(5.h),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "Quantity:",
                                                style: TextStyle(
                                                    fontFamily: "Mont",
                                                    fontSize: 12.sp,
                                                    fontWeight: FontWeight.w400,
                                                    color: isDarkMode
                                                        ? AppColors.white
                                                        : AppColors.black),
                                              ),
                                              Text(
                                                createInvoiceController
                                                    .invoiceItems[index]
                                                    .quantity
                                                    .toString(),
                                                style:
                                                    theme.textTheme.headline6,
                                              ),
                                            ],
                                          ),
                                          addVerticalSpace(5.h),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "Price/Rate:",
                                                style: TextStyle(
                                                    fontFamily: "Mont",
                                                    fontSize: 12.sp,
                                                    fontWeight: FontWeight.w400,
                                                    color: isDarkMode
                                                        ? AppColors.white
                                                        : AppColors.black),
                                              ),
                                              Text(
                                                "$currencySymbol${createInvoiceController.formatter.formatAsMoney(createInvoiceController.invoiceItems[index].price ?? 0)}",
                                                style: TextStyle(
                                                    color: isDarkMode
                                                        ? AppColors.white
                                                        : AppColors.black,
                                                    fontSize: 12.sp,
                                                    fontFamily: "Mont",
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                            ],
                                          ),
                                          addVerticalSpace(5.h),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "Amount:",
                                                style: TextStyle(
                                                    fontFamily: "Mont",
                                                    fontSize: 12.sp,
                                                    fontWeight: FontWeight.w400,
                                                    color: isDarkMode
                                                        ? AppColors.white
                                                        : AppColors.black),
                                              ),
                                              Text(
                                                "$currencySymbol${createInvoiceController.formatter.formatAsMoney(createInvoiceController.invoiceItems[index].amount ?? 0)}",
                                                style: TextStyle(
                                                    color: isDarkMode
                                                        ? AppColors.white
                                                        : AppColors.black,
                                                    fontSize: 12.sp,
                                                    fontFamily: "Mont",
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                            ],
                                          ),
                                          addVerticalSpace(10.h),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              InkWell(
                                                onTap: () {
                                                  createInvoiceController
                                                      .editItem(
                                                          context,
                                                          isDarkMode,
                                                          theme,
                                                          index);
                                                },
                                                child: Row(
                                                  children: [
                                                    SvgPicture.asset(
                                                      AppSvg.pendown,
                                                      color: isDarkMode
                                                          ? AppColors.mainGreen
                                                          : AppColors
                                                              .primaryColor,
                                                      height: 12.h,
                                                    ),
                                                    addHorizontalSpace(5.w),
                                                    Text(
                                                      "Edit Item",
                                                      style: TextStyle(
                                                          fontFamily: "Mont",
                                                          fontSize: 12.sp,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          color: isDarkMode
                                                              ? AppColors
                                                                  .mainGreen
                                                              : AppColors
                                                                  .primaryColor),
                                                    )
                                                  ],
                                                ),
                                              ),
                                              addHorizontalSpace(15.w),
                                              InkWell(
                                                onTap: () {
                                                  createInvoiceController
                                                      .deleteItem(index);
                                                },
                                                child: Row(
                                                  children: [
                                                    Icon(
                                                      Icons.delete_rounded,
                                                      size: 16,
                                                      color: AppColors.red,
                                                    ),
                                                    addHorizontalSpace(5.w),
                                                    Text(
                                                      "Delete Item",
                                                      style: TextStyle(
                                                          fontFamily: "Mont",
                                                          fontSize: 12.sp,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          color: AppColors.red),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                          addVerticalSpace(15.h)
                                        ],
                                      );
                                    })),
                              )
                            : SizedBox(),
                        InkWell(
                          onTap: () {
                            createInvoiceController.showAddItem(
                                context, isDarkMode, theme, null);
                          },
                          child: Row(
                            children: [
                              SvgPicture.asset(AppSvg.add,
                                  color: isDarkMode
                                      ? AppColors.white
                                      : AppColors.black),
                              addHorizontalSpace(5.w),
                              Text(
                                "Add Item",
                                style: TextStyle(
                                    fontFamily: "Mont",
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w400,
                                    color: isDarkMode
                                        ? AppColors.white
                                        : AppColors.black),
                              )
                            ],
                          ),
                        ),
                      ],
                    ))),
                Divider(
                  color: isDarkMode ? AppColors.white : AppColors.black,
                ),
                addVerticalSpace(30.h),
                Text(
                  "Summary",
                  style: theme.textTheme.headline6,
                ),
                addVerticalSpace(10.h),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Discount (%)",
                            style: TextStyle(
                                fontFamily: "Mont",
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w400,
                                color: isDarkMode
                                    ? AppColors.white
                                    : AppColors.black),
                          ),
                          Flexible(
                              child: Container(
                            width: MediaQuery.of(context).size.width * 0.13,
                            child: CustomTextFormField(
                              controller: createInvoiceController
                                  .itemDiscountController,
                              fillColor: isDarkMode
                                  ? AppColors.inputBackgroundColor
                                  : AppColors.grey,
                              textInputAction: TextInputAction.go,
                              textInputType: TextInputType.phone,
                              borderRadius: 2,
                              contentPaddingHorizontal: 6,
                              contentPaddingVertical: 6,
                              textFormFieldStyle: TextStyle(
                                fontSize: 10.0,
                              ),
                              margin: EdgeInsets.symmetric(vertical: 0),
                              isDense: true,
                              onChanged: (value) {
                                createInvoiceController.computeSummary();
                              },
                            ),
                          )),
                        ],
                      ),
                      Divider(
                        color: isDarkMode ? AppColors.white : AppColors.black,
                      ),
                      addVerticalSpace(10.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Tax (%)",
                            style: TextStyle(
                                fontFamily: "Mont",
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w400,
                                color: isDarkMode
                                    ? AppColors.white
                                    : AppColors.black),
                          ),
                          Flexible(
                              child: Container(
                            width: MediaQuery.of(context).size.width * 0.13,
                            child: CustomTextFormField(
                              controller:
                                  createInvoiceController.itemTaxController,
                              fillColor: isDarkMode
                                  ? AppColors.inputBackgroundColor
                                  : AppColors.grey,
                              textInputAction: TextInputAction.go,
                              textInputType: TextInputType.phone,
                              borderRadius: 2,
                              contentPaddingHorizontal: 6,
                              contentPaddingVertical: 6,
                              textFormFieldStyle: TextStyle(
                                fontSize: 10.0,
                              ),
                              margin: EdgeInsets.symmetric(vertical: 0),
                              isDense: true,
                              onChanged: (value) {
                                createInvoiceController.computeSummary();
                              },
                            ),
                          )),
                        ],
                      ),
                      Divider(
                        color: isDarkMode ? AppColors.white : AppColors.black,
                      ),
                      addVerticalSpace(15.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Total",
                            style: TextStyle(
                                fontFamily: "Mont",
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w700,
                                color: isDarkMode
                                    ? AppColors.white
                                    : AppColors.black),
                          ),
                          Obx((() => Text(
                                "$currencySymbol${createInvoiceController.formatter.formatAsMoney(createInvoiceController.total.value)}",
                                style: TextStyle(
                                    fontFamily: "Mont",
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w700,
                                    color: isDarkMode
                                        ? AppColors.white
                                        : AppColors.black),
                              ))),
                        ],
                      ),
                      Divider(
                        color: isDarkMode ? AppColors.white : AppColors.black,
                      ),
                    ],
                  ),
                ),
                addVerticalSpace(20.h),
                Row(
                  children: [
                    Expanded(
                        child: InkWell(
                      onTap: () => createInvoiceController.selectInvoiceDate(),
                      child: Obx((() => CustomTextFormField(
                          controller:
                              createInvoiceController.invoiceDateController,
                          label: "Invoice Date",
                          enabled: false,
                          hintText: createInvoiceController.invoiceDate.value,
                          fillColor: isDarkMode
                              ? AppColors.inputBackgroundColor
                              : AppColors.grey,
                          textInputAction: TextInputAction.next,
                          hintTextStyle:
                              createInvoiceController.invoiceDate.value ==
                                      "YYYY / MM / DAY"
                                  ? null
                                  : TextStyle(
                                      color: isDarkMode
                                          ? AppColors.white
                                          : AppColors.black,
                                      fontWeight: FontWeight.w600)))),
                    )),
                    addHorizontalSpace(10.w),
                    Expanded(
                        child: InkWell(
                            onTap: () =>
                                createInvoiceController.selectDueDate(),
                            child: Obx((() => CustomTextFormField(
                                controller:
                                    createInvoiceController.dueDateController,
                                label: "Due Date",
                                enabled: false,
                                hintText: createInvoiceController.dueDate.value,
                                fillColor: isDarkMode
                                    ? AppColors.inputBackgroundColor
                                    : AppColors.grey,
                                textInputAction: TextInputAction.next,
                                hintTextStyle:
                                    createInvoiceController.dueDate.value ==
                                            "YYYY / MM / DAY"
                                        ? null
                                        : TextStyle(
                                            color: isDarkMode
                                                ? AppColors.white
                                                : AppColors.black,
                                            fontWeight: FontWeight.w600)))))),
                  ],
                ),
                addVerticalSpace(10.h),
                CustomTextFormField(
                  controller: createInvoiceController.notesController,
                  label: "Email Subject",
                  maxLines: 3,
                  maxLength: 250,
                  hintText: "Enter Email Subject",
                  maxLengthEnforced: true,
                  validator: (value) {
                    if (value!.length == 0)
                      return "Notes is required";
                    else if (value.length < 6) return "Notes is too short";
                    return null;
                  },
                  fillColor: isDarkMode
                      ? AppColors.inputBackgroundColor
                      : AppColors.grey,
                ),
                addVerticalSpace(20.h),
                CustomButton(
                  title: "Continue",
                  onTap: () {
                    createInvoiceController.validateInvoice();
                  },
                ),
                addVerticalSpace(20.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
