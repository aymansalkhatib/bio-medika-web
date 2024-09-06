import 'package:bio_medika_web/controllers/medication/medication_controller.dart';
import 'package:bio_medika_web/core/constant/app_constant.dart';
import 'package:bio_medika_web/core/constant/app_texts.dart';
import 'package:bio_medika_web/core/helpers/get_name.dart';
import 'package:bio_medika_web/core/services/my_services.dart';
import 'package:bio_medika_web/models/categories_model.dart';
import 'package:bio_medika_web/models/medication_model.dart';
import 'package:bio_medika_web/views/auth/login/widget/custom_text_form_field_auth.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MedicationAwesomeFields extends StatelessWidget {
  const MedicationAwesomeFields({
    this.medicationModel,
    super.key,
  });
  final MedicationModel? medicationModel;
  @override
  Widget build(BuildContext context) {
    return GetBuilder<MedicationControllerImp>(builder: (controller) {
      List<String> item = List<String>.from(
          controller.listCategories.map((e) => getTextLang(nameEnglish: e.nameEn, nameArabic: e.nameAr)));
      CategoriesModel? categoriesModel;
      if (medicationModel != null) {
        for (int i = 0; i < controller.listCategories.length; i++) {
          if (controller.listCategories[i].id.toString() == medicationModel!.categoryId) {
            categoriesModel = controller.listCategories[i];
            break;
          }
        }
      }
      return Form(
        key: controller.formState,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: items(controller, item, categoriesModel),
        ),
      );
    });
  }

  List<Widget> items(
      MedicationControllerImp controller, List<String> item, CategoriesModel? categoriesModel) {
    List<Widget> itemWidget = [
      Directionality(
        textDirection: TextDirection.ltr,
        child: Expanded(
          child: Column(children: [
            for (int i = 0; i < controller.field.length / 2; i++)
              CustomTextFieldWithIcon(
                inputFormat: controller.field[i].$6,
                imagePath: controller.field[i].$1,
                focusNode: controller.field[i].$4,
                controllerText: controller.field[i].$3,
                hintText: controller.field[i].$2,
                validator: (value) => controller.field[i].$5(value),
              ),
            SizedBox(
                height: 40,
                child: Row(
                  children: [
                    const Icon(
                      Icons.category_outlined,
                      weight: 0.5,
                    ),
                    const SizedBox(width: AppConstants.val_8),
                    Expanded(
                      child: DropdownSearch<String>(
                        popupProps: const PopupProps.menu(
                          showSearchBox: true,
                          showSelectedItems: true,
                        ),
                        items: item,
                        dropdownDecoratorProps: DropDownDecoratorProps(
                          dropdownSearchDecoration: InputDecoration(
                            // labelText: "Choose Category",
                            hintText: AppTextsEnglish.Choose_Category.tr,
                          ),
                        ),
                        onChanged: (value) {
                          for (int i = 0; i < controller.listCategories.length; i++) {
                            if (getTextLang(
                                    nameEnglish: controller.listCategories[i].nameEn,
                                    nameArabic: controller.listCategories[i].nameAr) ==
                                value) {
                              controller.categoriesModel = controller.listCategories[i];
                              break;
                            }
                          }
                        },
                        selectedItem: categoriesModel != null
                            ? getTextLang(
                                nameEnglish: categoriesModel.nameEn, nameArabic: categoriesModel.nameAr)
                            : item.isNotEmpty
                                ? item.first
                                : null,
                      ),
                    ),
                  ],
                )),
          ]),
        ),
      ),
      Container(
        padding: const EdgeInsets.only(
            left: AppConstants.val_60, right: AppConstants.val_60, top: AppConstants.val_40),
        height: AppConstants.val_300 + AppConstants.val_20,
        child: const VerticalDivider(
          width: 2,
        ),
      ),
      Expanded(
        child: Column(
          children: [
            for (int i = controller.field.length ~/ 2; i < controller.field.length; i++)
              Directionality(
                textDirection: TextDirection.rtl,
                child: CustomTextFieldWithIcon(
                  validator: (value) => controller.field[i].$5(value),
                  inputFormat: controller.field[i].$6,
                  textDirection: TextDirection.rtl,
                  imagePath: controller.field[i].$1,
                  focusNode: controller.field[i].$4,
                  controllerText: controller.field[i].$3,
                  hintText: controller.field[i].$2,
                ),
              )
          ],
        ),
      ),
    ];
    if (Get.find<MyAppServices>().appIsArabic()) {
      return itemWidget.reversed.toList();
    }

    return itemWidget;
  }
}
