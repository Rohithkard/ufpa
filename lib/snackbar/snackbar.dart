import 'package:upfa/color/color.dart';
import 'package:upfa/text_style/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class AppSnackBar extends StatelessWidget {
  final String text;

  const AppSnackBar({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15.sp, vertical: 20.sp),
      margin: EdgeInsets.all(10.sp),
      decoration: BoxDecoration(
        color: AppColors.green93,
        borderRadius: BorderRadius.circular(15.sp),
      ),
      child: Text(
        text,
        style: interSemiBold.copyWith(color: AppColors.white),
      ),
    );
  }
}
