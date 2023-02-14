import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sprout_mobile/src/utils/app_colors.dart';

class CustomTextFormField extends StatelessWidget {
  final TextStyle? textFormFieldStyle;
  final TextStyle? hintTextStyle;
  final BorderStyle borderStyle;
  final double borderRadius;
  final double borderWidth;
  final double contentPaddingHorizontal;
  final double contentPaddingVertical;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String? hintText;
  final String? label;
  final String? otherLabel;
  final String? initialValue;
  final TextCapitalization textCapitalization;
  final String? prefixText;
  final Color borderColor;
  final Color focusedBorderColor;
  final Color enabledBorderColor;
  final Color fillColor;
  final bool filled;
  final bool obscured;
  final bool enabled;
  final bool hasPrefixIcon;
  final bool hasSuffixIcon;
  final TextInputType? textInputType;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String?>? onSaved;
  final int? maxLength;
  final bool maxLengthEnforced;
  final FormFieldValidator<String>? validator;
  final AutovalidateMode? autovalidateMode;
  final List<TextInputFormatter>? inputFormatters;
  final TextEditingController? controller;
  final EdgeInsets margin;
  final int maxLines;
  final String? errorText;

  CustomTextFormField({
    this.prefixIcon,
    this.suffixIcon,
    this.textFormFieldStyle = const TextStyle(fontSize: 14.0),
    this.hintTextStyle,
    this.borderStyle = BorderStyle.solid,
    this.borderRadius = 14,
    this.borderWidth = 0.5,
    this.contentPaddingHorizontal = 12,
    this.contentPaddingVertical = 20,
    this.hintText,
    this.label,
    this.otherLabel = "",
    this.initialValue,
    this.textCapitalization = TextCapitalization.none,
    this.borderColor = AppColors.lightGreyBorder,
    this.focusedBorderColor = AppColors.primaryColor,
    this.enabledBorderColor = AppColors.lightGreyBorder,
    required this.fillColor,
    this.filled = true,
    this.hasPrefixIcon = false,
    this.hasSuffixIcon = false,
    this.obscured = false,
    this.enabled = true,
    this.textInputType,
    this.onChanged,
    this.onSaved,
    this.prefixText,
    this.maxLength,
    this.maxLengthEnforced = false,
    this.validator,
    this.autovalidateMode = AutovalidateMode.onUserInteraction,
    this.inputFormatters,
    this.controller,
    this.maxLines = 1,
    this.margin = const EdgeInsets.symmetric(vertical: 8.0),
    this.errorText,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (label != null) ...[
            Row(
              children: [
                Text(
                  '$label',
                  style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w700,
                      fontFamily: "DMSans",
                      color: AppColors.inputLabelColor),
                ),
              ],
            ),
            SizedBox(height: 8.0),
          ],
          TextFormField(
            controller: controller,
            enabled: enabled,
            style: textFormFieldStyle,
            keyboardType: textInputType,
            textCapitalization: textCapitalization,
            onChanged: onChanged,
            onSaved: onSaved,
            maxLength: maxLength,
            initialValue: controller != null ? null : initialValue,
            validator: validator,
            autovalidateMode: autovalidateMode,
            inputFormatters: inputFormatters,
            maxLines: maxLines,
            decoration: InputDecoration(
              errorText: errorText,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(borderRadius),
                borderSide: BorderSide(
                  color: borderColor,
                  width: borderWidth,
                  style: borderStyle,
                ),
              ),
              prefixText: prefixText,
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(borderRadius),
                  borderSide: BorderSide.none
                  // BorderSide(
                  //   color: enabledBorderColor,
                  //   width: borderWidth,
                  //   style: borderStyle,
                  // ),
                  ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(borderRadius),
                borderSide: BorderSide(
                  color: focusedBorderColor,
                  width: borderWidth,
                  style: borderStyle,
                ),
              ),
              prefixIcon: hasPrefixIcon ? prefixIcon : null,
              suffixIcon: hasSuffixIcon ? suffixIcon : null,
              contentPadding: EdgeInsets.symmetric(
                horizontal: contentPaddingHorizontal,
                vertical: contentPaddingVertical,
              ),
              hintText: hintText,
              hintStyle: hintTextStyle,
              filled: filled,
              fillColor: fillColor,
            ),
            obscureText: obscured,
          ),
        ],
      ),
    );
  }
}
