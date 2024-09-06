import 'dart:math';

import 'package:bio_medika_web/controllers/auth/appbar_controller.dart';
import 'package:bio_medika_web/core/constant/app_assets_png.dart';
import 'package:bio_medika_web/core/constant/app_border_radius.dart';
import 'package:bio_medika_web/core/constant/app_colors.dart';
import 'package:bio_medika_web/core/constant/app_constant.dart';
import 'package:bio_medika_web/core/constant/app_fonts.dart';
import 'package:bio_medika_web/core/constant/app_texts.dart';
import 'package:bio_medika_web/views/auth/login/widget/custom_awesome_login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CustomButtomLogin extends GetView<AppBarControllerImp> {
  const CustomButtomLogin({super.key});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => awesomeDialogLogin(context),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: max(1.w, AppConstants.val_15), vertical: 0.18.h),
        height: 4.7.h,
        decoration: const BoxDecoration(
          borderRadius: AppBorderRadius.borderRadius_20,
          image: DecorationImage(
              image: AssetImage(
                AppAssetsPng.button,
              ),
              fit: BoxFit.cover),
        ),
        child: Center(
          child: Text(
            AppTextsEnglish.Login.tr,
            style: TextStyle(
              color: AppColor.background,
              fontSize: 1.2.sp > AppConstants.val_11 ? 1.2.sp : AppConstants.val_11,
              fontFamily: AppFonts.amiri,
              height: 0.9,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
