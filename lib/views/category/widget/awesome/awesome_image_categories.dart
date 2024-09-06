import 'package:bio_medika_web/controllers/categories_controller.dart';
import 'package:bio_medika_web/core/constant/app_assets_png.dart';
import 'package:bio_medika_web/core/constant/app_colors.dart';
import 'package:bio_medika_web/core/constant/app_constant.dart';
import 'package:bio_medika_web/models/categories_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoriesAwesomeImage extends GetView<CategoriesControllerImp> {
  const CategoriesAwesomeImage({
    super.key,
    this.categoriesModel,
  });
  final CategoriesModel? categoriesModel;
  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: -55,
      left: AppConstants.val_450 / 2 - 55,
      child: CircleAvatar(
        radius: 55,
        backgroundColor: AppColor.backgroundImageDialog,
        child: GetBuilder<CategoriesControllerImp>(builder: (context) {
          return Padding(
              padding: EdgeInsets.all(controller.image?.image == null ? AppConstants.val_26 : AppConstants.val_4),
              child: controller.image == null
                  ? categoriesModel != null
                      ? CachedNetworkImage(
                          imageUrl: categoriesModel!.imageUrl,
                          color: AppColor.primary,
                          placeholder: (context, url) => const SizedBox(
                              child: CircleAvatar(
                            backgroundColor: AppColor.noColor,
                            child: CircularProgressIndicator(),
                          )),
                          errorWidget: (context, url, error) => const Icon(
                            Icons.error,
                            size: AppConstants.val_28,
                          ),
                        )
                      : Image.asset(
                          AppAssetsPng.addImage,
                          fit: BoxFit.cover,
                          color: AppColor.primary,
                        )
                  : ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: Image.memory(
                        controller.image!.image,
                        fit: BoxFit.fill,

                        color: AppColor.primary,
                      ),
                    ));
        }),
      ),
    );
  }
}
