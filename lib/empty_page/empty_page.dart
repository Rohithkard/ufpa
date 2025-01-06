import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:upfa/assets/icons.dart';
import 'package:upfa/color/color.dart';

class EmptyPage extends StatelessWidget {
  double? height;
  double? width;
  String? text;
  EmptyPage({
    this.height,
    this.width,
    this.text,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            AppIcons.appLogo,
            height: height ?? 200.sp,
            width: width ?? 200.sp,
          ),
          Text(
            text ?? "NO data found",
            style: TextStyle(
                fontSize: 17.sp, color: AppColors.grey.withOpacity(.5)),
          )
        ],
      ),
    );
  }
}
