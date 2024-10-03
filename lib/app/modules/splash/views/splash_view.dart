import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get_starter_kit_2024/app/data/config/app_colors.dart';
import 'package:get_starter_kit_2024/app/data/config/app_images.dart';

import '../controllers/splash_controller.dart';

/// Splash view
class SplashView extends GetView<SplashController> {
  /// Splash view constructor
  const SplashView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: AppColors.kFFFFFF,
    body: GetBuilder<SplashController>(
      init: SplashController(),
      builder: (SplashController controller) => Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                AppImages.appLogo,
                width: controller.animation.value * 200,
                height: controller.animation.value * 200,
              ),
            ],
          ),
        ],
      ),
    ),
  );
}
