import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:get_starter_kit_2024/app/data/config/app_colors.dart';
import 'package:get_starter_kit_2024/app/data/config/app_images.dart';
import 'package:get_starter_kit_2024/app/routes/app_pages.dart';
import 'package:get_starter_kit_2024/app/ui/components/app_button.dart';
import 'package:get_starter_kit_2024/app/ui/components/app_form.dart';
import 'package:get_starter_kit_2024/app/utils/app_navigator.dart';
import 'package:get_starter_kit_2024/app/utils/app_validator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinput/pinput.dart';

import '../controllers/sign_in_controller.dart';

/// A view for the `SignIn` module.
class SignInView extends GetView<SignInController> {
  /// The default constructor for the `SignInView` class.
  const SignInView({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: AppColors.kFFFFFF,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: AppButton(
          buttonText: 'Continue',
          onPressed: () {
            if (controller.sgnInFormKey.currentState?.validate() ?? false) {
              controller.isOtpView(true);

              if (controller.otpController.text.length == 4) {
                AppNavigator.goToNamed(
                  Routes.SIGN_UP,
                  arguments: {
                    'mobile_number': controller.mobileNumberController.text,
                  },
                );
              }
            }
          },
        ),
        body: FormBuilder(
          key: controller.sgnInFormKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Center(
                child: Padding(
                  padding: REdgeInsets.symmetric(
                    horizontal: 30,
                    vertical: 10,
                  ),
                  child: const Image(
                    image: AssetImage(AppImages.appLogo),
                  ),
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    height: 40.h,
                  ),
                  Center(
                    child: Obx(
                      () => AppForm(
                        margin: REdgeInsets.symmetric(
                          horizontal: 20,
                        ),
                        name: 'mobile no',
                        title: 'Mobile Number',
                        hintText: 'Enter your mobile number',
                        titleStyle: GoogleFonts.poppins(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w600,
                          color: AppColors.k000000,
                        ),
                        onTap: () {
                          FocusScope.of(context).requestFocus();
                        },
                        suffixIcon: controller.isOtpView()
                            ? GestureDetector(
                                onTap: () {
                                  controller.timer?.cancel();
                                  controller.isOtpView(false);
                                  controller.canResendOtp(true);
                                  controller.start(15);
                                  controller.otpController.clear();
                                  controller.mobileNumberController.clear();
                                },
                                child: Icon(
                                  Icons.close,
                                  size: 20.sp,
                                  color: AppColors.k000000,
                                ),
                              )
                            : null,
                        autoFocus: true,
                        preFixIcon: Center(
                          child: Text(
                            '+91',
                            style: GoogleFonts.poppins(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                              color: AppColors.k000000,
                            ),
                          ),
                        ),
                        maxLength: 10,
                        hasBorder: true,
                        readOnly: controller.isOtpView(),
                        keyboardType: TextInputType.phone,
                        controller: controller.mobileNumberController,
                        validate: (String? value) =>
                            AppValidator.validateMobileNumber(value),
                        textStyle: GoogleFonts.poppins(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                          color: AppColors.k000000,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  AnimatedSize(
                    duration: const Duration(milliseconds: 600),
                    curve: Curves.easeInOut,
                    reverseDuration: const Duration(milliseconds: 600),
                    alignment: Alignment.topCenter,
                    child: Obx(
                      () => Visibility(
                        visible: controller.isOtpView(),
                        replacement: SizedBox(
                          width: context.width,
                        ),
                        child: Container(
                          margin: REdgeInsets.symmetric(horizontal: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                'Enter OTP',
                                style: GoogleFonts.poppins(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.k000000,
                                ),
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                              Row(
                                children: <Widget>[
                                  Pinput(
                                    controller: controller.otpController,
                                    validator: AppValidator.validateOtp,
                                    errorText: 'Invalid OTP',
                                    errorTextStyle: GoogleFonts.poppins(
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.red,
                                    ),
                                    errorPinTheme: PinTheme(
                                      height: 50.h,
                                      width: 50.w,
                                      textStyle: GoogleFonts.poppins(
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w600,
                                        color: AppColors.k000000,
                                      ),
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          width: 0.5.w,
                                          color: Colors.red,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(12).r,
                                      ),
                                    ),
                                    defaultPinTheme: PinTheme(
                                      height: 50.h,
                                      width: 50.w,
                                      textStyle: GoogleFonts.poppins(
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w600,
                                        color: AppColors.k000000,
                                      ),
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          width: 0.5.w,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(12).r,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 20.w,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      if (!controller.canResendOtp()) {
                                        return;
                                      }
                                      controller.timer?.cancel();
                                      // controller.isOtpView(false);
                                      controller.otpController.clear();
                                      // controller
                                      //   ..sendSms()
                                      //   ..startTimer();
                                    },
                                    child: Container(
                                      padding: REdgeInsets.symmetric(
                                        horizontal: 10,
                                        vertical: 7,
                                      ),
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(10).r,
                                        color: AppColors.kF0F8FF,
                                      ),
                                      child: Center(
                                        child: Text(
                                          'Resend OTP',
                                          style: GoogleFonts.poppins(
                                            fontSize: 12.sp,
                                            fontWeight: FontWeight.w600,
                                            color: controller.canResendOtp()
                                                ? AppColors.k318CE7
                                                : Colors.grey,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  AnimatedSize(
                                    duration: const Duration(milliseconds: 600),
                                    alignment: Alignment.topCenter,
                                    reverseDuration:
                                        const Duration(milliseconds: 600),
                                    curve: Curves.easeInOut,
                                    child: Obx(
                                      () => Visibility(
                                        visible: !controller.canResendOtp(),
                                        child: Container(
                                          height: 20.h,
                                          width: 30.h,
                                          decoration: const BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: AppColors.kF88379,
                                          ),
                                          child: Center(
                                            child: Text(
                                              '${controller.start()}',
                                              style: GoogleFonts.poppins(
                                                fontSize: 9.sp,
                                                fontWeight: FontWeight.w600,
                                                color: AppColors.kFFFFFF,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Obx(
                    () => SizedBox(
                      height: controller.isOtpView() ? 90.h : 55.h,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
}
