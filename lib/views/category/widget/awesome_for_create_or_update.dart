import 'package:bio_medika_web/controllers/categories_controller.dart';
import 'package:bio_medika_web/core/constant/app_colors.dart';
import 'package:bio_medika_web/core/constant/app_constant.dart';
import 'package:bio_medika_web/models/categories_model.dart';
import 'package:bio_medika_web/views/category/widget/awesome/awesome_button_categories.dart';
import 'package:bio_medika_web/views/category/widget/awesome/awesome_filed_categories.dart';
import 'package:bio_medika_web/views/category/widget/awesome/awesome_image_categories.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

awesomeDialogCategories({CategoriesModel? categoriesModel}) async {
  final controller = Get.find<CategoriesControllerImp>();
  controller.nameAr.text = categoriesModel?.nameAr ?? '';
  controller.nameEn.text = categoriesModel?.nameEn ?? '';
  controller.image = null;

  showDialog(
    context: Get.context!,
    barrierColor: AppColor.primary,
    builder: (BuildContext context) {
      return AlertDialog(
        actionsAlignment: MainAxisAlignment.end,
        alignment: Alignment.center,
        backgroundColor: AppColor.background,
        contentPadding: EdgeInsets.zero,
        content: Stack(
          clipBehavior: Clip.none,
          children: [
            CategoriesAwesomeImage(categoriesModel: categoriesModel),
            SizedBox(
              width: AppConstants.val_450,
              child: Padding(
                padding: const EdgeInsets.only(
                    left: AppConstants.val_35, right: AppConstants.val_35, top: AppConstants.val_50),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CategoriesAwesomeFields(categoriesModel: categoriesModel),
                      const SizedBox(height: AppConstants.val_35),
                      CategoriesAwesomeButtons(categoriesModel: categoriesModel),
                      const SizedBox(height: AppConstants.val_20),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    },
  );
}
