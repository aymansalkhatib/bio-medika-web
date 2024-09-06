import 'package:bio_medika_web/controllers/medication/medication_controller.dart';
import 'package:bio_medika_web/core/constant/app_assets_svg.dart';
import 'package:bio_medika_web/core/constant/app_texts.dart';
import 'package:bio_medika_web/core/helpers/input_format.dart';
import 'package:bio_medika_web/core/utils/validation.dart';
import 'package:bio_medika_web/models/medication_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

List<(String, String, TextEditingController, FocusNode, Function(String?), List<TextInputFormatter>)>
    initControllerFunction({MedicationModel? medicationModel}) {
  final List extModel = [
    "commercial_name_en",
    "scientific_name_en",
    "company_name_en",
    "details_en",
    "price",
    "expiry_date",
    "commercial_name_ar",
    "scientific_name_ar",
    "company_name_ar",
    "details_ar",
    "quantity",
    "daily_sale",
  ];
  final field = [
    (
      AppAssetsSvg.commercial,
      AppTextsEnglish.Commercial_name_en.tr,
      TextEditingController()
        ..text = medicationModel != null ? medicationModel.toJson()[extModel[0]].toString() : "",
      FocusNode()..addListener(() => Get.find<MedicationControllerImp>().update()),
      Validation.length,
      [
        FilteringTextInputFormatter.allow(RegExp("[a-zA-Zs]+")),
      ]
    ),

    (
      AppAssetsSvg.scientific,
      AppTextsEnglish.Scientific_name_en.tr,
      TextEditingController()
        ..text = medicationModel != null ? medicationModel.toJson()[extModel[1]].toString() : "",
      FocusNode()..addListener(() => Get.find<MedicationControllerImp>().update()),
      Validation.length,
      [
        FilteringTextInputFormatter.allow(RegExp("[a-zA-Zs]+")),
      ]
    ),
    (
      AppAssetsSvg.company,
      AppTextsEnglish.Company_name_en.tr,
      TextEditingController()
        ..text = medicationModel != null ? medicationModel.toJson()[extModel[2]].toString() : "",
      FocusNode()..addListener(() => Get.find<MedicationControllerImp>().update()),
      Validation.length,
      [
        FilteringTextInputFormatter.allow(RegExp("[a-zA-Zs]+")),
      ]
    ),
    (
      AppAssetsSvg.description,
      AppTextsEnglish.Details_en.tr,
      TextEditingController()
        ..text = medicationModel != null ? medicationModel.toJson()[extModel[3]].toString() : "",
      FocusNode()..addListener(() => Get.find<MedicationControllerImp>().update()),
      Validation.length,
      [
        FilteringTextInputFormatter.allow(RegExp("[a-zA-Zs]+")),
      ]
    ),
    (
      AppAssetsSvg.price,
      AppTextsEnglish.Price.tr,
      TextEditingController()
        ..text = medicationModel != null ? medicationModel.toJson()[extModel[4]].toString() : "",
      FocusNode()..addListener(() => Get.find<MedicationControllerImp>().update()),
      (value) => Validation.length(value, min: 1),
      [
        FilteringTextInputFormatter.deny(RegExp(r'^0')),
        LengthLimitingTextInputFormatter(8),
        FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*')),
      ]
    ),
    (
      AppAssetsSvg.expired,
      AppTextsEnglish.Expiration_date.tr,
      TextEditingController()
        ..text = medicationModel != null ? medicationModel.toJson()[extModel[5]].toString() : "",
      FocusNode()..addListener(() => Get.find<MedicationControllerImp>().update()),
      Validation.dateAfterTodayValidator,
      [
        DateInputFormatter(),
        FilteringTextInputFormatter.deny(RegExp(r'^0')),
      ]
    ),
    //!

    (
      AppAssetsSvg.commercial,
      AppTextsEnglish.Commercial_name_ar.tr,
      TextEditingController()
        ..text = medicationModel != null ? medicationModel.toJson()[extModel[6]].toString() : "",
      FocusNode()..addListener(() => Get.find<MedicationControllerImp>().update()),
      Validation.length,
      [
        FilteringTextInputFormatter.allow(RegExp("[\u0600-\u06FF]+")),
      ]
    ),
    (
      AppAssetsSvg.scientific,
      AppTextsEnglish.Scientific_name_ar.tr,
      TextEditingController()
        ..text = medicationModel != null ? medicationModel.toJson()[extModel[7]].toString() : "",
      FocusNode()..addListener(() => Get.find<MedicationControllerImp>().update()),
      Validation.length,
      [
        FilteringTextInputFormatter.allow(RegExp("[\u0600-\u06FF]+")),
      ]
    ),

    (
      AppAssetsSvg.company,
      AppTextsEnglish.Company_name_ar.tr,
      TextEditingController()
        ..text = medicationModel != null ? medicationModel.toJson()[extModel[8]].toString() : "",
      FocusNode()..addListener(() => Get.find<MedicationControllerImp>().update()),
      Validation.length,
      [
        FilteringTextInputFormatter.allow(RegExp("[\u0600-\u06FF]+")),
      ]
    ),

    (
      AppAssetsSvg.description,
      AppTextsEnglish.Details_ar.tr,
      TextEditingController()
        ..text = medicationModel != null ? medicationModel.toJson()[extModel[9]].toString() : "",
      FocusNode()..addListener(() => Get.find<MedicationControllerImp>().update()),
      Validation.length,
      [
        FilteringTextInputFormatter.allow(RegExp("[\u0600-\u06FF]+")),
      ]
    ),

    (
      AppAssetsSvg.quantity,
      AppTextsEnglish.Quantity.tr,
      TextEditingController()
        ..text = medicationModel != null ? medicationModel.toJson()[extModel[10]].toString() : "",
      FocusNode()..addListener(() => Get.find<MedicationControllerImp>().update()),
      (value) => Validation.length(value, min: 1),
      [
        LengthLimitingTextInputFormatter(8),
        FilteringTextInputFormatter.deny(RegExp(r'^0')),
        FilteringTextInputFormatter.digitsOnly,
      ]
    ),
    (
      AppAssetsSvg.sale,
      AppTextsEnglish.Daily_Sale.tr,
      TextEditingController()
        ..text = medicationModel != null ? medicationModel.toJson()[extModel[11]].toString() : "",
      FocusNode()..addListener(() => Get.find<MedicationControllerImp>().update()),
      (value) => null,
      [
        MaxValueInputFormatter(maxValue: 100),
        LengthLimitingTextInputFormatter(6),
        FilteringTextInputFormatter.digitsOnly,
      ]
    ),
  ];
  return field;
}
