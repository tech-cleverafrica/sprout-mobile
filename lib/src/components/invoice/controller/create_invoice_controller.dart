import 'dart:io';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:sprout_mobile/src/components/invoice/controller/invoice_controller.dart';
import 'package:sprout_mobile/src/components/invoice/model/invoice_business_info_model.dart';
import 'package:sprout_mobile/src/components/invoice/model/invoice_customer_model.dart';
import 'package:sprout_mobile/src/components/invoice/model/invoice_item_model.dart';
import 'package:sprout_mobile/src/components/invoice/model/saved_invoice_customer_model.dart';
import 'package:sprout_mobile/src/components/invoice/service/invoice_service.dart';
import 'package:sprout_mobile/src/components/authentication/service/auth_service.dart';
import 'package:sprout_mobile/src/components/invoice/view/invoice_preview.dart';
import 'package:sprout_mobile/src/utils/app_formatter.dart';
import 'package:sprout_mobile/src/utils/global_function.dart';
import 'package:sprout_mobile/src/utils/helper_widgets.dart';
import 'package:sprout_mobile/src/public/widgets/custom_button.dart';
import 'package:sprout_mobile/src/public/widgets/custom_text_form_field.dart';
import 'package:sprout_mobile/src/utils/app_svgs.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sprout_mobile/src/utils/nav_function.dart';

import '../../../api-setup/api_setup.dart';
import '../../../api/api_response.dart';
import '../../../public/widgets/custom_toast_notification.dart';
import '../../../utils/app_colors.dart';

class CreateInvoiceController extends GetxController {
  final AppFormatter formatter = Get.put(AppFormatter());
  TextEditingController customerNameController = new TextEditingController();
  TextEditingController customerPhoneController = new TextEditingController();
  TextEditingController customerEmailController = new TextEditingController();
  TextEditingController customerAddressController = new TextEditingController();

  TextEditingController itemNameController = new TextEditingController();
  TextEditingController itemQuantityController = new TextEditingController();
  late MoneyMaskedTextController itemPriceController =
      new MoneyMaskedTextController(
          initialValue: 0, decimalSeparator: ".", thousandSeparator: ",");
  var itemAmountController = Rxn<MoneyMaskedTextController>();

  late MoneyMaskedTextController itemDiscountController =
      new MoneyMaskedTextController(
          initialValue: 0, decimalSeparator: ".", thousandSeparator: ",");
  late MoneyMaskedTextController itemTaxController =
      new MoneyMaskedTextController(
          initialValue: 0, decimalSeparator: ".", thousandSeparator: ",");

  TextEditingController invoiceDateController = new TextEditingController();
  TextEditingController dueDateController = new TextEditingController();
  TextEditingController notesController = new TextEditingController();

  RxList<InvoiceCustomer> customers = <InvoiceCustomer>[].obs;

  late InvoiceController invoiceController;
  final picker = ImagePicker();
  late File logo;
  RxBool uploadingLogo = false.obs;
  var info = Rxn<InvoiceBusinessInfo>();
  var customer = Rxn<InvoiceCustomer>();
  var savedCustomer = Rxn<SavedInvoiceCustomer>();
  RxList<InvoiceItem> invoiceItems = <InvoiceItem>[].obs;
  RxBool save = false.obs;
  RxDouble total = 0.0.obs;
  RxString invoiceDate = "YYYY / MM / DAY".obs;
  RxString dueDate = "YYYY / MM / DAY".obs;
  DateTime? pickedStartDate;

  @override
  void onInit() {
    itemAmountController.value = new MoneyMaskedTextController(
        initialValue: 0, decimalSeparator: ".", thousandSeparator: ",");
    invoiceController = Get.put(InvoiceController());
    fetchInvoiceBusinessInfo();
    loadCustomers(false);
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

  toggleSaver() {
    save.value = !save.value;
  }

  loadCustomers(bool isUpdate) async {
    customers.clear();
    InvoiceCustomer none = InvoiceCustomer(
      id: "00",
      fullName: "New Customer",
      email: "N/A",
      phone: "N/A",
      address: "",
      registrarID: "",
      createdAt: "",
      updatedAt: "",
    );
    customers.assignAll(invoiceController.baseInvoiceCustomer);
    customers.insert(0, none);
    if (!isUpdate) {
      customer.value = customers[0];
    }
  }

  fetchInvoiceBusinessInfo() async {
    AppResponse<InvoiceBusinessInfo> response =
        await locator.get<InvoiceService>().getInvoiceBusinessInfo();
    if (response.status) {
      info.value = InvoiceBusinessInfo.fromJson(response.data);
    } else if (response.statusCode == 999) {
      AppResponse res = await locator<AuthService>().refreshUserToken();
      if (res.status) {
        fetchInvoiceBusinessInfo();
      }
    }
  }

  uploadInvoiceBusinessLogo() async {
    uploadingLogo.value = true;
    AppResponse<InvoiceBusinessInfo> response =
        await locator.get<InvoiceService>().uploadInvoiceBusinessLogo(logo);
    uploadingLogo.value = false;
    if (response.status) {
      info.value = InvoiceBusinessInfo.fromJson(response.data);
    } else {
      CustomToastNotification.show(response.message, type: ToastType.error);
    }
  }

  removeInvoiceBusinessLogo() async {
    uploadingLogo.value = true;
    AppResponse<InvoiceBusinessInfo> response =
        await locator.get<InvoiceService>().removeInvoiceBusinessLogo();
    uploadingLogo.value = false;
    if (response.status) {
      info.value = InvoiceBusinessInfo.fromJson(response.data);
    } else {
      CustomToastNotification.show(response.message, type: ToastType.error);
    }
  }

  buildCustomerRequest() {
    return {
      "fullName": customerNameController.text,
      "email": customerEmailController.text,
      "address": customerAddressController.text,
      "phone": customerPhoneController.text
    };
  }

  addCustomer() async {
    AppResponse appResponse =
        await locator.get<InvoiceService>().addCustomer(buildCustomerRequest());
    if (appResponse.status) {
      customer.value = InvoiceCustomer.fromJson(appResponse.data["data"]);
      save.value = false;
      invoiceController.fetchInvoiceCustomers().then((value) => {
            if (value != null)
              {
                savedCustomer.value = SavedInvoiceCustomer(
                    name: customer.value?.fullName ?? "",
                    phone: customer.value?.phone ?? "",
                    email: customer.value?.email ?? "",
                    address: customer.value?.address ?? ""),
                customerNameController.text = customer.value?.fullName ?? "",
                customerPhoneController.text = customer.value?.phone ?? "",
                customerEmailController.text = customer.value?.email ?? "",
                customerAddressController.text = customer.value?.address ?? "",
                loadCustomers(true),
              }
          });
    } else {
      CustomToastNotification.show(appResponse.message, type: ToastType.error);
    }
  }

  validateCustomer() {
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (customerNameController.text.length > 1 &&
        customerPhoneController.text.length == 11 &&
        customerEmailController.text.isNotEmpty &&
        customerAddressController.text.length > 5 &&
        (regex.hasMatch(customerEmailController.text))) {
      if (save.value) {
        addCustomer();
      } else {
        savedCustomer.value = SavedInvoiceCustomer(
            name: customerNameController.text,
            phone: customerPhoneController.text,
            email: customerEmailController.text,
            address: customerAddressController.text);
      }
      pop();
    } else if (customerNameController.text.isEmpty) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
          content: Text("Customer Name is required"),
          backgroundColor: AppColors.errorRed));
    } else if (customerNameController.text.length < 2) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
          content: Text("Customer Name is too short"),
          backgroundColor: AppColors.errorRed));
    } else if (customerPhoneController.text.isEmpty) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
          content: Text("Phone number is required"),
          backgroundColor: AppColors.errorRed));
    } else if (customerPhoneController.text.length < 11) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
          content: Text("Phone number should ber 11 digits"),
          backgroundColor: AppColors.errorRed));
    } else if (customerEmailController.text.isEmpty) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
          content: Text("Email is required"),
          backgroundColor: AppColors.errorRed));
    } else if (!(regex.hasMatch(customerEmailController.text))) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
          content: Text("Please enter a valid email"),
          backgroundColor: AppColors.errorRed));
    } else if (customerAddressController.text.isEmpty) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
          content: Text("Address is required"),
          backgroundColor: AppColors.errorRed));
    } else if (customerAddressController.text.length < 6) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
          content: Text("Address is too short"),
          backgroundColor: AppColors.errorRed));
    } else {
      ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
          content: Text("Please supply all required fields"),
          backgroundColor: AppColors.errorRed));
    }
  }

  validateItem(int? index) {
    if (itemNameController.text.length > 1 &&
        (itemQuantityController.text.length > 0 &&
            int.parse(itemQuantityController.text) > 0) &&
        double.parse(itemPriceController.text.split(",").join()) > 0) {
      InvoiceItem x = InvoiceItem(
          name: itemNameController.text,
          quantity: int.parse(itemQuantityController.text),
          price: double.parse(itemPriceController.text.split(",").join("")),
          amount: double.parse(
              itemAmountController.value!.text.split(",").join("")));
      if (index == null) {
        invoiceItems.add(x);
      } else {
        invoiceItems[index] = x;
      }
      resetItemFields();
      computeSummary();
      pop();
    } else if (itemNameController.text.isEmpty) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
          content: Text("Item name is required"),
          backgroundColor: AppColors.errorRed));
    } else if (itemNameController.text.length < 2) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
          content: Text("Item name is too short"),
          backgroundColor: AppColors.errorRed));
    } else if (itemQuantityController.text.isEmpty) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
          content: Text("Quantity is required"),
          backgroundColor: AppColors.errorRed));
    } else if (int.parse(itemQuantityController.text) == 0) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
          content: Text("Quantity cannot be 0"),
          backgroundColor: AppColors.errorRed));
    } else if (itemPriceController.text.isEmpty) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
          content: Text("Price/Rate is required"),
          backgroundColor: AppColors.errorRed));
    } else if (double.parse(itemPriceController.text.split(",").join("")) ==
        0) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
          content: Text("Price/Rate cannot be 0"),
          backgroundColor: AppColors.errorRed));
    } else {
      ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
          content: Text("Please supply all required fields"),
          backgroundColor: AppColors.errorRed));
    }
  }

  validateInvoice() {
    if (savedCustomer.value != null &&
        invoiceItems.length > 0 &&
        invoiceDate.value != "YYYY / MM / DAY" &&
        dueDate.value != "YYYY / MM / DAY" &&
        notesController.text.length > 6) {
      push(page: InvoicePreviewScreen());
    } else if (savedCustomer.value == null) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
          content: Text("Please select or create new customer"),
          backgroundColor: AppColors.errorRed));
    } else if (invoiceItems.length == 0) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
          content: Text("Please add invoice item"),
          backgroundColor: AppColors.errorRed));
    } else if (invoiceDate.value == "YYYY / MM / DAY") {
      ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
          content: Text("Invoice Date is required"),
          backgroundColor: AppColors.errorRed));
    } else if (dueDate.value == "YYYY / MM / DAY") {
      ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
          content: Text("Due Date is required"),
          backgroundColor: AppColors.errorRed));
    } else if (notesController.text.isEmpty) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
          content: Text("Invoice notes is required"),
          backgroundColor: AppColors.errorRed));
    } else if (notesController.text.length < 6) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
          content: Text("Invoice notes too short"),
          backgroundColor: AppColors.errorRed));
    } else {
      ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
          content: Text("Please supply all required fields"),
          backgroundColor: AppColors.errorRed));
    }
  }

  resetCustomerFields() {
    customerNameController = new TextEditingController(text: "");
    customerPhoneController = new TextEditingController(text: "");
    customerEmailController = new TextEditingController(text: "");
    customerAddressController = new TextEditingController(text: "");
  }

  resetItemFields() {
    itemNameController = new TextEditingController(text: "");
    itemQuantityController = new TextEditingController(text: "");
    itemPriceController = new MoneyMaskedTextController(
        initialValue: 0, decimalSeparator: ".", thousandSeparator: ",");
    itemAmountController.value = new MoneyMaskedTextController(
        initialValue: 0, decimalSeparator: ".", thousandSeparator: ",");
  }

  editItem(context, isDarkMode, theme, int index) {
    itemNameController =
        new TextEditingController(text: invoiceItems[index].name);
    itemQuantityController = new TextEditingController(
        text: invoiceItems[index].quantity.toString());
    itemPriceController = new MoneyMaskedTextController(
        initialValue: invoiceItems[index].price ?? 0,
        decimalSeparator: ".",
        thousandSeparator: ",");
    itemAmountController.value = new MoneyMaskedTextController(
        initialValue: invoiceItems[index].amount ?? 0,
        decimalSeparator: ".",
        thousandSeparator: ",");
    showAddItem(context, isDarkMode, theme, index);
  }

  deleteItem(int index) {
    invoiceItems.removeAt(index);
    computeSummary();
  }

  computeSummary() {
    double all = 0;
    for (int i = 0; i < invoiceItems.length; i++) {
      all = all + invoiceItems[i].amount!;
    }
    if (itemDiscountController.text.isNotEmpty) {
      all = all -
          ((double.parse(itemDiscountController.text.split(",").join("")) /
                  100) *
              all);
    }

    if (itemTaxController.text.isNotEmpty) {
      all = all +
          ((double.parse(itemTaxController.text.split(",").join("")) / 100) *
              all);
    }
    total.value = all;
  }

  selectInvoiceDate() async {
    pickedStartDate = await showRangeDatePicker();
    if (pickedStartDate != null) {
      invoiceDate.value = DateFormat('yyyy-MM-dd').format(pickedStartDate!);
    }
  }

  selectDueDate() async {
    pickedStartDate = await showRangeDatePicker();
    if (pickedStartDate != null) {
      dueDate.value = DateFormat('yyyy-MM-dd').format(pickedStartDate!);
    }
  }

  showAddItem(context, isDarkMode, theme, int? index) {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: ((context) {
          return Dialog(
            backgroundColor: isDarkMode ? AppColors.blackBg : AppColors.white,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.65,
              child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Item",
                              style: theme.textTheme.headline6,
                            ),
                            InkWell(
                                onTap: () => Get.back(),
                                child: SvgPicture.asset(
                                  AppSvg.cancel,
                                  height: 18.h,
                                ))
                          ],
                        ),
                        addVerticalSpace(10.h),
                        CustomTextFormField(
                          controller: itemNameController,
                          label: "Name",
                          hintText: "Enter Item Name",
                          textInputAction: TextInputAction.next,
                          fillColor: isDarkMode
                              ? AppColors.inputBackgroundColor
                              : AppColors.grey,
                          validator: (value) {
                            if (value!.length == 0)
                              return "Item name is required";
                            else if (value.length < 2)
                              return "Item name is too short";
                            return null;
                          },
                        ),
                        CustomTextFormField(
                          controller: itemQuantityController,
                          hintText: "0",
                          label: "Quantity",
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(
                                RegExp(r'^[0-9]*$'))
                          ],
                          textInputType: TextInputType.phone,
                          fillColor: isDarkMode
                              ? AppColors.inputBackgroundColor
                              : AppColors.grey,
                          textInputAction: TextInputAction.next,
                          onChanged: (value) {
                            if (itemPriceController.text.isNotEmpty &&
                                value.isNotEmpty) {
                              itemAmountController.value =
                                  new MoneyMaskedTextController(
                                      initialValue: double.parse(value) *
                                          double.parse(
                                              itemPriceController.text),
                                      decimalSeparator: ".",
                                      thousandSeparator: ",");
                            }
                          },
                          validator: (value) {
                            if (value!.length == 0)
                              return "Quantity is required";
                            else if (int.parse(value) == 0) {
                              return "Quantity cannot be 0";
                            }
                            return null;
                          },
                        ),
                        CustomTextFormField(
                          controller: itemPriceController,
                          label: "Price/Rate",
                          textInputType: TextInputType.phone,
                          textInputAction: TextInputAction.next,
                          fillColor: isDarkMode
                              ? AppColors.inputBackgroundColor
                              : AppColors.grey,
                          onChanged: (value) {
                            if (itemQuantityController.text.isNotEmpty &&
                                value.isNotEmpty) {
                              itemAmountController.value =
                                  new MoneyMaskedTextController(
                                      initialValue: double.parse(value) *
                                          double.parse(
                                              itemQuantityController.text),
                                      decimalSeparator: ".",
                                      thousandSeparator: ",");
                            }
                          },
                          validator: (value) {
                            if (value!.length == 0)
                              return "Price/Rate is required";
                            else if (double.parse(value.split(",").join("")) ==
                                0) {
                              return "Price/Rate cannot be 0";
                            }
                            return null;
                          },
                        ),
                        Obx((() => CustomTextFormField(
                              controller: itemAmountController.value,
                              enabled: false,
                              label: "Amount",
                              fillColor: isDarkMode
                                  ? AppColors.inputBackgroundColor
                                  : AppColors.grey,
                            ))),
                        addVerticalSpace(15.h),
                        CustomButton(
                          title: index != null ? "Update" : "Done",
                          onTap: () => {
                            validateItem(index),
                          },
                        ),
                      ],
                    ),
                  )),
            ),
          );
        }));
  }

  showAddCustomer(context, isDarkMode, theme) {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: ((context) {
          return Dialog(
            backgroundColor: isDarkMode ? AppColors.blackBg : AppColors.white,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.8,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                child: SingleChildScrollView(
                    child: Obx((() => Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Input Business Information",
                                  style: theme.textTheme.headline6,
                                ),
                                InkWell(
                                    onTap: () => Get.back(),
                                    child: SvgPicture.asset(
                                      AppSvg.cancel,
                                      height: 18.h,
                                    ))
                              ],
                            ),
                            addVerticalSpace(10.h),
                            GestureDetector(
                                onTap: () =>
                                    {showCustomerList(context, isDarkMode)},
                                child: CustomTextFormField(
                                    label: "Select Customer",
                                    hintText: customer.value == null
                                        ? "Select Customer"
                                        : customer.value?.fullName ?? "",
                                    enabled: false,
                                    fillColor: isDarkMode
                                        ? AppColors.inputBackgroundColor
                                        : AppColors.grey,
                                    hintTextStyle: customer.value == null
                                        ? null
                                        : TextStyle(
                                            color: isDarkMode
                                                ? AppColors.white
                                                : AppColors.black,
                                            fontWeight: FontWeight.w600))),
                            CustomTextFormField(
                              controller: customerNameController,
                              label: "Customer Name",
                              hintText: "Enter Customer Name",
                              textInputAction: TextInputAction.next,
                              enabled: customer.value == null ||
                                  customer.value?.id == "00",
                              fillColor: isDarkMode
                                  ? AppColors.inputBackgroundColor
                                  : AppColors.grey,
                              validator: (value) {
                                if (value!.length == 0)
                                  return "Customer Name is required";
                                else if (value.length < 2)
                                  return "Customer Name is too short";
                                return null;
                              },
                            ),
                            CustomTextFormField(
                                controller: customerPhoneController,
                                label: "Phone Number",
                                hintText: "Enter Phone Number",
                                maxLength: 11,
                                showCounterText: false,
                                maxLengthEnforced: true,
                                fillColor: isDarkMode
                                    ? AppColors.inputBackgroundColor
                                    : AppColors.grey,
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(
                                      RegExp(r'^[0-9]*$'))
                                ],
                                textInputAction: TextInputAction.next,
                                enabled: customer.value == null ||
                                    customer.value?.id == "00",
                                textInputType: TextInputType.phone,
                                validator: (value) {
                                  if (value!.length == 0)
                                    return "Phone number is required";
                                  else if (value.length < 11)
                                    return "Phone number should be 11 digits";
                                  return null;
                                }),
                            CustomTextFormField(
                              controller: customerEmailController,
                              label: "Email Address",
                              fillColor: isDarkMode
                                  ? AppColors.inputBackgroundColor
                                  : AppColors.grey,
                              hintText: "davejossy9@gmail.com",
                              enabled: customer.value == null ||
                                  customer.value?.id == "00",
                              textInputAction: TextInputAction.next,
                              validator: (value) =>
                                  EmailValidator.validate(value ?? "")
                                      ? null
                                      : "Please enter a valid email",
                            ),
                            CustomTextFormField(
                              controller: customerAddressController,
                              maxLines: 2,
                              maxLength: 250,
                              label: "Enter Address",
                              hintText: "Address",
                              maxLengthEnforced: true,
                              enabled: customer.value == null ||
                                  customer.value?.id == "00",
                              validator: (value) {
                                if (value!.length == 0)
                                  return "Address is required";
                                else if (value.length < 6)
                                  return "Address is too short";
                                return null;
                              },
                              fillColor: isDarkMode
                                  ? AppColors.inputBackgroundColor
                                  : AppColors.grey,
                            ),
                            Visibility(
                              visible: customer.value == null ||
                                  customer.value?.id == "00",
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Save Customer Information",
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
                                  Obx(
                                    () => CupertinoSwitch(
                                        activeColor: AppColors.primaryColor,
                                        value: save.value,
                                        onChanged: (value) {
                                          toggleSaver();
                                        }),
                                  ),
                                  addVerticalSpace(15.h),
                                ],
                              ),
                            ),
                            CustomButton(
                              title: "Continue",
                              onTap: () => {
                                validateCustomer(),
                              },
                            ),
                            addVerticalSpace(10.h),
                          ],
                        )))),
              ),
            ),
          );
        }));
  }

  logoAction(context, isDarkMode, theme) {
    showDialog(
        context: (context),
        builder: (BuildContext context) => Dialog(
            backgroundColor: isDarkMode ? AppColors.blackBg : AppColors.white,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            child: Container(
              height: Platform.isIOS ? 200 : 150,
              width: MediaQuery.of(context).size.width * 0.85,
              padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
              decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Edit or Remove Logo",
                    style: TextStyle(
                      color: isDarkMode ? AppColors.white : AppColors.black,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  addVerticalSpace(16.h),
                  GestureDetector(
                    onTap: () async {
                      await picker
                          .pickImage(
                              source: ImageSource.gallery, imageQuality: 25)
                          .then(
                        (value) {
                          if (value != null) {
                            Navigator.pop(context);
                            logo = File(value.path);
                            uploadInvoiceBusinessLogo();
                          }
                        },
                      );
                    },
                    child: Container(
                      color: Colors.transparent,
                      child: Row(
                        children: [
                          SvgPicture.asset(
                            AppSvg.pendown,
                            color:
                                isDarkMode ? AppColors.white : AppColors.black,
                            height: 14.h,
                          ),
                          SizedBox(width: 15),
                          Text(
                            "Edit",
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
                  addVerticalSpace(20.h),
                  GestureDetector(
                    onTap: () async {
                      Navigator.pop(context);
                      removeInvoiceBusinessLogo();
                    },
                    child: Container(
                      color: Colors.transparent,
                      child: Row(
                        children: [
                          Icon(
                            Icons.delete_rounded,
                            size: 20,
                            color:
                                isDarkMode ? AppColors.white : AppColors.black,
                          ),
                          addHorizontalSpace(12.w),
                          Text(
                            "Remove",
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
                ],
              ),
            )));
  }

  editBusinessInfo(context, isDarkMode, theme) {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: ((context) {
          return Dialog(
            backgroundColor: isDarkMode ? AppColors.blackBg : AppColors.white,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.7,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Edit Business Information",
                            style: theme.textTheme.headline6,
                          ),
                          InkWell(
                              onTap: () => Get.back(),
                              child: SvgPicture.asset(
                                AppSvg.cancel,
                                height: 18.h,
                              ))
                        ],
                      ),
                      addVerticalSpace(10.h),
                      CustomTextFormField(
                        label: "Company Name",
                        hintText: "Enter Company Name",
                        fillColor: isDarkMode
                            ? AppColors.inputBackgroundColor
                            : AppColors.grey,
                        textInputAction: TextInputAction.go,
                        textInputType: TextInputType.phone,
                        validator: (value) {
                          if (value!.length == 0)
                            return "Company Name is required";
                          return null;
                        },
                      ),
                      CustomTextFormField(
                          // controller: packagesController.phoneNumberController,
                          label: "Phone Number",
                          hintText: "Enter Phone Number",
                          maxLength: 11,
                          showCounterText: false,
                          maxLengthEnforced: true,
                          fillColor: isDarkMode
                              ? AppColors.inputBackgroundColor
                              : AppColors.grey,
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(
                                RegExp(r'^[0-9]*$'))
                          ],
                          textInputAction: TextInputAction.next,
                          textInputType: TextInputType.phone,
                          validator: (value) {
                            if (value!.length == 0)
                              return "Phone number is required";
                            else if (value.length < 11)
                              return "Phone number should be 11 digits";
                            return null;
                          }),
                      CustomTextFormField(
                        // controller: signUpController.emailController,
                        label: "Email Address",
                        fillColor: isDarkMode
                            ? AppColors.inputBackgroundColor
                            : AppColors.grey,
                        hintText: "davejossy9@gmail.com",
                        textInputAction: TextInputAction.next,
                        validator: (value) =>
                            EmailValidator.validate(value ?? "")
                                ? null
                                : "Please enter a valid email",
                      ),
                      CustomTextFormField(
                        maxLines: 3,
                        maxLength: 250,
                        maxLengthEnforced: true,
                        label: "Enter Address",
                        hintText: "Address",
                        validator: (value) {
                          if (value!.length == 0)
                            return "Issue description cannot be empty";
                          else if (value.length < 20)
                            return "Issue description is too short";
                          return null;
                        },
                        fillColor: isDarkMode
                            ? AppColors.inputBackgroundColor
                            : AppColors.grey,
                      ),
                      addVerticalSpace(10.h),
                      CustomButton(
                        title: "Done",
                        onTap: () {},
                      ),
                      addVerticalSpace(10.h),
                    ],
                  ),
                ),
              ),
            ),
          );
        }));
  }

  showCustomerList(context, isDarkMode) {
    return showModalBottomSheet(
        backgroundColor: AppColors.transparent,
        context: context,
        isScrollControlled: true,
        builder: (context) {
          return FractionallySizedBox(
            heightFactor: 0.5,
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
                              "Select Customer",
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
                  Obx((() => Expanded(
                      child: ListView.builder(
                          itemCount: customers.length,
                          shrinkWrap: true,
                          physics: BouncingScrollPhysics(),
                          itemBuilder: ((context, index) {
                            return Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 10.h, horizontal: 20.w),
                              child: GestureDetector(
                                onTap: () {
                                  pop();
                                  customer.value = customers[index];
                                  save.value = false;
                                  if (customers[index].id == "00") {
                                    resetCustomerFields();
                                  } else {
                                    customerNameController.text =
                                        customers[index].fullName ?? "";
                                    customerPhoneController.text =
                                        customers[index].phone ?? "";
                                    customerEmailController.text =
                                        customers[index].email ?? "";
                                    customerAddressController.text =
                                        customers[index].address ?? "";
                                  }
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
                                                customers[index].fullName!,
                                                style: TextStyle(
                                                    fontFamily: "DMSans",
                                                    fontSize: 12.sp,
                                                    fontWeight: customer.value
                                                                    ?.id !=
                                                                "" &&
                                                            customer.value
                                                                    ?.id ==
                                                                customers[index]
                                                                    .id
                                                        ? FontWeight.w700
                                                        : FontWeight.w600,
                                                    color: isDarkMode
                                                        ? AppColors.mainGreen
                                                        : AppColors
                                                            .primaryColor),
                                              ),
                                              customers[index].email != "N/A"
                                                  ? Text(
                                                      customers[index].email!,
                                                      style: TextStyle(
                                                          fontFamily: "DMSans",
                                                          fontSize: 10.sp,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          color: isDarkMode
                                                              ? AppColors.white
                                                              : AppColors
                                                                  .black),
                                                    )
                                                  : SizedBox(),
                                              customers[index].phone != "N/A"
                                                  ? Text(
                                                      customers[index].phone!,
                                                      style: TextStyle(
                                                          fontFamily: "DMSans",
                                                          fontSize: 10.sp,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          color: isDarkMode
                                                              ? AppColors.white
                                                              : AppColors
                                                                  .black),
                                                    )
                                                  : SizedBox()
                                            ],
                                          ),
                                          customer.value?.id != "" &&
                                                  customer.value?.id ==
                                                      customers[index].id
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
                          }))))),
                ],
              )),
            ),
          );
        });
  }
}
