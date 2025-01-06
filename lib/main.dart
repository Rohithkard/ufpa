import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get_storage/get_storage.dart';
import 'package:upfa/color/color.dart';
import 'package:upfa/route/routes.dart';

import 'app_pages/app_pages.dart';

final box = GetStorage();
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(375, 812),
        builder: (context, child) {
          return GetMaterialApp(
            title: 'UFPA',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
                scaffoldBackgroundColor: AppColors.white,
                bottomSheetTheme: BottomSheetThemeData(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                      topRight: Radius.circular(5.sp),
                      topLeft: Radius.circular(5.sp),
                    )),
                    shadowColor: AppColors.black77,
                    backgroundColor: AppColors.white,
                    surfaceTintColor: AppColors.white,
                    elevation: 10)),
            initialRoute: AppRoutes.splash,
            getPages: AppPages.appPages,
          );
        });
  }
}
