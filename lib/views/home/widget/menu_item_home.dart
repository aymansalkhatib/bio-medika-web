import 'package:bio_medika_web/controllers/auth/appbar_controller.dart';
import 'package:bio_medika_web/core/constant/app_assets_png.dart';
import 'package:bio_medika_web/core/constant/app_colors.dart';
import 'package:bio_medika_web/core/constant/app_constant.dart';
import 'package:bio_medika_web/core/constant/app_route.dart';
import 'package:bio_medika_web/core/constant/app_texts.dart';
import 'package:bio_medika_web/views/category/widget/awesome_for_create_or_update.dart';
import 'package:bio_medika_web/views/medication/widget/awesome_info_medication/medication_awesome.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class MenuItemHome extends GetView<AppBarControllerImp> {
  const MenuItemHome({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      padding: EdgeInsets.zero,
      tooltip: AppTextsEnglish.Account.tr,
      child: CircleAvatar(
        radius: AppConstants.val_18,
        backgroundColor: AppColor.background,
        child: Padding(
          padding: const EdgeInsets.all(AppConstants.val_8),
          child: Image.asset(AppAssetsPng.logo, height: 5.5.h),
        ),
      ),
      itemBuilder: (BuildContext context) => items,
    );
  }

  List<PopupMenuEntry<String>> get items {
    return <PopupMenuEntry<String>>[
      PopupMenuItem<String>(
        padding: EdgeInsets.zero,
        child: Text(
          "    ${AppTextsEnglish.About_As.tr}",
          style: TextStyle(
            color: AppColor.primary,
            fontWeight: FontWeight.bold,
            fontSize: 0.8.sp,
          ),
        ),
      ),

      PopupMenuItem<String>(
        padding: EdgeInsets.zero,
        onTap: controller.logout,
        child: Text(
          "    ${AppTextsEnglish.Logout.tr}",
          style: TextStyle(
            color: AppColor.primary,
            fontWeight: FontWeight.bold,
            fontSize: 0.8.sp,
          ),
        ),
      ),
      if (Get.routing.current == AppRoutes.medication)
        PopupMenuItem<String>(
          padding: EdgeInsets.zero,
          onTap: awesomeDialogMedication,
          child: Text(
            "    ${AppTextsEnglish.New_medication.tr}",
            style: TextStyle(
              color: AppColor.primary,
              fontWeight: FontWeight.bold,
              fontSize: 0.8.sp,
            ),
          ),
        ),
      if (Get.routing.current == AppRoutes.categories)
        PopupMenuItem<String>(
          padding: EdgeInsets.zero,
          onTap: awesomeDialogCategories,
          child: Text(
            "    ${AppTextsEnglish.New_category.tr}",
            style: TextStyle(
              color: AppColor.primary,
              fontWeight: FontWeight.bold,
              fontSize: 0.8.sp,
            ),
          ),
        ),
      PopupMenuItem<String>(
        padding: EdgeInsets.zero,
        onTap: controller.changeLanguage,
        child: Text(
          "    ${AppTextsEnglish.Change_Language.tr}",
          style: TextStyle(
            color: AppColor.primary,
            fontWeight: FontWeight.bold,
            fontSize: 0.8.sp,
          ),
        ),
      ),
      // Add more languages as needed
    ];
  }
}
