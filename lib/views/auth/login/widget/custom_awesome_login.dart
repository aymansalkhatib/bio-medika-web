import 'dart:math';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:bio_medika_web/controllers/auth/appbar_controller.dart';
import 'package:bio_medika_web/core/constant/app_assets_svg.dart';
import 'package:bio_medika_web/core/constant/app_border_radius.dart';
import 'package:bio_medika_web/core/constant/app_colors.dart';
import 'package:bio_medika_web/core/constant/app_constant.dart';
import 'package:bio_medika_web/core/constant/app_fonts.dart';
import 'package:bio_medika_web/core/constant/app_texts.dart';
import 'package:bio_medika_web/core/enum/status_request_enum.dart';
import 'package:bio_medika_web/core/utils/validation.dart';
import 'package:bio_medika_web/views/auth/login/widget/custom_text_form_field_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

void awesomeDialogLogin(BuildContext context) {
  AwesomeDialog(
      context: context,
      width: 500,
      onDismissCallback: (value) {
        Get.find<AppBarControllerImp>().clearField();
      },
      animType: AnimType.scale,
      dialogType: DialogType.noHeader,
      body: GetBuilder<AppBarControllerImp>(builder: (controller) {
        return Padding(
          padding: const EdgeInsets.all(AppConstants.val_20),
          child: Form(
            key: controller.formState,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  AppTextsEnglish.Welcome_back.tr,
                  style: TextStyle(
                      fontSize: 2.sp,
                      fontFamily: AppFonts.amiri,
                      fontWeight: FontWeight.w600,
                      color: AppColor.primary),
                ),
                CustomTextFieldWithIcon(
                  
                  imagePath: AppAssetsSvg.email,
                  focusNode: controller.focusNodeEmail,
                  controllerText: controller.email,
                  hintText: AppTextsEnglish.email.tr,
                  readOnly: false,
                  validator: (value) => Validation.validateEmail(value),
                ),
                const SizedBox(height: AppConstants.val_5),
                CustomTextFieldWithIcon(
                  imagePath: AppAssetsSvg.lock,
                  focusNode: controller.focusNodePassword,
                  controllerText: controller.password,
                  hintText: AppTextsEnglish.Password.tr,
                  readOnly: false,
                  suffixIcon: true,
                  alwaysVisble: false,
                  validator: (value) => Validation.length(value, min: 8),
                  onPressed: () => controller.changeIsObscureText(),
                  isObscureText: controller.isObscureText,
                ),
                const SizedBox(height: AppConstants.val_35),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppConstants.val_120,
                  ),
                  child: controller.statusRequest == StatusRequest.loading
                      ? SpinKitThreeBounce(
                          color: AppColor.primary,
                          size: 5.h,
                          duration: const Duration(seconds: 1),
                        )
                      : InkWell(
                          borderRadius: AppBorderRadius.borderRadius_20,
                          onTap: controller.login,
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: max(1.w, AppConstants.val_15), vertical: 0.18.h),
                            height: 5.h,
                            decoration: const BoxDecoration(
                                borderRadius: AppBorderRadius.borderRadius_20,
                                gradient: LinearGradient(colors: [AppColor.primary, AppColor.primary])),
                            child: Center(
                              child: Text(
                                AppTextsEnglish.Login.tr,
                                style: TextStyle(
                                  color: AppColor.background,
                                  fontSize: 1.2.sp > AppConstants.val_11 ? 1.2.sp : AppConstants.val_11,
                                  fontFamily: AppFonts.amiri,
                                  height: 0.9,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                ),
              ],
            ),
          ),
        );
      })).show();
}
