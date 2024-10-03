// ignore_for_file: strict_raw_type, always_specify_types

import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// In App navigation manager class
class AppNavigator {
  /// Screen transition type
  static const Transition screenTransitionType = Transition.rightToLeft;

  /// Screen transition duration
  static const Duration screenTransitionDuration = Duration(milliseconds: 300);

  /// Screen transition curve
  static const Cubic screenTransitionCurve = Curves.ease;

  /// Go-to  screen
  static void goTo(
    dynamic screen, {
    dynamic arguments,
    Bindings? bindings,
    Function()? onAfterNavigation,
  }) {
    Get.to(
      screen,
      arguments: arguments,
      binding: bindings,
      transition: screenTransitionType,
      duration: screenTransitionDuration,
      curve: screenTransitionCurve,
      preventDuplicates: false,
    )?.then(
      (_) {
        onAfterNavigation?.call();
      },
    );
  }

  /// Go-to and replace screen
  static void replaceCurrentAndGoTo(
    dynamic screen, {
    dynamic arguments,
    Bindings? bindings,
  }) {
    Get.off(
      screen,
      arguments: arguments,
      binding: bindings,
      curve: screenTransitionCurve,
      transition: screenTransitionType,
      duration: screenTransitionDuration,
      preventDuplicates: false,
    );
  }

  /// Go to named screen
  static void goToNamed(
    String route, {
    dynamic arguments,
  }) {
    Get.toNamed(
      route,
      arguments: arguments,
      preventDuplicates: false,
    );
  }

  /// Go to named screen and replace current screen
  static void replaceAndGoToNamed(
    String route, {
    dynamic arguments,
  }) {
    Get.offNamed(
      route,
      arguments: arguments,
      preventDuplicates: false,
    );
  }

  /// Close all screen and go to named screen
  static void offAllAndGoToNamed(
    String route, {
    dynamic arguments,
  }) {
    Get.offAllNamed(
      route,
      arguments: arguments,
    );
  }

  /// Go to and remove until screen
  static void offAllAndGoTo(
    dynamic screen, {
    dynamic arguments,
    Bindings? bindings,
  }) {
    Get.offAll(
      screen,
      arguments: arguments,
      binding: bindings,
      transition: screenTransitionType,
      duration: screenTransitionDuration,
      curve: screenTransitionCurve,
    );
  }

  /// Go to and remove until main screen and go to new screen
  static void goUntilAndGoTo(
    dynamic nextScreen, {
    dynamic arguments,
    Bindings? bindings,
    String? untilRoute,
    Function()? onAfterNavigation,
  }) {
    if (untilRoute != null && untilRoute.isNotEmpty) {
      Get.until(
        (Route route) => route.settings.name == untilRoute,
      );
    } else {
      log(
        'WARNING, Please pass the route name to go until the specific route',
        name: 'InAppNavigator',
      );
    }
    goTo(
      nextScreen,
      arguments: arguments,
      bindings: bindings,
      onAfterNavigation: onAfterNavigation,
    );
  }

  /// Go back until home screen
  static void goBackUntilHome() {
    Get.until(
      (Route route) => route.isFirst,
    );
  }

  /// Go back
  static void goBack({
    dynamic result,
  }) {
    Get.back(
      result: result,
    );
  }
}
