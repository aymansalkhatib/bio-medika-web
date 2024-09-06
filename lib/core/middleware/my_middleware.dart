import 'package:bio_medika_web/core/constant/app_route.dart';
import 'package:bio_medika_web/core/services/my_services.dart';
import 'package:bio_medika_web/models/admin_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyMiddleware extends GetMiddleware {
  @override
  int? get priority => 1;
  final MyAppServices myAppServices = Get.find();

  @override
  RouteSettings? redirect(String? route) {
    if (AdminModel.get().id.isEmpty) return const RouteSettings(name: AppRoutes.home);

    return null;
  }
}
