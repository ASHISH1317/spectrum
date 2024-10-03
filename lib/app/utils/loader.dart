// ignore_for_file: depend_on_referenced_packages, always_specify_types

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_starter_kit_2024/app/data/config/app_colors.dart';
import 'package:get_starter_kit_2024/app/data/config/app_images.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

/// Loader
class Loader {
  /// Is Open Dialog
  static bool isOpen = false;

  /// Is More Than 20 Sec
  static RxBool isTakingMoreThan20Sec = false.obs;

  /// Show Dialog
  static void show({
    String? msg,
  }) {
    FocusScope.of(Get.context!).unfocus();

    isTakingMoreThan20Sec(false);
    isTakingMoreThan20Sec.refresh();

    EasyLoading.instance
      ..loadingStyle = EasyLoadingStyle.custom
      ..backgroundColor = Colors.transparent
      ..indicatorColor = Colors.transparent
      ..textColor = Colors.transparent
      ..boxShadow = [];

    if (!isOpen) {
      isOpen = true;

      if ((msg?.isNotEmpty ?? false) && msg != null) {
        Future.delayed(
          const Duration(seconds: 20),
          () {
            isTakingMoreThan20Sec(true);
            isTakingMoreThan20Sec.refresh();
          },
        );
      }
      EasyLoading.show(
        indicator: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Center(
              child: Lottie.asset(
                AppImages.loader,
                width: 90.w,
                height: 90.h,
                fit: BoxFit.cover,
              ),
            ),
            if ((msg?.isNotEmpty ?? false) && msg != null) ...[
              SizedBox(
                height: 5.h,
              ),
              Center(
                child: Obx(
                  () => Text(
                    isTakingMoreThan20Sec()
                        ? 'Hang in there... This could take some time.'
                        : msg,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      color: AppColors.k0098FF,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ],
          ],
        ),
        dismissOnTap: false,
        maskType: EasyLoadingMaskType.black,
      );
    }
  }

  /// Dismiss Dialog
  static void dismiss() {
    if (isOpen) {
      isOpen = false;
      EasyLoading.dismiss();
    }
  }
}
