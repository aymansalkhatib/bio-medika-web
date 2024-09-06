import 'package:bio_medika_web/controllers/categories_controller.dart';
import 'package:bio_medika_web/core/constant/app_colors.dart';
import 'package:bio_medika_web/core/constant/app_constant.dart';
import 'package:bio_medika_web/core/constant/app_texts.dart';
import 'package:bio_medika_web/core/enum/type_pick.dart';
import 'package:bio_medika_web/core/ui/components/animated_button.dart';
import 'package:bio_medika_web/models/categories_model.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoriesAwesomeButtons extends GetView<CategoriesControllerImp> {
  const CategoriesAwesomeButtons({
    required this.categoriesModel,
    super.key,
  });
  final CategoriesModel? categoriesModel;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Spacer(),
        MyAnimatedButton(
          pressEvent: () {
            controller.pickImage(TypePick.gallery);
          },
          icon: Icons.photo_camera_back_outlined,
          width: AppConstants.val_78,
          color: AppColor.primary,
        ),
        const Spacer(),
        MyAnimatedButton(
          pressEvent: () {
            categoriesModel == null
                ? controller.createCategories()
                : controller.updateCategories(categoriesModel!.id);
          },
          text: categoriesModel == null ? AppTextsEnglish.Create.tr : AppTextsEnglish.Update.tr,
          width: AppConstants.val_140,
          color: AppColor.primary,
        ),
        const Spacer()
      ],
    );
  }
}
