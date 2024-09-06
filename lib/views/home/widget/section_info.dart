import 'package:bio_medika_web/core/constant/app_colors.dart';
import 'package:bio_medika_web/core/constant/app_constant.dart';
import 'package:bio_medika_web/core/constant/app_fonts.dart';
import 'package:bio_medika_web/core/constant/app_texts.dart';
import 'package:bio_medika_web/core/services/my_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CustomInfo extends StatelessWidget {
  const CustomInfo({super.key});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 30.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppTextsEnglish.Your_Online_Pharmacy.tr,
            style: TextStyle(
              color: AppColor.background,
              fontSize: 2.5.w,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 2.h),
          Padding(
            padding: EdgeInsets.only(
                left: Get.find<MyAppServices>().appIsArabic() ? 0 : AppConstants.val_6,
                right: !Get.find<MyAppServices>().appIsArabic() ? 0 : AppConstants.val_6),
            child: Text(
              AppTextsEnglish.title_Home.tr,
              style: TextStyle(
                  height: 1.6,
                  color: AppColor.background,
                  fontSize: 1.4.w,
                  fontWeight: FontWeight.w500,
                  fontFamily: AppFonts.amiri),
            ),
          )
        ],
      ),
    );
  }
}
