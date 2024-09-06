import 'package:auto_size_text/auto_size_text.dart';
import 'package:bio_medika_web/core/constant/app_fonts.dart';
import 'package:bio_medika_web/core/helpers/get_name.dart';
import 'package:bio_medika_web/core/services/my_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
 
class MedicationTextItem extends StatelessWidget {
  const MedicationTextItem({
    super.key,
    required this.bodyAr,
    required this.bodyEn,
    required this.title,
  });

  final String bodyAr, bodyEn, title;

  @override
  Widget build(BuildContext context) {
    bool isArabic = Get.find<MyAppServices>().appIsArabic();
    return AutoSizeText(
      maxLines: 1,
      maxFontSize: 30,
      minFontSize: 16,
      '$title: ${getTextLang(nameEnglish: bodyEn, nameArabic: bodyAr)}',
      style: TextStyle(
          color: Colors.white,
          fontFamily: isArabic ? AppFonts.cairo : AppFonts.amiri,
          fontWeight: FontWeight.w500),
    );
  }
}
