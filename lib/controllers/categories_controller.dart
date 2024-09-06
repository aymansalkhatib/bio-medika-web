import 'dart:io';

import 'package:bio_medika_web/core/constant/app_colors.dart';
import 'package:bio_medika_web/core/constant/app_constant.dart';
import 'package:bio_medika_web/core/constant/app_texts.dart';
import 'package:bio_medika_web/core/data/categories.dart';
import 'package:bio_medika_web/core/enum/status_request_enum.dart';
import 'package:bio_medika_web/core/enum/type_pick.dart';
import 'package:bio_medika_web/core/navigation/app_routes.dart';
import 'package:bio_medika_web/core/ui/shared/snacbar_widget.dart';
import 'package:bio_medika_web/models/categories_model.dart';
import 'package:bio_medika_web/models/image_upload.dart';
import 'package:bio_medika_web/models/response_data.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

abstract class CategoriesController extends GetxController {
  getAllCategories();
  createCategories();
  deleteCategories(int id);
  updateCategories(int id);
  bool validation();
  Future<void> pickImage(TypePick typePick);
}

class CategoriesControllerImp extends CategoriesController {
  late StatusRequest statusRequest;
  late List<CategoriesModel> listCategories;
  late List<CategoriesModel> fullCategories;
  late CategoriesData categoriesData;
  late TextEditingController nameAr, nameEn;
  late FocusNode foucusNameAr, foucusNameEn;
  ImageUpload? image;
  final GlobalKey<FormState> formState = GlobalKey<FormState>();
  @override
  bool validation() {
    if (formState.currentState!.validate()) {
      return true;
    } else {
      return false;
    }
  }

  @override
  void onInit() {
    nameAr = TextEditingController();
    nameEn = TextEditingController();

    foucusNameAr = FocusNode();
    foucusNameEn = FocusNode();
    foucusNameAr.addListener(() => update());
    foucusNameEn.addListener(() => update());
    statusRequest = StatusRequest.loading;
    listCategories = [];
    fullCategories = [];
    categoriesData = CategoriesData(Get.find());
    getAllCategories();
    super.onInit();
  }

  @override
  getAllCategories() async {
    ResponseData responseData = await categoriesData.getAllCategories();
    statusRequest = responseData.statusRequest;
    if (responseData.statusRequest == StatusRequest.success) {
      fullCategories = CategoriesModel.listFromJson(responseData.data);
      listCategories = CategoriesModel.listFromJson(responseData.data);
      update();
    }
  }

  @override
  updateCategories(int id) async {
    if (validation()) {
      Map<String, dynamic> data = {
        "name_ar": nameAr.text,
        "name_en": nameEn.text,
        "id": id.toString(),
      };
      ResponseData responseData = await categoriesData.updateAllCategories(data: data, image: image);
      if (responseData.statusRequest == StatusRequest.success) {
        for (int i = 0; i < listCategories.length; i++) {
          if (listCategories[i].id == id) {
            listCategories[i] = CategoriesModel.fromJson(responseData.data);
          }
        }
        for (int i = 0; i < fullCategories.length; i++) {
          if (fullCategories[i].id == id) {
            fullCategories[i] = CategoriesModel.fromJson(responseData.data);
          }
        }
        update();
        NavigationService.pop();
      } else {
        showCustomSnackbar(
          title: AppTextsEnglish.Error.tr,
          message: responseData.errors.toString(),
          backgroundGradient: const LinearGradient(
            colors: [AppColor.redAccent, AppColor.pinkAccent],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: AppConstants.val_15,
          duration: const Duration(milliseconds: 3500),
        ).then((value) {});
        update;
      }
    }
  }

  @override
  deleteCategories(int id) async {
    ResponseData responseData = await categoriesData.deleteAllCategories(id);
    if (responseData.statusRequest == StatusRequest.success) {
      listCategories.removeWhere((e) => e.id == id);
      fullCategories.removeWhere((e) => e.id == id);

      update();
      NavigationService.pop();
    } else {
      showCustomSnackbar(
        title: AppTextsEnglish.Error.tr,
        message: responseData.errors.toString(),
        backgroundGradient: const LinearGradient(
          colors: [AppColor.redAccent, AppColor.pinkAccent],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: AppConstants.val_15,
        duration: const Duration(milliseconds: 3500),
      ).then((value) {});
      update;
    }
  }

  @override
  createCategories() async {
    if (image != null) {
      if (validation()) {
        Map<String, dynamic> data = {"name_ar": nameAr.text, "name_en": nameEn.text};

        ResponseData responseData = await categoriesData.createAllCategories(data: data, image: image);
        if (responseData.statusRequest == StatusRequest.success) {
          listCategories.add(CategoriesModel.fromJson(responseData.data));

          fullCategories.add(CategoriesModel.fromJson(responseData.data));

          update();
          NavigationService.pop();
        } else {
          showCustomSnackbar(
            title: AppTextsEnglish.Error.tr,
            message: responseData.errors.toString(),
            backgroundGradient: const LinearGradient(
              colors: [AppColor.redAccent, AppColor.pinkAccent],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: AppConstants.val_15,
            duration: const Duration(milliseconds: 3500),
          ).then((value) {});
          update;
        }
      }
    } else {
      showCustomSnackbar(
        title: AppTextsEnglish.Image_Required.tr,
        message: AppTextsEnglish.You_cant_create_a_category_without_an_image.tr,
        backgroundGradient: const LinearGradient(
          colors: [AppColor.redAccent, AppColor.pinkAccent],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: AppConstants.val_15,
        duration: const Duration(milliseconds: 3500),
      );
    }
  }

  @override
  Future<void> pickImage(TypePick typePick) async {
    try {
      ImagePicker picker = ImagePicker();
      XFile? pickedFile;

      if (typePick == TypePick.camera) {
        pickedFile = await picker.pickImage(source: ImageSource.camera);
      } else if (typePick == TypePick.gallery) {
        pickedFile = await picker.pickImage(source: ImageSource.gallery);
      }

      if (pickedFile != null) {
        final unList = await pickedFile.readAsBytes();
        final file = File(pickedFile.path);
        String fileName = pickedFile.name;
        image = ImageUpload(imageFile: file, image: unList, name: fileName);
        update();
      } else {}
    } catch (_) {}
  }

  search(String query) {
    if (query.isEmpty) {
      listCategories = fullCategories;
    } else {
      listCategories = searchMedications(fullCategories, query);
    }
    update();
  }

  List<CategoriesModel> searchMedications(List<CategoriesModel> orders, String query) {
    query = query.toLowerCase().trim();
    return orders.where((order) {
      String simplifiedArabicQuery = simplifyArabic(query);
      bool matchesEnglishName = order.nameEn.toLowerCase().contains(query);

      bool matchesArabicName = order.nameAr.contains(simplifiedArabicQuery);

      return matchesEnglishName || matchesArabicName;
    }).toList();
  }

  List<CategoriesModel> searchCategory(List<CategoriesModel> categories, String query) {
    query = query.toLowerCase().trim();
    return categories.where((category) {
      String simplifiedArabicQuery = simplifyArabic(query);
      bool matchesEnglishName = category.nameEn.toLowerCase().contains(query);
      bool matchesArabicName = category.nameAr.contains(simplifiedArabicQuery);

      return matchesEnglishName || matchesArabicName;
    }).toList();
  }

  String simplifyArabic(String input) {
    const arabicSimplificationMap = {
      'أ': 'ا',
      'إ': 'ا',
      'آ': 'ا',
    };
    return input.split('').map((char) => arabicSimplificationMap[char] ?? char).join();
  }
}
