import 'package:bio_medika_web/core/constant/app_route.dart';
import 'package:bio_medika_web/core/middleware/my_middleware.dart';
import 'package:bio_medika_web/views/category/categories.dart';
import 'package:bio_medika_web/views/home/home.dart';
import 'package:bio_medika_web/views/medication/medication.dart';
import 'package:bio_medika_web/views/order/order.dart';
import 'package:get/get.dart';

List<GetPage<dynamic>>? route = [
  GetPage(name: AppRoutes.home, page: () => const Home()),
  GetPage(name: AppRoutes.medication, page: () => const Medication(), middlewares: [MyMiddleware()]),
  GetPage(name: AppRoutes.order, page: () => const Order(), middlewares: [MyMiddleware()]),
  GetPage(name: AppRoutes.categories, page: () => const Categories(), middlewares: [MyMiddleware()]),
];

class NavigationService {
  static home({dynamic argument}) => Get.offAndToNamed(AppRoutes.home, arguments: argument);
  static medication({dynamic argument}) => Get.offAndToNamed(AppRoutes.medication, arguments: argument);
  static order({dynamic argument}) => Get.offAndToNamed(AppRoutes.order, arguments: argument);
  static categories({dynamic argument}) => Get.offAndToNamed(AppRoutes.categories, arguments: argument);

  static pop() => Get.back();
}
