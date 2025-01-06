import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:upfa/app_buttons/app_buttons.dart';
import 'package:upfa/color/color.dart';
import 'package:upfa/route/routes.dart';
import 'package:upfa/text_style/text_style.dart';

class ErrorPage extends StatelessWidget {
  const ErrorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "OOPS something went wrong",
          style: interBold.copyWith(fontSize: 20.sp, color: AppColors.black77),
        ),
        SizedBox(
          height: 50.sp,
        ),
        GreenButton(
          text: "Back To Home",
          onTap: () => Get.offAllNamed(AppRoutes.landingPage),
        )
      ],
    ));
  }
}
