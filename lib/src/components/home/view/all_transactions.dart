import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sprout_mobile/src/components/home/view/widgets.dart';

import '../../../public/widgets/custom_text_form_field.dart';
import '../../../public/widgets/general_widgets.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/helper_widgets.dart';

class AlltransactionScreen extends StatelessWidget {
  const AlltransactionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final theme = Theme.of(context);
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                getHeader(isDarkMode),
                addVerticalSpace(15.h),
                CustomTextFormField(
                  hintText: "Search your transactions",
                  hasPrefixIcon: true,
                  prefixIcon: Icon(Icons.search),
                  fillColor: isDarkMode
                      ? AppColors.inputBackgroundColor
                      : AppColors.grey,
                ),
                addVerticalSpace(20.h),
                ListView.builder(
                    itemCount: 7,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: ((context, index) {
                      return HistoryCard(
                          theme: theme,
                          isDarkMode: isDarkMode,
                          text: "Fund Transfer");
                    }))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
