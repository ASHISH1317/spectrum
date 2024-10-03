import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Response;

/// Home controller class
class HomeController extends GetxController {

  /// On init method
  @override
  void onInit() {
    pageController = PageController(
      initialPage: selectedTabIndex(),
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
    pageController?.dispose();
    super.onClose();
  }

  /// Selected tab index
  RxInt selectedTabIndex = 0.obs;

  /// Page controller
  PageController? pageController;

}
