import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_starter_kit_2024/app/data/config/app_colors.dart';

///Custom button
class AppButton extends StatelessWidget {
  const AppButton({
    Key? key,
    required this.buttonText,
    required this.onPressed,
  }) : super(key: key);
  final String buttonText;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) => ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          minimumSize: Size(
            context.width,
            130.h,
          ),
          foregroundColor: AppColors.k00A4A6,
          backgroundColor: AppColors.k00A4A6,
        ),
        child: Text(
          buttonText,
          style: TextStyle(
            fontSize: 50.sp,
            fontWeight: FontWeight.w500,
            color: AppColors.kffffff,
          ),
        ),
      );
}
