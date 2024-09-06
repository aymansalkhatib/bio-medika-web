import 'package:bio_medika_web/core/constant/app_colors.dart';
import 'package:bio_medika_web/core/constant/app_constant.dart';
import 'package:bio_medika_web/core/constant/app_fonts.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomTextAppBar extends StatelessWidget {
  const CustomTextAppBar({
    super.key,
    required this.text,
    this.onTap,
    this.route,
  });
  final void Function()? onTap;
  final String text;
  final String? route;
  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: ButtonStyle(
          padding: const MaterialStatePropertyAll(EdgeInsets.symmetric(horizontal: AppConstants.val_15)),
          overlayColor: MaterialStateColor.resolveWith((states) => AppColor.blue.withOpacity(0.3))),
      onPressed: onTap,
      child: Text(
        text,
        style: TextStyle(
          decoration: Get.routing.current == route ? TextDecoration.underline : null,
          decorationColor: AppColor.pinkAccent,
          decorationThickness: 1.5,
          decorationStyle: TextDecorationStyle.solid,
          color: AppColor.background,
          fontSize: 20,
          height: 1.2,
          fontFamily: AppFonts.amiri,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
