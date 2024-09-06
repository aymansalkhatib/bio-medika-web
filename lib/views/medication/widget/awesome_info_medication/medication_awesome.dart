import 'package:bio_medika_web/controllers/medication/medication_controller.dart';
import 'package:bio_medika_web/core/constant/app_colors.dart';
import 'package:bio_medika_web/core/constant/app_constant.dart';
import 'package:bio_medika_web/models/medication_model.dart';
import 'package:bio_medika_web/views/medication/widget/awesome_info_medication/medication_awesome_image.dart';
import 'package:bio_medika_web/views/medication/widget/awesome_info_medication/medication_awesone_buttons.dart';
import 'package:bio_medika_web/views/medication/widget/awesome_info_medication/medication_awesone_fields.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

awesomeDialogMedication({MedicationModel? medicationModel}) async {
  await Get.find<MedicationControllerImp>().initController(medicationModel: medicationModel);
  
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
            MedicationAwesomeImage(medicationModel: medicationModel),
            SizedBox(
              width: AppConstants.val_800,
              height: 500,
              child: Padding(
                padding: const EdgeInsets.only(
                    left: AppConstants.val_35, right: AppConstants.val_35, top: AppConstants.val_50),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      MedicationAwesomeFields(medicationModel: medicationModel),
                      const SizedBox(height: AppConstants.val_35),
                      MediactionAwesomeButtons(medicationModel: medicationModel),
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
