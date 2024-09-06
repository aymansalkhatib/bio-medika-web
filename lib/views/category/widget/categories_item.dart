import 'package:bio_medika_web/controllers/categories_controller.dart';
import 'package:bio_medika_web/core/constant/app_border_radius.dart';
import 'package:bio_medika_web/core/constant/app_colors.dart';
import 'package:bio_medika_web/core/constant/app_constant.dart';
import 'package:bio_medika_web/core/helpers/get_name.dart';
import 'package:bio_medika_web/models/categories_model.dart';
import 'package:bio_medika_web/views/category/widget/awesome_for_create_or_update.dart';
import 'package:bio_medika_web/views/category/widget/awesome_for_delete.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoriesItem extends GetView<CategoriesControllerImp> {
  const CategoriesItem({super.key, required this.categoriesModel});
  final CategoriesModel categoriesModel;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: AppBorderRadius.borderRadius_20,
      onDoubleTap: () => awesomeForDelete(categoriesModel.id),
      onTap: () => awesomeDialogCategories(categoriesModel: categoriesModel),
      hoverColor: AppColor.primary,
      child: Container(
        margin: const EdgeInsets.all(3),
        decoration: const BoxDecoration(
          borderRadius: AppBorderRadius.borderRadius_16,
          color: AppColor.secondary,
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: CachedNetworkImage(
                imageUrl: categoriesModel.imageUrl,
                color: AppColor.white,
                placeholder: (context, url) => const SizedBox(
                    child: CircleAvatar(
                  backgroundColor: AppColor.noColor,
                  child: CircularProgressIndicator(),
                )),
                errorWidget: (context, url, error) => const Icon(
                  Icons.error,
                  size: AppConstants.val_28,
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              getTextLang(
                nameEnglish: categoriesModel.nameEn,
                nameArabic: categoriesModel.nameAr,
              ),
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
