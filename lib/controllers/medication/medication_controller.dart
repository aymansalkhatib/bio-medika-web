import 'dart:io' as io;

import 'package:bio_medika_web/controllers/medication/init.dart';
import 'package:bio_medika_web/core/constant/app_colors.dart';
import 'package:bio_medika_web/core/constant/app_constant.dart';
import 'package:bio_medika_web/core/constant/app_texts.dart';
import 'package:bio_medika_web/core/data/auth/medication_data.dart';
import 'package:bio_medika_web/core/data/categories.dart';
import 'package:bio_medika_web/core/enum/medication.dart';
import 'package:bio_medika_web/core/enum/status_request_enum.dart';
import 'package:bio_medika_web/core/enum/type_pick.dart';
import 'package:bio_medika_web/core/helpers/checker_date.dart';
import 'package:bio_medika_web/core/navigation/app_routes.dart';
import 'package:bio_medika_web/core/ui/shared/snacbar_widget.dart';
import 'package:bio_medika_web/models/categories_model.dart';
import 'package:bio_medika_web/models/image_upload.dart';
import 'package:bio_medika_web/models/medication_model.dart';
import 'package:bio_medika_web/models/response_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

abstract class MedicationController extends GetxController {
  validation();
  getAllMedication();
  Future<void> pickImage(TypePick typePick);
  initController({MedicationModel? medicationModel});
  updateMedication(String id);
  deleteMedication(String id);
  createMedication();
  getAllCategories();
}

class MedicationControllerImp extends MedicationController {
  late List<(String, String, TextEditingController, FocusNode, Function(String?), List<TextInputFormatter>)>
      field;
  late StatusRequest statusRequest;
  late List<MedicationModel> listMedication;
  late List<MedicationModel> fullMedication;
  final GlobalKey<FormState> formState = GlobalKey<FormState>();
  ImageUpload? image;
  late List<CategoriesModel> listCategories;
  late MedicationData medicationData;
  CategoriesModel? categoriesModel;
  late CategoriesData categoriesData;
  @override
  void getAllMedication() async {
    ResponseData response = await medicationData.getAllMedication();
    if (response.statusRequest == StatusRequest.success) {
      listMedication = fullMedication = MedicationModel.listFromJson(response.data);
    }
    statusRequest = response.statusRequest;
    update();
    return;
  }

  search(String query) {
    if (query.length == 22 && isDateRangeFormatCorrect(query)) {
      listMedication = fullMedication.where((element) => isDateInRange(element.expiryDate, query)).toList();
    } else if (query.length == 11 && areFormatsCorrectForBeforeAfterCheck(query)) {
      listMedication =
          fullMedication.where((element) => isDateBeforeOrAfter(element.expiryDate, query)).toList();
    } else if (query.isEmpty) {
      listMedication = fullMedication;
    } else {
      listMedication = searchMedications(fullMedication, query);
    }
    update();
  }

  List<MedicationModel> searchMedications(List<MedicationModel> medications, String query) {
    query = query.toLowerCase().trim();
    return medications.where((medication) {
      String simplifiedArabicQuery = simplifyArabic(query);
      bool matchesEnglishName = medication.scientificNameEn.toLowerCase().contains(query) ||
          medication.commercialNameEn.toLowerCase().contains(query);
      bool matchesArabicName = medication.scientificNameAr.contains(simplifiedArabicQuery) ||
          medication.commercialNameAr.contains(simplifiedArabicQuery);

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

  @override
  void onInit() {
    initController();

    statusRequest = StatusRequest.loading;
    medicationData = MedicationData(Get.find());
    categoriesData = CategoriesData(Get.find());
    listMedication = [];
    fullMedication = [];
    listCategories = [];
    getAllMedication();
    getAllCategories();
    super.onInit();
  }

  @override
  bool validation() {
    if (formState.currentState!.validate()) {
      return true;
    } else {
      return false;
    }
  }

  sort(SortMedication sortMedication) {
    if (sortMedication == SortMedication.expiredData) {
      listMedication.sort((a, b) => a.expiryDate.compareTo(b.expiryDate));
    }
    if (sortMedication == SortMedication.quantity) {
      listMedication.sort((a, b) => a.quantity.compareTo(b.quantity));
    }
    if (sortMedication == SortMedication.price) {
      listMedication.sort((a, b) => a.price.compareTo(b.price));
    }
    if (sortMedication == SortMedication.delayPrice) {
      listMedication.sort((a, b) => a.dailySale.compareTo(b.dailySale));
    }
    if (sortMedication == SortMedication.normal) {
      listMedication = fullMedication;
    }
    update();
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
        final file = io.File(pickedFile.path);
        String fileName = pickedFile.name;
        image = ImageUpload(imageFile: file, image: unList, name: fileName);
        update();
      } else {}
    } catch (_) {}
  }

  @override
  updateMedication(String id) async {
    if (validation()) {
      Map<String, dynamic> data = {
        "id": id,
        if (categoriesModel != null) "category_id": categoriesModel!.id.toString(),
        "commercial_name_en": field[0].$3.text,
        "scientific_name_en": field[1].$3.text,
        "company_name_en": field[2].$3.text,
        "details_en": field[3].$3.text,
        "price": field[4].$3.text,
        "expiry_date": field[5].$3.text,
        "commercial_name_ar": field[6].$3.text,
        "scientific_name_ar": field[7].$3.text,
        "company_name_ar": field[8].$3.text,
        "details_ar": field[9].$3.text,
        "quantity": field[10].$3.text,
        "daily_sale": field[11].$3.text,
      };

      ResponseData responseData = await medicationData.updateMedication(data: data, image: image);
      statusRequest = responseData.statusRequest;

      if (responseData.statusRequest == StatusRequest.success) {
        for (int i = 0; i < listMedication.length; i++) {
          if (listMedication[i].id == id) {
            listMedication[i] = MedicationModel.fromJson(responseData.data);
            break;
          }

          for (int i = 0; i < fullMedication.length; i++) {
            if (fullMedication[i].id == id) {
              fullMedication[i] = MedicationModel.fromJson(responseData.data);
              break;
            }
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
      }
      update;
    }
  }

  @override
  deleteMedication(String id) async {
    ResponseData responseData = await medicationData.deleteMedication(id: id);
    statusRequest = responseData.statusRequest;
    if (responseData.statusRequest == StatusRequest.success) {
      listMedication.removeWhere((e) => e.id == id);
      fullMedication.removeWhere((e) => e.id == id);
      NavigationService.pop();
     
      update();
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
  createMedication() async {
    if (image == null) {
      showCustomSnackbar(
        title: AppTextsEnglish.Image_Required.tr,
        message: AppTextsEnglish.You_cant_create_a_medicine_without_an_image.tr,
        backgroundGradient: const LinearGradient(
          colors: [AppColor.redAccent, AppColor.pinkAccent],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: AppConstants.val_15,
        duration: const Duration(milliseconds: 3500),
      );
    }
    if (validation()) {
      statusRequest = StatusRequest.loading;
      update();
      Map<String, dynamic> data = {
        if (categoriesModel != null) "category_id": categoriesModel!.id.toString(),
        if (categoriesModel == null) "category_id": listCategories.first.id.toString(),
        "commercial_name_en": field[0].$3.text,
        "scientific_name_en": field[1].$3.text,
        "company_name_en": field[2].$3.text,
        "details_en": field[3].$3.text,
        "price": field[4].$3.text,
        "expiry_date": field[5].$3.text,
        "commercial_name_ar": field[6].$3.text,
        "scientific_name_ar": field[7].$3.text,
        "company_name_ar": field[8].$3.text,
        "details_ar": field[9].$3.text,
        "quantity": field[10].$3.text,
        "daily_sale": field[11].$3.text,
      };

      ResponseData responseData = await medicationData.createMedication(data: data, image: image!);
      statusRequest = StatusRequest.success;
      if (responseData.statusRequest == StatusRequest.success) {
        fullMedication.add(MedicationModel.fromJson(responseData.data));
        listMedication = fullMedication;
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
  initController({MedicationModel? medicationModel}) async {
    field = initControllerFunction(medicationModel: medicationModel);
    categoriesModel = null;
    image = null;
    update();
  }

  @override
  getAllCategories() async {
    ResponseData responseData = await categoriesData.getAllCategories();
    if (responseData.statusRequest == StatusRequest.success) {
      listCategories = CategoriesModel.listFromJson(responseData.data);
    }

    update();
  }
}
