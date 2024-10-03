import 'package:get/get.dart';

import '../controllers/sign_up_controller.dart';

/// A list of dependencies to inject into the instance of [SignUpController].
class SignUpBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SignUpController>(
      () => SignUpController(),
    );
  }
}
