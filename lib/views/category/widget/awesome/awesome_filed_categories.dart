import 'package:bio_medika_web/controllers/categories_controller.dart';
import 'package:bio_medika_web/core/constant/app_assets_svg.dart';
import 'package:bio_medika_web/core/constant/app_texts.dart';
import 'package:bio_medika_web/core/utils/validation.dart';

import 'package:bio_medika_web/models/categories_model.dart';
import 'package:bio_medika_web/views/auth/login/widget/custom_text_form_field_auth.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class CategoriesAwesomeFields extends GetView<CategoriesControllerImp> {
  const CategoriesAwesomeFields({
    this.categoriesModel,
    super.key,
  });
  final CategoriesModel? categoriesModel;
  @override
  Widget build(BuildContext context) {
    return GetBuilder<CategoriesControllerImp>(builder: (controller) {
      return Form(
        key: controller.formState,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(children: [
                CustomTextFieldWithIcon(
                  validator: (value) => Validation.length(value, min: 3),
                  imagePath: AppAssetsSvg.category,
                  focusNode: controller.foucusNameEn,
                  controllerText: controller.nameEn,
                  hintText: AppTextsEnglish.Name_Category_en.tr,
                  inputFormat: [
                    FilteringTextInputFormatter.allow(RegExp("[a-zA-Zs]+")),
                  ],
                ),
                CustomTextFieldWithIcon(
                  validator: (value) => Validation.length(value, min: 3),
                  imagePath: AppAssetsSvg.category,
                  focusNode: controller.foucusNameAr,
                  controllerText: controller.nameAr,
                  hintText: AppTextsEnglish.Name_Category_ar.tr,
                  inputFormat: [
                    FilteringTextInputFormatter.allow(RegExp("[\u0600-\u06FF]+")),
                  ],
                )
              ]),
            ),
          ],
        ),
      );
    });
  }
}
