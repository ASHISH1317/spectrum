import 'package:get/get.dart';

import '../controllers/sign_in_controller.dart';

/// A list of dependencies to inject into the instance of [SignInController].
class SignInBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SignInController>(
      () => SignInController(),
    );
  }
}
