import 'package:bio_medika_web/controllers/categories_controller.dart';
import 'package:bio_medika_web/core/constant/app_assets_lottie.dart';
import 'package:bio_medika_web/views/category/widget/categories_body.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class Categories extends StatelessWidget {
  const Categories({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(CategoriesControllerImp());
    return Scaffold(
      body: LayoutBuilder(
        builder: (buildContext, boxConstraints) {
          if (boxConstraints.maxHeight < 650 || boxConstraints.maxWidth < 1000) {
            return Lottie.asset(AppAssetsLottie.screen,
                width: 100.w, height: 100.h, repeat: true, frameRate: FrameRate(120));
          } else {
            return const CategoriesBody();
          }
        },
      ),
    );
  }
}
