import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_starter_kit_2024/app/data/config/app_colors.dart';
import 'package:google_fonts/google_fonts.dart';

/// Custom button
class AppButton extends StatelessWidget {
  /// App Button
  const AppButton({
    required this.buttonText,
    required this.onPressed,
    this.margin,
    this.color,
    this.width,
    this.height,
    this.isShowTrailing,
    this.fontStyle,
    this.leadingIcon,
    Key? key,
  }) : super(key: key);

  /// Button text
  final String buttonText;

  /// On pressed
  final void Function() onPressed;

  /// Margin
  final EdgeInsets? margin;

  /// Color
  final Color? color;

  /// Width
  final double? width;

  /// Height
  final double? height;

  /// Is show trailing
  final bool? isShowTrailing;

  /// Font style
  final TextStyle? fontStyle;

  /// Leading icon
  final IconData? leadingIcon;

  @override
  Widget build(BuildContext context) => GestureDetector(
    onTap: onPressed,
    child: Container(
      height: height ?? 55.h,
      width: width ?? Get.width.w,
      padding: REdgeInsets.only(left: 10, right: 20),
      margin: margin ??
          REdgeInsets.symmetric(
            horizontal: 20,
            vertical: 10,
          ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: color ?? AppColors.k03346E,
      ),
      child: Center(
        child: Row(
          mainAxisAlignment: isShowTrailing ?? false
              ? MainAxisAlignment.start
              : MainAxisAlignment.center,
          children: <Widget>[
            if (isShowTrailing ?? false) ...<Widget>[
              Container(
                height: 30.h,
                width: 30.w,
                decoration: const BoxDecoration(
                  color: AppColors.kFFFFFF,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Icon(
                    size: 20.h,
                    leadingIcon,
                    color: AppColors.k000000,
                  ),
                ),
              ),
              SizedBox(
                width: 20.w,
              ),
            ],
            Text(
              buttonText,
              style: fontStyle ??
                  GoogleFonts.poppins(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w500,
                    color: AppColors.kFFFFFF,
                  ),
            ),
            if (isShowTrailing ?? false) ...<Widget>[
              const Spacer(),
              SizedBox(width: 20.w),
              const Icon(
                Icons.navigate_next_outlined,
                color: AppColors.kFFFFFF,
              ),
            ],
          ],
        ),
      ),
    ),
  );
}
