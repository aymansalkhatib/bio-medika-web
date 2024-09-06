import 'package:bio_medika_web/core/constant/app_assets_lottie.dart';
import 'package:bio_medika_web/core/constant/app_colors.dart';
 import 'package:bio_medika_web/views/home/widget/background_image.dart';
import 'package:bio_medika_web/views/home/widget/custom_appbar_home.dart';
import 'package:bio_medika_web/views/home/widget/section_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

class Home extends StatelessWidget {
  const Home({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.background,
      body: LayoutBuilder(
        builder: (buildContext, boxConstraints) {
          if (boxConstraints.maxHeight < 650 || boxConstraints.maxWidth < 1000) {
            return Lottie.asset(AppAssetsLottie.screen,
                width: 100.w, height: 100.h, repeat: true, frameRate: FrameRate(120));
          } else {
            return Stack(
              children: [
                const BackgroundImageHome(),
                Positioned(top: 1.h, left: 0, child: const CustomAppBarHome()),
                Positioned(top: 40.h, left: 10.w, child: const CustomInfo()),
              ],
            );
          }
        },
      ),
    );
  }
}
