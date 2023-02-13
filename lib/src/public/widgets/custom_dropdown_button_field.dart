import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sprout_mobile/src/utils/app_colors.dart';

class CustomDropdownButtonFormField extends StatelessWidget {
  const CustomDropdownButtonFormField({
    Key? key,
    required this.items,
    this.onChanged,
    this.selectedValue,
    this.hintText,
    this.label,
    this.margin = const EdgeInsets.symmetric(vertical: 8.0),
    this.contentPadding =
        const EdgeInsets.symmetric(horizontal: 12.0, vertical: 18.0),
    this.prefixIcon,
    this.suffixIcon,
    this.textFormFieldStyle = const TextStyle(fontSize: 14.0),
    this.hintTextStyle,
    this.borderStyle = BorderStyle.solid,
    this.borderRadius = 6,
    this.borderWidth = 0.5,
    this.textCapitalization = TextCapitalization.none,
    this.borderColor = AppColors.lightGreyBorder,
    this.focusedBorderColor = AppColors.primaryColor,
    this.enabledBorderColor = AppColors.lightGreyBorder,
    this.fillColor = AppColors.lightGreyBg,
    this.filled = true,
    this.hasPrefixIcon = false,
    this.hasSuffixIcon = false,
    this.obscured = false,
    this.enabled = true,
    this.textInputType,
    this.onSaved,
    this.prefixText,
    this.maxLength,
    this.maxLengthEnforced = false,
    this.validator,
    this.inputFormatters,
    this.controller,
    this.maxLines = 1,
    this.errorText,
  }) : super(key: key);

  final List<dynamic> items;
  final String? selectedValue;
  final EdgeInsets margin;
  final EdgeInsets contentPadding;

  final TextStyle? textFormFieldStyle;
  final TextStyle? hintTextStyle;
  final BorderStyle borderStyle;
  final double borderRadius;
  final double borderWidth;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String? hintText;
  final String? label;
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
  final onChanged;
  final ValueChanged<String?>? onSaved;
  final int? maxLength;
  final bool maxLengthEnforced;
  final FormFieldValidator<String>? validator;
  final List<TextInputFormatter>? inputFormatters;
  final TextEditingController? controller;
  final int maxLines;
  final String? errorText;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (label != null) ...[
            Text(
              '$label',
              style: TextStyle(
                  fontSize: 13.0,
                  fontWeight: FontWeight.w500,
                  color: AppColors.greyText),
            ),
            SizedBox(height: 8.0),
          ],
          DropdownButtonHideUnderline(
            child: DropdownButtonFormField2(
              dropdownMaxHeight: MediaQuery.of(context).size.height * 0.5,
              scrollbarAlwaysShow: true,
              icon: Icon(Icons.keyboard_arrow_down),
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
                  borderSide: BorderSide(
                    color: enabledBorderColor,
                    width: borderWidth,
                    style: borderStyle,
                  ),
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
                contentPadding: contentPadding,
                hintText: hintText,
                hintStyle: hintTextStyle,
                filled: filled,
                fillColor: fillColor,
              ),
              hint: Text(
                hintText ?? 'Select',
                style: TextStyle(fontSize: 14),
              ),
              items: items.map((item) {
                return DropdownMenuItem<String>(
                  value: item,
                  child: Text(
                    item is String ? item : (item ? 'Yes' : 'No'),
                    style: TextStyle(fontSize: 14),
                  ),
                );
              }).toList(),
              value: selectedValue,
              onChanged: onChanged ?? onSaved,
              onSaved: onSaved,
              validator: validator,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              buttonHeight: 18,
              style: TextStyle(color: AppColors.greyText),
              buttonWidth: MediaQuery.of(context).size.width,
              itemHeight: 40,
              dropdownDecoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6.0),
                border: Border.all(color: AppColors.lightGreyBorder),
              ),
              dropdownElevation: 2,
              offset: Offset(0, -8.0),
            ),
          ),
        ],
      ),
    );
  }
}
