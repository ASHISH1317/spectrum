import 'package:get/get.dart';

import '../controllers/home_controller.dart';

/// Binding for Home Controller and View
class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(
      () => HomeController(),
    );
  }
}
