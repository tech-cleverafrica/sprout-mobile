import 'dart:io';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'package:sprout_mobile/config/Config.dart';

var oCcy = new NumberFormat("#,##0.00", "en_US");

DateTime localDate(String date) {
  return DateTime.parse(date).toLocal();
}

class PdfService {
  Future<File> generateReceipt(
    String amount,
    String type,
    String accountNumber,
    String name,
    String bank,
    String ref,
    String sessionID,
    String tfFee,
    String date,
    String narration,
    String rrn,
    bool isPosWithdrawal,
    String status,
  ) async {
    final pdf = Document();
    final customFont =
        Font.ttf(await rootBundle.load('assets/fonts/Montserrat-Regular.ttf'));
    final customFontBold =
        Font.ttf(await rootBundle.load('assets/fonts/Montserrat-SemiBold.ttf'));
    var assetImage = MemoryImage(
      (await rootBundle.load('assets/images/receipt-logo.png'))
          .buffer
          .asUint8List(),
    );
    pdf.addPage(MultiPage(
        margin: EdgeInsets.all(32),
        build: (context) => <Widget>[
              buildCustomeHeader(assetImage),
              buildCustomeHeadline(customFontBold),
              Container(
                  decoration: BoxDecoration(
                      color: PdfColor.fromHex('#F5F5F5'),
                      borderRadius: BorderRadius.circular(10)),
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 30),
                  child: Column(children: [
                    Container(
                        padding: EdgeInsets.only(bottom: 5 * PdfPageFormat.mm),
                        child: rowText(
                            label("Transaction Amount", customFont),
                            content("₦ " + oCcy.format(double.parse(amount)),
                                customFontBold))),
                    SizedBox(height: 5 * PdfPageFormat.mm),
                    Container(
                        padding: EdgeInsets.only(bottom: 5 * PdfPageFormat.mm),
                        child: rowText(
                            label("Transaction Type", customFont),
                            content(
                                !isPosWithdrawal
                                    ? "FUNDS TRANSFER"
                                    : "POS CASH WITHDRAWAL",
                                customFontBold))),
                    SizedBox(height: 5 * PdfPageFormat.mm),
                    Container(
                        padding: EdgeInsets.only(bottom: 5 * PdfPageFormat.mm),
                        child: rowText(
                            label("Transaction Date", customFont),
                            content(
                                DateFormat('dd/MM/yyyy \t\t h:mma')
                                    .format(localDate(date)),
                                customFontBold))),
                    SizedBox(height: 5 * PdfPageFormat.mm),
                    type != "FUNDS_TRANSFER"
                        ? Container(
                            padding:
                                EdgeInsets.only(bottom: 5 * PdfPageFormat.mm),
                            child: rowText(
                                label("Transaction Fee", customFont),
                                content(
                                    !isPosWithdrawal
                                        ? tfFee != null.toString()
                                            ? "₦ " +
                                                double.parse(oCcy.format(
                                                        int.parse(tfFee
                                                            .toString()
                                                            .split(".")[0])))
                                                    .toStringAsFixed(2)
                                            : "₦ 0.0"
                                        : tfFee != null.toString()
                                            ? "₦ " +
                                                double.parse(tfFee)
                                                    .toStringAsFixed(2)
                                            : "-",
                                    customFontBold)))
                        : SizedBox(),
                    type != "FUNDS_TRANSFER"
                        ? SizedBox(height: 5 * PdfPageFormat.mm)
                        : SizedBox(),
                    !isPosWithdrawal
                        ? Container(
                            padding:
                                EdgeInsets.only(bottom: 5 * PdfPageFormat.mm),
                            child: rowText(label("Account Number", customFont),
                                content(accountNumber, customFontBold)))
                        : SizedBox(),
                    !isPosWithdrawal
                        ? SizedBox(height: 5 * PdfPageFormat.mm)
                        : SizedBox(),
                    !isPosWithdrawal
                        ? Container(
                            padding:
                                EdgeInsets.only(bottom: 5 * PdfPageFormat.mm),
                            child: rowText(
                                label("Beneficiary Name", customFont),
                                content(name, customFontBold)))
                        : SizedBox(),
                    !isPosWithdrawal
                        ? SizedBox(height: 5 * PdfPageFormat.mm)
                        : SizedBox(),
                    !isPosWithdrawal
                        ? Container(
                            padding:
                                EdgeInsets.only(bottom: 5 * PdfPageFormat.mm),
                            child: rowText(
                                label("Beneficiary Bank", customFont),
                                content(bank, customFontBold)))
                        : SizedBox(),
                    !isPosWithdrawal
                        ? SizedBox(height: 5 * PdfPageFormat.mm)
                        : SizedBox(),
                    Container(
                        padding: EdgeInsets.only(bottom: 5 * PdfPageFormat.mm),
                        child: rowText(label("Transaction Ref", customFont),
                            content(ref, customFontBold))),
                    SizedBox(height: 5 * PdfPageFormat.mm),
                    type == "FUNDS_TRANSFER"
                        ? Container(
                            padding:
                                EdgeInsets.only(bottom: 5 * PdfPageFormat.mm),
                            child: rowText(label("Session ID", customFont),
                                content(sessionID, customFontBold)))
                        : SizedBox(),
                    type == "FUNDS_TRANSFER"
                        ? SizedBox(height: 5 * PdfPageFormat.mm)
                        : SizedBox(),
                    Container(
                        padding: EdgeInsets.only(bottom: 5 * PdfPageFormat.mm),
                        child: rowText(
                            label(!isPosWithdrawal ? "Narration" : "RRN",
                                customFont),
                            content(!isPosWithdrawal ? narration : rrn,
                                customFontBold))),
                    SizedBox(height: 5 * PdfPageFormat.mm),
                    Container(
                        padding: EdgeInsets.only(bottom: 5 * PdfPageFormat.mm),
                        child: rowText(
                            label("Status", customFont),
                            content(status.toString().toUpperCase(),
                                customFontBold))),
                  ])),
              SizedBox(height: 2 * PdfPageFormat.mm),
              footer(customFont)
            ]));
    return saveDocument(name: 'Sprout-' + type + '.pdf', pdf: pdf);
  }

  Future<File> generateBillPaymentReceipt(
    String amount,
    String type,
    String smartCardNumber,
    String phoneNumber,
    String accountNumber,
    String group,
    String bundle,
    String ref,
    String tfFee,
    String commission,
    String date,
    String narration,
    String status,
  ) async {
    final pdf = Document();
    final customFont =
        Font.ttf(await rootBundle.load('assets/fonts/Montserrat-Regular.ttf'));
    final customFontBold =
        Font.ttf(await rootBundle.load('assets/fonts/Montserrat-SemiBold.ttf'));
    var assetImage = MemoryImage(
      (await rootBundle.load('assets/images/receipt-logo.png'))
          .buffer
          .asUint8List(),
    );
    pdf.addPage(MultiPage(
        margin: EdgeInsets.all(32),
        build: (context) => <Widget>[
              buildCustomeHeader(assetImage),
              buildCustomeHeadline(customFontBold),
              Container(
                  decoration: BoxDecoration(
                      color: PdfColor.fromHex('#F5F5F5'),
                      borderRadius: BorderRadius.circular(10)),
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 30),
                  child: Column(children: [
                    Container(
                        padding: EdgeInsets.only(bottom: 5 * PdfPageFormat.mm),
                        child: rowText(
                            label("Transaction Amount", customFont),
                            content(
                                "₦ " +
                                    oCcy.format(
                                        int.parse(amount.split(".")[0])),
                                customFontBold))),
                    SizedBox(height: 5 * PdfPageFormat.mm),
                    Container(
                        padding: EdgeInsets.only(bottom: 5 * PdfPageFormat.mm),
                        child: rowText(label("Transaction Type", customFont),
                            content("BILLS PAYMENT", customFontBold))),
                    SizedBox(height: 5 * PdfPageFormat.mm),
                    Container(
                        padding: EdgeInsets.only(bottom: 5 * PdfPageFormat.mm),
                        child: rowText(
                            label("Bundle", customFont),
                            content(
                                group == "DATA"
                                    ? joinFirst(bundle)
                                    : bundle.split("_").join(" "),
                                customFontBold))),
                    SizedBox(height: 5 * PdfPageFormat.mm),
                    Container(
                        padding: EdgeInsets.only(bottom: 5 * PdfPageFormat.mm),
                        child: rowText(
                            label("Transaction Date", customFont),
                            content(
                                DateFormat('dd/MM/yyyy \t\t h:mma')
                                    .format(localDate(date)),
                                customFontBold))),
                    SizedBox(height: 5 * PdfPageFormat.mm),
                    Container(
                        padding: EdgeInsets.only(bottom: 5 * PdfPageFormat.mm),
                        child: rowText(
                            label("Transaction Fee", customFont),
                            content(
                                tfFee != null.toString()
                                    ? "₦ " +
                                        double.parse(tfFee).toStringAsFixed(2)
                                    : "-",
                                customFontBold))),
                    SizedBox(height: 5 * PdfPageFormat.mm),
                    Container(
                        padding: EdgeInsets.only(bottom: 5 * PdfPageFormat.mm),
                        child: rowText(
                            label("Commission", customFont),
                            content(
                                tfFee != null.toString()
                                    ? "₦ " +
                                        double.parse(commission)
                                            .toStringAsFixed(2)
                                    : "-",
                                customFontBold))),
                    SizedBox(height: 5 * PdfPageFormat.mm),
                    Container(
                        padding: EdgeInsets.only(bottom: 5 * PdfPageFormat.mm),
                        child: rowText(
                            label(
                                group == "CABLE"
                                    ? "Smartcard Number"
                                    : group == "DISCO" ||
                                            group == 'ELECTRIC_DISCO'
                                        ? "Meter Number"
                                        : group == "DATA"
                                            ? "Phone Number"
                                            : group == "BETTING"
                                                ? "User ID"
                                                : group == "UTILITY_PAYMENT"
                                                    ? "Card Number"
                                                    : "Account Number",
                                customFont),
                            content(
                                group == "CABLE"
                                    ? smartCardNumber
                                    : group == "DISCO" ||
                                            group == 'ELECTRIC_DISCO'
                                        ? accountNumber
                                        : group == "DATA"
                                            ? phoneNumber
                                            : group == "BETTING"
                                                ? phoneNumber
                                                : group == "UTILITY_PAYMENT"
                                                    ? phoneNumber
                                                    : phoneNumber,
                                customFontBold))),
                    SizedBox(height: 5 * PdfPageFormat.mm),
                    SizedBox(height: 5 * PdfPageFormat.mm),
                    Container(
                        padding: EdgeInsets.only(bottom: 5 * PdfPageFormat.mm),
                        child: rowText(label("Transaction Ref", customFont),
                            content(ref, customFontBold))),
                    SizedBox(height: 5 * PdfPageFormat.mm),
                    Container(
                        padding: EdgeInsets.only(bottom: 5 * PdfPageFormat.mm),
                        child: rowText(label("Narration", customFont),
                            longContent(narration, customFontBold))),
                    SizedBox(height: 5 * PdfPageFormat.mm),
                    Container(
                        padding: EdgeInsets.only(bottom: 5 * PdfPageFormat.mm),
                        child: rowText(
                            label("Status", customFont),
                            content(status.toString().toUpperCase(),
                                customFontBold))),
                  ])),
              SizedBox(height: 2 * PdfPageFormat.mm),
              footer(customFont)
            ]));
    return saveDocument(name: 'Sprout-' + type + '.pdf', pdf: pdf);
  }

  Future<File> generateAirtimeReceipt(
    String amount,
    String type,
    String phoneNumber,
    String networkProvider,
    String ref,
    String tfFee,
    String commission,
    String date,
    String status,
  ) async {
    final pdf = Document();
    final customFont =
        Font.ttf(await rootBundle.load('assets/fonts/Montserrat-Regular.ttf'));
    final customFontBold =
        Font.ttf(await rootBundle.load('assets/fonts/Montserrat-SemiBold.ttf'));
    var assetImage = MemoryImage(
      (await rootBundle.load('assets/images/receipt-logo.png'))
          .buffer
          .asUint8List(),
    );
    pdf.addPage(MultiPage(
        margin: EdgeInsets.all(32),
        build: (context) => <Widget>[
              buildCustomeHeader(assetImage),
              buildCustomeHeadline(customFontBold),
              Container(
                  decoration: BoxDecoration(
                      color: PdfColor.fromHex('#F5F5F5'),
                      borderRadius: BorderRadius.circular(10)),
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 30),
                  child: Column(children: [
                    Container(
                        padding: EdgeInsets.only(bottom: 5 * PdfPageFormat.mm),
                        child: rowText(
                            label("Transaction Amount", customFont),
                            content(
                                "₦ " +
                                    oCcy.format(
                                        int.parse(amount.split(".")[0])),
                                customFontBold))),
                    SizedBox(height: 5 * PdfPageFormat.mm),
                    Container(
                        padding: EdgeInsets.only(bottom: 5 * PdfPageFormat.mm),
                        child: rowText(label("Transaction Type", customFont),
                            content("AIRTIME VTU", customFontBold))),
                    SizedBox(height: 5 * PdfPageFormat.mm),
                    Container(
                        padding: EdgeInsets.only(bottom: 5 * PdfPageFormat.mm),
                        child: rowText(label("Network Provider", customFont),
                            content(networkProvider, customFontBold))),
                    SizedBox(height: 5 * PdfPageFormat.mm),
                    Container(
                        padding: EdgeInsets.only(bottom: 5 * PdfPageFormat.mm),
                        child: rowText(
                            label("Transaction Date", customFont),
                            content(
                                DateFormat('dd/MM/yyyy \t\t h:mma')
                                    .format(localDate(date)),
                                customFontBold))),
                    SizedBox(height: 5 * PdfPageFormat.mm),
                    Container(
                        padding: EdgeInsets.only(bottom: 5 * PdfPageFormat.mm),
                        child: rowText(
                            label("Transaction Fee", customFont),
                            content(
                                tfFee != null.toString()
                                    ? "₦ " +
                                        double.parse(tfFee).toStringAsFixed(2)
                                    : "-",
                                customFontBold))),
                    SizedBox(height: 5 * PdfPageFormat.mm),
                    Container(
                        padding: EdgeInsets.only(bottom: 5 * PdfPageFormat.mm),
                        child: rowText(
                            label("Commission", customFont),
                            content(
                                commission != null.toString()
                                    ? "₦ " +
                                        double.parse(commission)
                                            .toStringAsFixed(2)
                                    : "-",
                                customFontBold))),
                    SizedBox(height: 5 * PdfPageFormat.mm),
                    Container(
                        padding: EdgeInsets.only(bottom: 5 * PdfPageFormat.mm),
                        child: rowText(label("Phone Number", customFont),
                            content(phoneNumber, customFontBold))),
                    SizedBox(height: 5 * PdfPageFormat.mm),
                    Container(
                        padding: EdgeInsets.only(bottom: 5 * PdfPageFormat.mm),
                        child: rowText(label("Transaction Ref", customFont),
                            content(ref, customFontBold))),
                    SizedBox(height: 5 * PdfPageFormat.mm),
                    Container(
                        padding: EdgeInsets.only(bottom: 5 * PdfPageFormat.mm),
                        child: rowText(
                            label("Status", customFont),
                            content(status.toString().toUpperCase(),
                                customFontBold))),
                  ])),
              SizedBox(height: 2 * PdfPageFormat.mm),
              footer(customFont)
            ]));
    return saveDocument(name: 'Sprout-' + type + '.pdf', pdf: pdf);
  }

  Future<File> generateWalletReceipt(
    String amount,
    String type,
    String accountNumber,
    String name,
    String bank,
    String ref,
    String tfFee,
    String date,
    String narration,
    String status,
  ) async {
    final pdf = Document();
    final customFont =
        Font.ttf(await rootBundle.load('assets/fonts/Montserrat-Regular.ttf'));
    final customFontBold =
        Font.ttf(await rootBundle.load('assets/fonts/Montserrat-SemiBold.ttf'));
    var assetImage = MemoryImage(
      (await rootBundle.load('assets/images/receipt-logo.png'))
          .buffer
          .asUint8List(),
    );
    pdf.addPage(MultiPage(
        margin: EdgeInsets.all(32),
        build: (context) => <Widget>[
              buildCustomeHeader(assetImage),
              buildCustomeHeadline(customFontBold),
              Container(
                  decoration: BoxDecoration(
                      color: PdfColor.fromHex('#F5F5F5'),
                      borderRadius: BorderRadius.circular(10)),
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 30),
                  child: Column(children: [
                    Container(
                        padding: EdgeInsets.only(bottom: 5 * PdfPageFormat.mm),
                        child: rowText(
                            label("Transaction Amount", customFont),
                            content(
                                "₦ " +
                                    oCcy.format(
                                        int.parse(amount.split(".")[0])),
                                customFontBold))),
                    SizedBox(height: 5 * PdfPageFormat.mm),
                    Container(
                        padding: EdgeInsets.only(bottom: 5 * PdfPageFormat.mm),
                        child: rowText(label("Transaction Type", customFont),
                            content("WALLET TOP-UP", customFontBold))),
                    SizedBox(height: 5 * PdfPageFormat.mm),
                    Container(
                        padding: EdgeInsets.only(bottom: 5 * PdfPageFormat.mm),
                        child: rowText(
                            label("Transaction Date", customFont),
                            content(
                                DateFormat('dd/MM/yyyy \t\t h:mma')
                                    .format(localDate(date)),
                                customFontBold))),
                    SizedBox(height: 5 * PdfPageFormat.mm),
                    Container(
                        padding: EdgeInsets.only(bottom: 5 * PdfPageFormat.mm),
                        child: rowText(
                            label("Transaction Fee", customFont),
                            content(
                                tfFee != null.toString()
                                    ? "₦ " +
                                        double.parse(tfFee).toStringAsFixed(2)
                                    : "-",
                                customFontBold))),
                    SizedBox(height: 5 * PdfPageFormat.mm),
                    Container(
                        padding: EdgeInsets.only(bottom: 5 * PdfPageFormat.mm),
                        child: rowText(
                            label("Sender's Account Number", customFont),
                            content(accountNumber, customFontBold))),
                    SizedBox(height: 5 * PdfPageFormat.mm),
                    Container(
                        padding: EdgeInsets.only(bottom: 5 * PdfPageFormat.mm),
                        child: rowText(label("Sender's Name", customFont),
                            longContent(name, customFontBold))),
                    SizedBox(height: 5 * PdfPageFormat.mm),
                    Container(
                        padding: EdgeInsets.only(bottom: 5 * PdfPageFormat.mm),
                        child: rowText(label("Sender's Bank", customFont),
                            content(bank, customFontBold))),
                    SizedBox(height: 5 * PdfPageFormat.mm),
                    Container(
                        padding: EdgeInsets.only(bottom: 5 * PdfPageFormat.mm),
                        child: rowText(label("Transaction Ref", customFont),
                            content(ref, customFontBold))),
                    SizedBox(height: 5 * PdfPageFormat.mm),
                    Container(
                        padding: EdgeInsets.only(bottom: 5 * PdfPageFormat.mm),
                        child: rowText(label("Narration", customFont),
                            longContent(narration, customFontBold))),
                    SizedBox(height: 5 * PdfPageFormat.mm),
                    Container(
                        padding: EdgeInsets.only(bottom: 5 * PdfPageFormat.mm),
                        child: rowText(
                            label("Status", customFont),
                            content(status.toString().toUpperCase(),
                                customFontBold))),
                  ])),
              SizedBox(height: 2 * PdfPageFormat.mm),
              footer(customFont)
            ]));
    return saveDocument(name: 'Sprout-' + type + '.pdf', pdf: pdf);
  }

  Future<File> generateDebitReceipt(
    String amount,
    String type,
    String ref,
    String tfFee,
    String balance,
    String date,
    String narration,
    String status,
  ) async {
    final pdf = Document();
    final customFont =
        Font.ttf(await rootBundle.load('assets/fonts/Montserrat-Regular.ttf'));
    final customFontBold =
        Font.ttf(await rootBundle.load('assets/fonts/Montserrat-SemiBold.ttf'));
    var assetImage = MemoryImage(
      (await rootBundle.load('assets/images/receipt-logo.png'))
          .buffer
          .asUint8List(),
    );
    pdf.addPage(MultiPage(
        margin: EdgeInsets.all(32),
        build: (context) => <Widget>[
              buildCustomeHeader(assetImage),
              buildCustomeHeadline(customFontBold),
              Container(
                  decoration: BoxDecoration(
                      color: PdfColor.fromHex('#F5F5F5'),
                      borderRadius: BorderRadius.circular(10)),
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 30),
                  child: Column(children: [
                    Container(
                        padding: EdgeInsets.only(bottom: 5 * PdfPageFormat.mm),
                        child: rowText(
                            label("Transaction Amount", customFont),
                            content(
                                "₦ " +
                                    oCcy.format(
                                        int.parse(amount.split(".")[0])),
                                customFontBold))),
                    SizedBox(height: 5 * PdfPageFormat.mm),
                    Container(
                        padding: EdgeInsets.only(bottom: 5 * PdfPageFormat.mm),
                        child: rowText(label("Transaction Type", customFont),
                            content("DEBIT", customFontBold))),
                    SizedBox(height: 5 * PdfPageFormat.mm),
                    Container(
                        padding: EdgeInsets.only(bottom: 5 * PdfPageFormat.mm),
                        child: rowText(
                            label("Transaction Date", customFont),
                            content(
                                DateFormat('dd/MM/yyyy \t\t h:mma')
                                    .format(localDate(date)),
                                customFontBold))),
                    SizedBox(height: 5 * PdfPageFormat.mm),
                    Container(
                        padding: EdgeInsets.only(bottom: 5 * PdfPageFormat.mm),
                        child: rowText(
                            label("Transaction Fee", customFont),
                            content(
                                tfFee != null.toString()
                                    ? "₦ " +
                                        double.parse(tfFee).toStringAsFixed(2)
                                    : "-",
                                customFontBold))),
                    SizedBox(height: 5 * PdfPageFormat.mm),
                    Container(
                        padding: EdgeInsets.only(bottom: 5 * PdfPageFormat.mm),
                        child: rowText(
                            label("Wallet Balance", customFont),
                            content(
                                balance != null.toString()
                                    ? "₦ " +
                                        double.parse(balance).toStringAsFixed(2)
                                    : "-",
                                customFontBold))),
                    SizedBox(height: 5 * PdfPageFormat.mm),
                    Container(
                        padding: EdgeInsets.only(bottom: 5 * PdfPageFormat.mm),
                        child: rowText(label("Transaction Ref", customFont),
                            content(ref, customFontBold))),
                    SizedBox(height: 5 * PdfPageFormat.mm),
                    Container(
                        padding: EdgeInsets.only(bottom: 5 * PdfPageFormat.mm),
                        child: rowText(label("Comment", customFont),
                            longContent(narration, customFontBold))),
                    SizedBox(height: 5 * PdfPageFormat.mm),
                    Container(
                        padding: EdgeInsets.only(bottom: 5 * PdfPageFormat.mm),
                        child: rowText(
                            label("Status", customFont),
                            content(status.toString().toUpperCase(),
                                customFontBold))),
                  ])),
              SizedBox(height: 2 * PdfPageFormat.mm),
              footer(customFont)
            ]));
    return saveDocument(name: 'Sprout-' + type + '.pdf', pdf: pdf);
  }

  static Widget footer(Font customFont) => Container(
        width: double.infinity,
        child: RichText(
            text: TextSpan(children: [
          TextSpan(
              text:
                  "If you have any question or would like more information, please contact us on ",
              style: TextStyle(font: customFont)),
          WidgetSpan(
              child: Row(children: [
            UrlLink(
                child: Text(APP_CUSTOMER_SUPPORT_EMAIL,
                    style: TextStyle(
                        font: customFont,
                        decoration: TextDecoration.underline,
                        color: PdfColors.blue)),
                destination: "mailto:$APP_CUSTOMER_SUPPORT_EMAIL"),
          ])),
          WidgetSpan(
              child:
                  Column(children: [SizedBox(height: 10 * PdfPageFormat.mm)])),
          TextSpan(
              text: "or call us anytime on",
              style: TextStyle(font: customFont)),
          WidgetSpan(
              child: Row(children: [
            UrlLink(
                child: Text(APP_CUSTOMER_SUPPORT_PHONE_NUMBER_TITLE,
                    style: TextStyle(
                        font: customFont,
                        decoration: TextDecoration.underline,
                        color: PdfColors.blue)),
                destination: "tel:$APP_CUSTOMER_SUPPORT_PHONE_NUMBER"),
          ])),
        ])),
      );

  static Widget rowText(Widget label, Widget content) => Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [label, content]);

  static Widget label(String text, Font customFont) => Column(children: [
        leftText(text, customFont),
      ]);

  static Widget content(String text, Font customFont) => Column(children: [
        rightText(text, customFont),
      ]);

  static Widget longContent(String text, Font customFont) => Container(
        width: 100 * PdfPageFormat.mm,
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [longRightText(text, customFont)]),
      );

  static Widget leftText(String text, Font customFont) => Text(text,
      style: TextStyle(
          color: PdfColor.fromHex('#656464'),
          fontWeight: FontWeight.bold,
          fontSize: 12,
          font: customFont));

  static Widget rightText(String text, Font customFont) => Text(text,
      style: TextStyle(
          color: PdfColor.fromHex('#000000'), fontSize: 12, font: customFont));

  static Widget longRightText(String text, Font customFont) => Text(text,
      style: TextStyle(
          color: PdfColor.fromHex('#000000'), fontSize: 12, font: customFont));

  static Widget buildCustomeHeader(MemoryImage assetImage) => Container(
        child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [Image(assetImage, height: 40)]),
      );

  static Widget buildCustomeHeadline(Font customFont) => Container(
      width: double.infinity,
      padding: EdgeInsets.only(
          bottom: 12 * PdfPageFormat.mm, top: 8 * PdfPageFormat.mm),
      child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        Container(
            child: Text('Transaction Receipt',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    font: customFont,
                    color: PdfColor.fromHex("#000000"))),
            padding: EdgeInsets.all(4))
      ]));

  static Future<File> saveDocument({
    String? name,
    Document? pdf,
  }) async {
    final bytes = await pdf!.save();

    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/$name');

    await file.writeAsBytes(bytes);

    return file;
  }

  static String joinFirst(String string) {
    List<String> stringArr = string.split("_");
    String finalString = "";
    for (var i = 0; i < stringArr.length; i++) {
      if (i == 1 && isNumeric(stringArr[1]) && isNumeric(stringArr[2])) {
        finalString = finalString + "." + stringArr[i];
      } else {
        finalString = finalString + " " + stringArr[i];
      }
    }
    return finalString;
  }

  static bool isNumeric(String s) {
    if (s == "") {
      return false;
    }
    return double.tryParse(s) != null;
  }
}
