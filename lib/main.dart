import 'package:bio_medika_web/controllers/locale_controller.dart';
import 'package:bio_medika_web/core/constant/app_texts.dart';
import 'package:bio_medika_web/core/localization/translations/my_translation.dart';
import 'package:bio_medika_web/core/navigation/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'core/bindings/app_bindings.dart';
import 'core/services/my_services.dart';

void main() async {
  await initialize();

  runApp(const BioMedika());
}

class BioMedika extends StatelessWidget {
  const BioMedika({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final LocaleController controller = Get.put(LocaleController());

    return ScreenUtilInit(
      designSize: const Size(100, 100),
      minTextAdapt: true,
      splitScreenMode: true,
      child: GetMaterialApp(
        initialBinding: AppBindings(),
        debugShowCheckedModeBanner: false,
        title: AppTextsEnglish.Bio_Medika.tr,
        theme: controller.appTheme,
        translations: MyTranslation(),
        locale: controller.language,
        getPages: route,
      ),
    );
  }
}
