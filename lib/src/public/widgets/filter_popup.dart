import 'package:flutter/material.dart';
import 'package:sprout_mobile/src/utils/app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FilterPopup extends StatefulWidget {
  FilterPopup({
    this.store,
    this.title,
    this.altColor,
    this.altDropdownColor,
    this.altTextColor,
    this.callback,
    this.borderRadius,
    this.arrowSize,
    this.padding,
    this.iconPadding,
    this.textSize,
    this.width,
    this.maxHeight,
    this.icon,
    this.open,
  });
  final List? store;
  final String? title;
  final Color? altColor, altDropdownColor, altTextColor;
  final ValueChanged<String>? callback;
  final BorderRadius? borderRadius;
  final double? arrowSize;
  final double? textSize;
  final double? width;
  final double? maxHeight;
  final String? icon;
  final bool? open;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? iconPadding;

  @override
  _FilterPopupState createState() => _FilterPopupState();
}

class _FilterPopupState extends State<FilterPopup> {
  String? _title;
  bool isDropdownOpened = false;
  double? height, width, xPosition, yPosition;

  @override
  void initState() {
    super.initState();
    setState(() => _title = widget.title);
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _showModalBottomSheet() {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            color: Color(0xFF737373),
            child: Container(
              constraints: BoxConstraints(
                minHeight: 150,
                maxHeight: widget.maxHeight ?? 100,
              ),
              child: _buildBottomNavigationMenu(),
              decoration: BoxDecoration(color: Theme.of(context).canvasColor),
            ),
          );
        });
  }

  Column _buildBottomNavigationMenu() {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Column(
      children: [
        Container(
          child: Stack(children: [
            Container(
              width: double.infinity,
              color: isDarkMode ? AppColors.mainGreen : AppColors.primaryColor,
              height: 50.0,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(widget.title ?? "",
                        style: TextStyle(
                            color: AppColors.white,
                            fontFamily: "Mont",
                            fontSize: 12.sp))),
              ),
            ),
            Positioned(
                right: 0.0,
                top: 0.0,
                child: IconButton(
                  icon: Icon(Icons.close), // Your desired icon
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  color: AppColors.white,
                  iconSize: 16,
                )),
          ]),
        ),
        Expanded(
          child: Container(
            color: isDarkMode ? AppColors.hoverBlack : AppColors.white,
            child: ListView(
              shrinkWrap: true,
              children: widget.store!
                  .map((value) => ListTile(
                        title: Text(
                          value,
                          style: TextStyle(
                              fontFamily: "Mont",
                              fontSize: 12.sp,
                              fontWeight: value == _title
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                              color: isDarkMode
                                  ? AppColors.white
                                  : AppColors.hoverBlack),
                        ),
                        onTap: () => setState(() => {
                              Navigator.pop(context),
                              _title = value,
                              widget.callback!(value)
                            }),
                        trailing: _title == value
                            ? Icon(Icons.check,
                                color: isDarkMode
                                    ? AppColors.white
                                    : AppColors.hoverBlack)
                            : Text(""),
                      ))
                  .toList(),
            ),
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => {
        if (widget.open ?? true) {_showModalBottomSheet()}
      },
      child: Container(
        alignment: Alignment.center,
        padding: widget.padding,
        decoration: BoxDecoration(
          borderRadius: widget.borderRadius,
          color: widget.altColor ?? Colors.transparent,
        ),
        child: Row(
          children: [
            SizedBox(width: 5),
            Image.asset(
              widget.icon!,
              height: 5,
              color: AppColors.white,
            ),
            SizedBox(width: 7),
            Expanded(
                child: Container(
              child: Text(
                _title ?? "",
                style: TextStyle(
                  color: widget.altTextColor ?? Color(0xff2254D3),
                  fontSize: widget.textSize ?? 10.sp,
                  fontWeight: FontWeight.w600,
                  fontFamily: "Mont",
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ))
          ],
        ), // )),
      ),
    );
  }
}
