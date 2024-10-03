// ignore_for_file: always_specify_types

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_starter_kit_2024/app/data/local/user_provider.dart';
import 'package:get_starter_kit_2024/app/routes/app_pages.dart';

/// Splash controller class
class SplashController extends GetxController
    with GetSingleTickerProviderStateMixin {
  /// On init method
  @override
  void onInit() {
    splashAnimation();

    UserProvider.loadUser();

    Future.delayed(
      const Duration(seconds: 3),
      () {
        UserProvider.isLoggedIn
            ? Get.offAllNamed(Routes.HOME)
            : Get.offAllNamed(Routes.SIGN_IN);
      },
    );
    super.onInit();
  }

  /// On ready method
  @override
  void onReady() {
    super.onReady();
  }

  /// On close method
  @override
  void onClose() {
    super.onClose();
  }

  /// Animation controller
  late AnimationController animationController;

  /// Animation
  late Animation<double> animation;

  /// Splash animation initialization
  void splashAnimation() {
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    animation = CurvedAnimation(
      parent: animationController,
      curve: Curves.easeOut,
    ).obs.value;
    animation.addListener(
      () => update(),
    );
    animationController.forward();
  }
}
