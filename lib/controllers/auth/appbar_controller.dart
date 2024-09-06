import 'package:bio_medika_web/controllers/locale_controller.dart';
import 'package:bio_medika_web/core/constant/app_colors.dart';
import 'package:bio_medika_web/core/constant/app_constant.dart';
import 'package:bio_medika_web/core/constant/app_route.dart';
import 'package:bio_medika_web/core/constant/app_texts.dart';
import 'package:bio_medika_web/core/data/auth/login_data.dart';
import 'package:bio_medika_web/core/data/categories.dart';
import 'package:bio_medika_web/core/data/notification_data.dart';
import 'package:bio_medika_web/core/enum/status_request_enum.dart';
import 'package:bio_medika_web/core/navigation/app_routes.dart';
import 'package:bio_medika_web/core/services/my_services.dart';
import 'package:bio_medika_web/core/ui/shared/snacbar_widget.dart';
import 'package:bio_medika_web/models/response_data.dart';
import 'package:bio_medika_web/models/admin_model.dart';
import 'package:bio_medika_web/views/auth/login/widget/custom_awesome_login.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class AppBarController extends GetxController {
  validation();
  changeIsObscureText();
  login();
  clearField();
  changeLanguage();
  logout();
  goToMedicatiom();
  goToCategory();
  goToOrder();
}

class AppBarControllerImp extends AppBarController {
  late TextEditingController email;
  late TextEditingController password;
  late FocusNode focusNodeEmail;
  late FocusNode focusNodePassword;
  LoginData loginData = LoginData(Get.find());
  GlobalKey<FormState> formState = GlobalKey<FormState>();
  bool isObscureText = true;
  StatusRequest statusRequest = StatusRequest.none;
  MyAppServices myAppServices = Get.find();
  late CategoriesData categoriesData;
  @override
  validation() {
    if (formState.currentState!.validate()) {
      return true;
    } else {
      return false;
    }
  }

  @override
  void changeIsObscureText() {
    isObscureText = isObscureText ? false : true;
    update();
  }

  @override
  login() async {
    if (validation()) {
      statusRequest = StatusRequest.loading;
      update();
      Map<String, String> data = {"email": email.text, "password": password.text};

      ResponseData response = await loginData.postData(data);
      if (response.statusRequest == StatusRequest.success) {
        await AdminModel.fromJson(response.data).save();
        await NotificationData(Get.find()).upToken();
        statusRequest = response.statusRequest;

        update();
        Get.back();
        await showCustomSnackbar(
          title: AppTextsEnglish.The_operation_succeeded.tr,
          message:
              AppTextsEnglish.You_have_logged_in_to_the_site_and_you_can_now_browse_and_update_medications.tr,
          backgroundColor: AppColor.primary,
          backgroundGradient: const LinearGradient(
            colors: [Color.fromARGB(255, 91, 73, 232), AppColor.primary],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: AppConstants.val_15,
          duration: const Duration(milliseconds: 3500),
        );
      } else {
        statusRequest = response.statusRequest;

        String error;

        if (response.errors == AppTextsEnglish.E_mail_or_password_is_incorrect) {
          error = AppTextsEnglish.E_mail_or_password_is_incorrect.tr;
        } else {
          error = response.errors.toString();
        }

        await showCustomSnackbar(
          title: AppTextsEnglish.Error.tr,
          message: error,
          backgroundColor: Colors.redAccent,
          backgroundGradient: const LinearGradient(
            colors: [Colors.redAccent, Colors.pinkAccent],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: AppConstants.val_15,
          duration: const Duration(milliseconds: 2500),
        );
        update();
      }
    }
  }

  @override
  void onInit() {
    email = TextEditingController()..text = "ayman@test.com";
    password = TextEditingController()..text = 'Ayman123';
    focusNodeEmail = FocusNode();
    focusNodePassword = FocusNode();
    categoriesData = CategoriesData(Get.find());
    focusNodeEmail.addListener(() => update());
    focusNodePassword.addListener(() => update());
    super.onInit();
  }

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    focusNodeEmail.dispose();
    focusNodePassword.dispose();
    super.dispose();
  }

  @override
  clearField() async {
    await Future.delayed(const Duration(seconds: 1));
    password.clear();
    email.clear();
  }

  @override
  logout() {
    AdminModel.clean();
    NavigationService.home();
    update();
  }

  @override
  changeLanguage() {
    Get.find<LocaleController>()
        .changeLanguage(Get.find<MyAppServices>().appIsArabic() ? AppTextsEnglish.en : AppTextsEnglish.ar);

    update();
  }

  @override
  goToCategory() {
    if (Get.routing.current == AppRoutes.categories) return;

    AdminModel.get().id.isEmpty ? awesomeDialogLogin(Get.context!) : NavigationService.categories();
  }

  @override
  goToMedicatiom() {
    if (Get.routing.current == AppRoutes.medication) return;

    AdminModel.get().id.isEmpty ? awesomeDialogLogin(Get.context!) : NavigationService.medication();
  }

  @override
  goToOrder() {
    if (Get.routing.current == AppRoutes.order) return;
    AdminModel.get().id.isEmpty ? awesomeDialogLogin(Get.context!) : NavigationService.order();
  }
}
