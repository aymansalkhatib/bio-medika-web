import 'dart:convert';

import 'package:bio_medika_web/controllers/order_controller.dart';
import 'package:bio_medika_web/core/constant/app_route.dart';
import 'package:bio_medika_web/core/helpers/get_name.dart';
import 'package:bio_medika_web/models/order_model.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class FirebaseController extends GetxController {
  void init();
}

class FirebaseControllerImp extends FirebaseController {
  handelNotificaton(Map<String, dynamic> message) {
    if (Get.routing.current == AppRoutes.order) {
      OrderModel orderModel = OrderModel.fromJson(message['order']);
      final controller = Get.find<OrderControllerImp>();
      controller.listOrder.add(orderModel);
      controller.fullOrder.add(orderModel);
      controller.update();
    }

    Get.snackbar(
        getTextLang(
            nameEnglish: '${message['notification']['title_en']}',
            nameArabic: '${message['notification']['title_ar']}'),
        getTextLang(
            nameEnglish: '${message['notification']['body_en']}',
            nameArabic: '${message['notification']['body_ar']}'),
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.blue,
        colorText: Colors.white,
        borderRadius: 20,
        margin: const EdgeInsets.all(10),
        duration: const Duration(seconds: 10),
        maxWidth: 650);

    if (Get.isRegistered<OrderControllerImp>()) {
      final controller = Get.find<OrderControllerImp>();
      // controller.fullOrder.add(value);
      // controller.listOrder.add(value);
      controller.update();
    }
  }

  requestPermissionNotification() async {
    await FirebaseMessaging.instance.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
  }

  @override
  void init() {
    requestPermissionNotification();
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      handelNotificaton(json.decode(message.data['info'].toString())); //
    });
  }

  @override
  void onInit() {
    init();
    super.onInit();
  }
}
