import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:sprout_mobile/src/public/widgets/custom_text_form_field.dart';
import 'package:sprout_mobile/src/utils/app_colors.dart';

class CustomTextFormPasswordField extends StatefulWidget {
  final String? label;
  final String? hintText;
  final String? errorText;
  final Color? fillColor;
  final ValueChanged<String>? onChanged;
  final TextEditingController? controller;
  final FormFieldValidator<String>? validator;

  const CustomTextFormPasswordField(
      {Key? key,
      this.label,
      this.hintText,
      this.errorText,
      required this.fillColor,
      this.onChanged,
      this.validator,
      this.controller})
      : super(key: key);

  @override
  State<CustomTextFormPasswordField> createState() =>
      _CustomTextFormPasswordFieldState();
}

class _CustomTextFormPasswordFieldState
    extends State<CustomTextFormPasswordField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return CustomTextFormField(
      controller: widget.controller,
      onChanged: widget.onChanged,
      label: widget.label,
      hintText: widget.hintText,
      errorText: widget.errorText,
      obscured: _obscureText,
      hasSuffixIcon: true,
      validator: widget.validator,
      suffixIcon: TextButton(
          onPressed: () => setState(() => _obscureText = !_obscureText),
          child: _obscureText
              ? Container(
                  decoration: BoxDecoration(
                      color: isDarkMode ? AppColors.black : AppColors.white,
                      borderRadius: BorderRadius.circular(5)),
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Icon(CommunityMaterialIcons.eye_off_outline,
                        size: 18,
                        color: isDarkMode ? AppColors.white : AppColors.black),
                  ),
                )
              : Container(
                  decoration: BoxDecoration(
                      color: isDarkMode ? AppColors.black : AppColors.white,
                      borderRadius: BorderRadius.circular(5)),
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Icon(CommunityMaterialIcons.eye_outline,
                        size: 18,
                        color: isDarkMode ? AppColors.white : AppColors.black),
                  ),
                )),
      fillColor: widget.fillColor!,
    );
  }
}
