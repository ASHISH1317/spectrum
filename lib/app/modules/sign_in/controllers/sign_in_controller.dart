import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:get_starter_kit_2024/app/data/config/logger.dart';
import 'package:get_starter_kit_2024/app/routes/app_pages.dart';
import 'package:get_starter_kit_2024/app/ui/components/app_snackbar.dart';
import 'package:intl/intl.dart';

/// A controller for the `SignIn` module.
class SignInController extends GetxController {
  /// On initialization of the controller.
  @override
  void onInit() {
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

  /// Sign in form key
  final GlobalKey<FormBuilderState> sgnInFormKey =
      GlobalKey<FormBuilderState>();

  /// Otp validation key
  final GlobalKey<FormBuilderState> otpValidationKey =
      GlobalKey<FormBuilderState>();

  /// Otp controller
  final TextEditingController otpController = TextEditingController();

  /// Cpr number controller
  final TextEditingController mobileNumberController = TextEditingController();

  /// Is otp view
  final RxBool isOtpView = false.obs;

  /// Firebase auth
  final FirebaseAuth auth = FirebaseAuth.instance;

  /// Resend token
  final RxString resendToken = ''.obs;

  /// Verification id
  final RxString verificationId = ''.obs;

  ///  Sign in form format date
  String formatDate(DateTime date) {
    final DateFormat formatter = DateFormat('dd-MM-yyyy');
    return formatter.format(date);
  }

  /// Timer
  Timer? timer;

  /// Start timer
  RxInt start = 15.obs;

  /// Can resend otp
  RxBool canResendOtp = true.obs;

  /// Start timer
  void startTimer() {
    canResendOtp.value = false;
    const Duration oneSec = Duration(seconds: 1);
    timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (start() == 0) {
          timer.cancel();
          canResendOtp
            ..value = true
            ..refresh();
          start.value = 15;
        } else {
          start.value--;
          start.refresh();
        }
      },
    );
  }

  /// Send otp
  Future<void> sendOTP({
    required String phoneNumber,
  }) async {
    await auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      timeout: const Duration(seconds: 60),
      verificationCompleted: (PhoneAuthCredential credential) async {
        await auth.signInWithCredential(credential);
        await Get.offAllNamed(Routes.HOME);
      },
      verificationFailed: (FirebaseAuthException e) {
        if (e.code == 'invalid-phone-number') {
          appSnackbar(
            message: 'The provided phone number is not valid.',
            snackbarState: SnackbarState.danger,
          );
          logE('The provided phone number is not valid.');
          return;
        }

        logE('Failed to verify phone number: $e');
        appSnackbar(
          message: 'Failed to verify phone number.',
          snackbarState: SnackbarState.danger,
        );
      },
      codeSent: (String verificationId, int? resendToken) {
        isOtpView(true);
        this.verificationId(verificationId);
        this.resendToken(resendToken.toString());
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        logI('Auto retrieval time out');
        this.verificationId(verificationId);
      },
    );
  }

  /// Otp Verification Controller
  Future<void> verifyOTP({
    required String otp,
  }) async {
    final PhoneAuthCredential credential = PhoneAuthProvider.credential(
      verificationId: verificationId(),
      smsCode: otp,
    );

    try {
      await auth.signInWithCredential(credential);
      await Get.offAllNamed(Routes.HOME);
    } on Exception catch (e, t) {
      logE('Failed to verify OTP: $e ====== $t');
    }
  }
}
