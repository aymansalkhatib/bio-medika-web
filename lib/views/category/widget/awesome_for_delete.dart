import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:bio_medika_web/controllers/categories_controller.dart';
import 'package:bio_medika_web/core/constant/app_texts.dart';
import 'package:get/get.dart';

awesomeForDelete(int id) {
  return AwesomeDialog(
      width: 450,
      title: AppTextsEnglish.Delete_Category.tr,
      animType: AnimType.scale,
      dialogType: DialogType.warning,
      desc: AppTextsEnglish.This_will_remove_all_medications_in_this_category.tr,
      context: Get.context!,
      btnCancelOnPress: () {},
      btnCancelText: AppTextsEnglish.Cancel.tr,
      btnOkText: AppTextsEnglish.Ok.tr,
      btnOkOnPress: () {
        Get.find<CategoriesControllerImp>().deleteCategories(id);
      })
    ..show();
}
