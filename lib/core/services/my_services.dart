import 'package:bio_medika_web/controllers/firebase_controller.dart';
import 'package:bio_medika_web/core/constant/app_texts.dart';
 import 'package:bio_medika_web/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
 import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';

class MyAppServices extends GetxService {
  late Box<String?> _information;

  Future<MyAppServices> initialize() async {
    final appServices = MyAppServices();
    appServices._information = await Hive.openBox(AppTextsEnglish.Bio_Medika);
    return appServices;
  }

  bool appIsArabic() {
    return getValue(AppTextsEnglish.direction) == AppTextsEnglish.rtl;
  }

  Future<void> putValue(String key, String? value) async {
    await _information.put(key, value);
  }

  String getValue(String key, {String defaultValue = ''}) {
    return _information.get(key, defaultValue: defaultValue) ?? '';
  }

  Future<void> removeValue(String key) async {
    await _information.delete(key);
  }
}

Future<void> initialize() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await Hive.initFlutter();
  await Get.putAsync<MyAppServices>(() async => await MyAppServices().initialize());
  Get.put(FirebaseControllerImp());

}
