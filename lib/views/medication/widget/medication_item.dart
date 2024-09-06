import 'package:bio_medika_web/core/constant/app_border_radius.dart';
import 'package:bio_medika_web/core/constant/app_colors.dart';
import 'package:bio_medika_web/core/constant/app_constant.dart';
import 'package:bio_medika_web/core/constant/app_texts.dart';

import 'package:bio_medika_web/models/medication_model.dart';
import 'package:bio_medika_web/views/medication/widget/awesome_info_medication/medication_awesome.dart';
import 'package:bio_medika_web/views/medication/widget/medication_text_item.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:get/get.dart';

class MedicationItem extends StatelessWidget {
  const MedicationItem({
    super.key,
    required this.medicationModel,
  });
  final MedicationModel medicationModel;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        awesomeDialogMedication(medicationModel: medicationModel);
      },
      borderRadius: AppBorderRadius.borderRadius_32,
      highlightColor: AppColor.background,
      splashColor: AppColor.primary,
      hoverColor: AppColor.black,
      child: Padding(
        padding: const EdgeInsets.all(AppConstants.val_3),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: AppConstants.val_16, horizontal: AppConstants.val_24),
          decoration: const BoxDecoration(
              borderRadius: AppBorderRadius.borderRadius_30,
              gradient: LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [
                AppColor.primary,
                AppColor.secondary,
              ])),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 1,
                child: Align(
                  alignment: Alignment.center,
                  child: CachedNetworkImage(
                    imageUrl: medicationModel.imageUrl,
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
              ),
              Expanded(
                flex: 2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: AppConstants.val_24),
                    MedicationTextItem(
                        bodyAr: medicationModel.commercialNameAr,
                        bodyEn: medicationModel.commercialNameEn,
                        title: AppTextsEnglish.Name.tr),
                    MedicationTextItem(
                        bodyAr: medicationModel.companyNameAr,
                        bodyEn: medicationModel.companyNameEn,
                        title: AppTextsEnglish.Categories.tr),
                    MedicationTextItem(
                        bodyAr: medicationModel.companyNameAr,
                        bodyEn: medicationModel.companyNameEn,
                        title: AppTextsEnglish.Company.tr),
                    MedicationTextItem(
                        bodyAr: medicationModel.quantity.toString(),
                        bodyEn: medicationModel.quantity.toString(),
                        title: AppTextsEnglish.Quantity.tr),
                    MedicationTextItem(
                        bodyAr: medicationModel.price.toString(),
                        bodyEn: medicationModel.price.toString(),
                        title: AppTextsEnglish.Price.tr),
                    MedicationTextItem(
                        bodyAr: medicationModel.expiryDate,
                        bodyEn: medicationModel.expiryDate,
                        title: AppTextsEnglish.Expiry_Date.tr),
                    MedicationTextItem(
                        bodyAr: "${medicationModel.dailySale}%",
                        bodyEn: "${medicationModel.dailySale}%",
                        title: AppTextsEnglish.Daily_Sale.tr),
                    MedicationTextItem(
                        bodyAr: "${medicationModel.daysBeforeExpiration} ${AppTextsEnglish.day.tr}",
                        bodyEn: '${medicationModel.daysBeforeExpiration} ${AppTextsEnglish.day.tr}',
                        title: AppTextsEnglish.Time_remaining.tr),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
