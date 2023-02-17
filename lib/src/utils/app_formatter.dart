import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';

class AppFormatter {
  MaskedTextController getStrictlyNumberFormatter() {
    return MaskedTextController(
        text: "",
        translator: {
          '0': new RegExp(r'[0-9]'),
        },
        mask: "00000000000000000000000");
  }

  MaskedTextController getStrictlyAlphabetFormatter() {
    return MaskedTextController(
        text: "",
        translator: {
          'a': new RegExp(r'[a-zA-Z]'),
        },
        mask:
            "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa");
  }

  MaskedTextController getPanNumberController() {
    return MaskedTextController(
        text: "",
        translator: {
          '0': new RegExp(r'[0-9]'),
        },
        mask: "0000 0000 0000 0000 000");
  }

  // var maskFormatter = new MaskTextInputFormatter(mask: '+# (###) ###-##-##', filter: { "#": RegExp(r'[0-9]') });

  MoneyMaskedTextController getMoneyController() {
    return MoneyMaskedTextController(
        decimalSeparator: '.', thousandSeparator: ',', precision: 2);
  }

  String formatAsMoney(final double amount, [final String? local]) {
    return NumberFormat("#,##0.00", "en_US").format(amount);
  }

  TextEditingController getGenericTextController() {
    return TextEditingController();
  }
}
