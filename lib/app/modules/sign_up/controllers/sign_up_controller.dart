import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';

/// A controller for the `SignUp` module.
class SignUpController extends GetxController {
  /// On initialization of the controller.
  @override
  void onInit() {
    if (Get.arguments != null) {
      if (Get.arguments['mobile_number'] != null) {
        mobileNumber
          ..value = Get.arguments['mobile_number'] as String
          ..refresh();
        mobileNumberController.text = Get.arguments['mobile_number'] as String;
      }
    }
    super.onInit();
  }

  /// On the first rendering of the screen.
  @override
  void onReady() {
    super.onReady();
  }

  /// On removal of the controller.
  @override
  void onClose() {
    super.onClose();
  }

  /// Form builder key
  final GlobalKey<FormBuilderState> signUpFromKey =
      GlobalKey<FormBuilderState>();

  /// Mobile number
  final RxString mobileNumber = ''.obs;

  /// Name controller
  final TextEditingController firstNameController = TextEditingController();

  /// Middle name controller
  final TextEditingController middleNameController = TextEditingController();

  /// Last name controller
  final TextEditingController lastNameController = TextEditingController();

  /// Email controller
  final TextEditingController emailController = TextEditingController();

  /// Cpr number controller
  final TextEditingController mobileNumberController = TextEditingController();
}
