import 'dart:async';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:sprout_mobile/src/utils/message.dart';

class Validators {
  static String? emptyFieldValidator(value) =>
      value.toString().isEmpty ? 'field is required' : null;

  static String? emailFieldValidator(value) =>
      RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
              .hasMatch(value)
          ? null
          : 'invalid email';

  static String? dropdownFieldValidator(value) =>
      value == null ? 'field is required' : null;

  final validateEmail =
      StreamTransformer<String, String>.fromHandlers(handleData: (email, sink) {
    bool emailValid = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9-]+\.[a-zA-Z]+")
        .hasMatch(email);

    if (emailValid) {
      sink.add(email);
    } else {
      sink.addError(invalidEmailAddress);
    }
  });

  final validatePassword = StreamTransformer<String, String>.fromHandlers(
      handleData: (password, sink) {
    if (password.length >= 8) {
      sink.add(password);
    } else {
      sink.addError(invalidPassword);
    }

    /*
    final atLeaseOneUppercaseLetter =
        RegExp(r'^(?=.*[A-Z])[a-zA-Z\d]{1,}$').hasMatch(password);
    final atLeaseOneLowercaseLetter =
        RegExp(r'^(?=.*[a-z])[a-zA-Z\d]{1,}$').hasMatch(password);
    final atLeaseOneNumber =
        RegExp(r'^(?=.*\d)[a-zA-Z\d]{1,}$').hasMatch(password);
    final atLeaseOneSpecialCharacter =
        RegExp(r'^(?=.*[@$!%*#?&])[a-zA-Z\d]{1,}$').hasMatch(password);

    if (password.length >= 8 &&
        atLeaseOneUppercaseLetter &&
        atLeaseOneLowercaseLetter &&
        atLeaseOneNumber &&
        atLeaseOneSpecialCharacter) {
      sink.add(password);
    } else {
      if (!atLeaseOneUppercaseLetter) {
        sink.addError('Password must have at least one uppercase letter');
      } else if (!atLeaseOneLowercaseLetter) {
        sink.addError('Password must have at least one lowercase letter');
      } else if (!atLeaseOneNumber) {
        sink.addError('Password must have at least one number');
      } else if (!atLeaseOneSpecialCharacter) {
        sink.addError('Password must have at least one special character');
      } else if (password.length < 8) {
        sink.addError('Password must be at least 8 characters!');
      }
    }
    */
  });

  final validateFieldNotEmpty =
      StreamTransformer<String, String>.fromHandlers(handleData: (field, sink) {
    if (field.length > 0) {
      sink.add(field);
    } else {
      sink.addError(invalidLength);
    }
  });

  final validateFieldLength =
      StreamTransformer<String, String>.fromHandlers(handleData: (field, sink) {
    if (field.length > 2) {
      sink.add(field);
    } else {
      sink.addError(invalidLength);
    }
  });

  final validateOTPLength =
      StreamTransformer<String, String>.fromHandlers(handleData: (field, sink) {
    if (field.length == 6) {
      sink.add(field);
    } else {
      sink.addError(invalidOTPLength);
    }
  });

  final validateBVNPLength =
      StreamTransformer<String, String>.fromHandlers(handleData: (field, sink) {
    if (field.length == 11) {
      sink.add(field);
    } else {
      sink.addError('Invalid BVN, should have 11 digits');
    }
  });

  final validateNINLength =
      StreamTransformer<String, String>.fromHandlers(handleData: (field, sink) {
    if (field.length == 11) {
      sink.add(field);
    } else {
      sink.addError('Invalid NIN, should have 11 digits');
    }
  });

  static final passwordValidator = MultiValidator(
    [
      RequiredValidator(errorText: 'Password is required.'),
      PatternValidator(r'[A-Z]',
          errorText: 'Password must contain one uppercase letter'),
      PatternValidator(r'[a-z]',
          errorText: 'Password must have at least one lowercase letter.'),
      PatternValidator(r'[0-9]',
          errorText: 'Password must have at least one number.'),
      PatternValidator(r'[!@#$%^&*(),.?":{}|<>]',
          errorText: 'Password must have at least one special character.'),
      MinLengthValidator(8,
          errorText: 'Password must be at least 8 characters long.'),
    ],
  );
}
