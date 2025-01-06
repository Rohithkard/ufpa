import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:upfa/assets/icons.dart';
import 'package:upfa/splash/splash_controller.dart';
import 'package:get/get.dart';
class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(SplashController());
    return  Scaffold(body: Center(child: Image.asset(AppIcons.appLogo,height: 200.sp,width: 220.sp,)));
  }
}
