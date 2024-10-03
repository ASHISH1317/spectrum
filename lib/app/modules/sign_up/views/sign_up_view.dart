import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:get_starter_kit_2024/app/data/config/app_colors.dart';
import 'package:get_starter_kit_2024/app/data/config/app_images.dart';
import 'package:get_starter_kit_2024/app/data/local/user_provider.dart';
import 'package:get_starter_kit_2024/app/data/models/user_entity.dart';
import 'package:get_starter_kit_2024/app/routes/app_pages.dart';
import 'package:get_starter_kit_2024/app/ui/components/app_button.dart';
import 'package:get_starter_kit_2024/app/ui/components/app_form.dart';
import 'package:get_starter_kit_2024/app/utils/app_navigator.dart';
import 'package:get_starter_kit_2024/app/utils/app_validator.dart';
import 'package:get_starter_kit_2024/app/utils/sliver_app_bar_delegate.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controllers/sign_up_controller.dart';

/// A view for the `SignUp` module.
class SignUpView extends GetView<SignUpController> {
  /// The default constructor for the `SignUpView` class.
  const SignUpView({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: AppColors.kFFFFFF,
        bottomNavigationBar: AppButton(
          buttonText: 'Continue',
          onPressed: () {
            if (controller.signUpFromKey.currentState?.validate() ?? false) {
              UserProvider.onLogin(
                user: UserEntity(
                  email: controller.emailController.text,
                  mobileNumber: controller.mobileNumberController.text,
                  lastName: controller.lastNameController.text,
                  firstName: controller.firstNameController.text,
                  middleName: controller.middleNameController.text,
                ),
                userAuthToken: '',
              );

              AppNavigator.offAllAndGoToNamed(
                Routes.HOME,
              );
            }
          },
        ),
        body: Padding(
          padding: REdgeInsets.symmetric(horizontal: 20),
          child: FormBuilder(
            key: controller.signUpFromKey,
            child: CustomScrollView(
              physics: const ClampingScrollPhysics(),
              slivers: <Widget>[
                SliverToBoxAdapter(
                  child: SizedBox(
                    height: 50.h,
                  ),
                ),
                SliverToBoxAdapter(
                  child: Container(
                    height: 100.h,
                    child: const ClipRRect(
                      child: Center(
                        child: Image(
                          fit: BoxFit.cover,
                          image: AssetImage(AppImages.appLogo),
                        ),
                      ),
                    ),
                  ),
                ),
                SliverPersistentHeader(
                  pinned: true,
                  delegate: SliverAppBarDelegate(
                    maxHeight: 80.h,
                    minHeight: 80.h,
                    child: Container(
                      color: AppColors.kFFFFFF,
                      margin: REdgeInsets.symmetric(horizontal: 30),
                      child: Center(
                        child: Text(
                          'Please sign up to continue',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.poppins(
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w300,
                            color: AppColors.k318CE7,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SliverList(
                  delegate: SliverChildListDelegate(
                    <Widget>[
                      SizedBox(
                        height: 20.h,
                      ),
                      AppForm(
                        name: 'mobile',
                        title: 'Mobile Number',
                        hintText: 'Please enter mobile number',
                        hasBorder: true,
                        isRequired: true,
                        maxLength: 10,
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
                        controller: controller.mobileNumberController,
                        keyboardType: TextInputType.phone,
                        validate: (String? value) =>
                            AppValidator.validateMobileNumber(value),
                        textStyle: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: AppColors.k000000,
                        ),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      AppForm(
                        name: 'email',
                        title: 'Email',
                        hintText: 'Please enter email',
                        controller: controller.emailController,
                        hasBorder: true,
                        isRequired: true,
                        validate: (String? value) =>
                            AppValidator.validateEmail(value),
                        textStyle: GoogleFonts.poppins(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                          color: AppColors.k000000,
                        ),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      AppForm(
                        name: 'first name',
                        title: 'First Name',
                        hintText: 'please enter first name',
                        controller: controller.firstNameController,
                        hasBorder: true,
                        isRequired: true,
                        validate: (String? value) =>
                            AppValidator.validateFirstName(value),
                        textStyle: GoogleFonts.poppins(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                          color: AppColors.k000000,
                        ),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      AppForm(
                        name: 'middle name',
                        title: 'Middle Name',
                        hintText: 'please enter middle name',
                        controller: controller.middleNameController,
                        hasBorder: true,
                        isRequired: true,
                        validate: (String? value) =>
                            AppValidator.validateMiddleName(value),
                        textStyle: GoogleFonts.poppins(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                          color: AppColors.k000000,
                        ),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      AppForm(
                        name: 'last name',
                        title: 'Last Name',
                        hintText: 'Please last name enter name',
                        controller: controller.lastNameController,
                        hasBorder: true,
                        isRequired: true,
                        validate: (String? value) =>
                            AppValidator.validateLastName(value),
                        textStyle: GoogleFonts.poppins(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                          color: AppColors.k000000,
                        ),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      SizedBox(
                        height: 100.h,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
}
