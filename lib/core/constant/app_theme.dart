import 'package:bio_medika_web/core/constant/app_colors.dart';
import 'package:bio_medika_web/core/constant/app_fonts.dart';
import 'package:bio_medika_web/core/helpers/get_mterial_color.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData themeEnglish = ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: AppColor.background,
    fontFamily: AppFonts.montserrat,
    textTheme: const TextTheme(),
    primarySwatch: getMaterialColor(AppColor.primary),
    colorScheme: ColorScheme.fromSeed(seedColor: AppColor.primary),
  );

  static ThemeData themeArabic = ThemeData(
    useMaterial3: true,
    fontFamily: AppFonts.cairo,
    scaffoldBackgroundColor: AppColor.background,
    primarySwatch: getMaterialColor(AppColor.primary),
    colorScheme: ColorScheme.fromSeed(seedColor: AppColor.primary),
  );
}
