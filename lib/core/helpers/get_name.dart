import 'package:bio_medika_web/core/services/my_services.dart';
import 'package:get/get.dart';

String getTextLang({required String nameEnglish, required String nameArabic}) {
  return Get.find<MyAppServices>().appIsArabic() ? nameArabic : nameEnglish;
}
