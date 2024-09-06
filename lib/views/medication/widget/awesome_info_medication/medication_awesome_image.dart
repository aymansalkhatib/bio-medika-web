import 'package:bio_medika_web/controllers/medication/medication_controller.dart';
import 'package:bio_medika_web/core/constant/app_assets_png.dart';
import 'package:bio_medika_web/core/constant/app_colors.dart';
import 'package:bio_medika_web/core/constant/app_constant.dart';
import 'package:bio_medika_web/models/medication_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MedicationAwesomeImage extends GetView<MedicationControllerImp> {
  const MedicationAwesomeImage({
    super.key,
    this.medicationModel,
  });
  final MedicationModel? medicationModel;
  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: -70,
      left: AppConstants.val_800 / 2 - 70,
      child: CircleAvatar(
        radius: 70,
        backgroundColor: AppColor.backgroundImageDialog,
        child: GetBuilder<MedicationControllerImp>(builder: (context) {
          return Padding(
              padding:
                  EdgeInsets.all(controller.image?.image == null ? AppConstants.val_24 : AppConstants.val_5),
              child: controller.image == null
                  ? medicationModel != null
                      ? CachedNetworkImage(
                          imageUrl: medicationModel!.imageUrl,
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
                          color: AppColor.primary,
                        )
                  : ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: Image.memory(controller.image!.image)));
        }),
      ),
    );
  }
}
