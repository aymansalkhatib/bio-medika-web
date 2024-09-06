import 'package:bio_medika_web/core/constant/app_assets_svg.dart';
import 'package:bio_medika_web/core/constant/app_border_radius.dart';
import 'package:bio_medika_web/core/constant/app_colors.dart';
import 'package:bio_medika_web/core/constant/app_constant.dart';
import 'package:bio_medika_web/core/utils/show_image_svg.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomSearchBarWidget extends StatelessWidget {
  const CustomSearchBarWidget({
    super.key,
    required this.hint,
    this.controller,
    this.focusNode,
    this.color = AppColor.primary,
    this.backgroundColor = AppColor.searchTextFormFill,
    this.textInputColor = AppColor.primary,
    this.cursorColor = AppColor.primary,
    this.onChanged,
  });

  final String hint;
  final void Function(String)? onChanged;
  final Color color;
  final Color? backgroundColor;
  final Color? textInputColor;
  final Color? cursorColor;
  final TextEditingController? controller;
  final FocusNode? focusNode;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: AppBorderRadius.borderRadius_16,
        color: backgroundColor,
      ),
      padding: EdgeInsets.only(top: 0.35.h),
      height: 5.6.h,
      width: 20.w,
      child: ClipRRect(
        borderRadius: AppBorderRadius.borderRadius_16,
        child: TextFormField(
          onChanged: onChanged,
          controller: controller,
          focusNode: focusNode,
          cursorColor: cursorColor,
          style: TextStyle(
            color: textInputColor,
            fontSize: AppConstants.val_16,
            fontWeight: FontWeight.w600,
          ),
          decoration: InputDecoration(
            contentPadding: EdgeInsets.zero.copyWith(top: 4),
            hintText: hint,
            hintStyle: TextStyle(
              fontWeight: FontWeight.w600,
              color: color,
              fontSize: AppConstants.val_16,
            ),
            prefixIcon: Container(
              padding:   EdgeInsets.only(left: AppConstants.val_8, bottom: 0.4.h),
              width: AppConstants.val_20,
              alignment: Alignment.centerLeft,
              child: ShowImageSvg(
                path: AppAssetsSvg.search,
                width: AppConstants.val_24,
                height: AppConstants.val_24,
                color: color,
              ),
            ),
            filled: true,
            fillColor: backgroundColor,
            border: const OutlineInputBorder(borderSide: BorderSide.none, gapPadding: AppConstants.val_0),
          ),
        ),
      ),
    );
  }
}
