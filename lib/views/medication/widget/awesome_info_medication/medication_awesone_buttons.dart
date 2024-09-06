import 'package:bio_medika_web/controllers/medication/medication_controller.dart';
import 'package:bio_medika_web/core/constant/app_colors.dart';
import 'package:bio_medika_web/core/constant/app_constant.dart';
import 'package:bio_medika_web/core/constant/app_texts.dart';
import 'package:bio_medika_web/core/enum/type_pick.dart';
import 'package:bio_medika_web/core/ui/components/animated_button.dart';
import 'package:bio_medika_web/models/medication_model.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MediactionAwesomeButtons extends GetView<MedicationControllerImp> {
  const MediactionAwesomeButtons({
    required this.medicationModel,
    super.key,
  });
  final MedicationModel? medicationModel;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        MyAnimatedButton(
          pressEvent: () {
            controller.pickImage(TypePick.gallery);
          },
          icon: Icons.photo_camera_back_outlined,
          width: AppConstants.val_78,
          color: AppColor.primary,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppConstants.val_40),
          child: MyAnimatedButton(
            pressEvent: () {
              medicationModel == null
                  ? controller.createMedication()
                  : controller.updateMedication(medicationModel!.id);
            },
            text: medicationModel == null ? AppTextsEnglish.Create.tr : AppTextsEnglish.Update.tr,
            width: AppConstants.val_200,
            color: AppColor.primary,
          ),
        ),
        if (medicationModel != null)
          MyAnimatedButton(
            pressEvent: () {
              controller.deleteMedication(medicationModel!.id);
            },
            icon: Icons.delete_outline_outlined,
            width: AppConstants.val_78,
            color: AppColor.primary,
          ),
      ],
    );
  }
}
