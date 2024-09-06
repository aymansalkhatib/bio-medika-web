import 'package:bio_medika_web/controllers/auth/appbar_controller.dart';
import 'package:bio_medika_web/core/services/crud.dart';
import 'package:get/get.dart';

class AppBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(Crud());
    Get.put(AppBarControllerImp());




    
  }

  

}
