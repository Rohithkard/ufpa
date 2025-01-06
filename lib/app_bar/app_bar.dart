import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../app_network_image/app_network_image.dart';
import '../color/color.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Widget? bottom;
  final Widget? leading;
  final Color? backGroundColor;
  final List<Widget>? actions;

  const CustomAppBar({
    super.key,
    required this.title,
    this.actions,
    this.leading,
    this.backGroundColor,
    this.bottom,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: backGroundColor ?? AppColors.white,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.light,
      ),
      leading: leading,
      elevation: 0,
      backgroundColor: backGroundColor ?? Colors.transparent,
      bottom: bottom != null
          ? PreferredSize(
              preferredSize: const Size.fromHeight(50),
              child: bottom!,
            )
          : null,
      title: Text(title),
      actions: actions
          ?.map((action) => Container(
                padding: EdgeInsets.all(5.sp),
                child: action,
              ))
          .toList(),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(bottom == null ? 60.sp : 250.sp);
}

class AppBarWithImage extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final String? imageUrl;
  final Widget? bottom;
  final Widget? leading;
  final List<Widget>? actions;

  const AppBarWithImage({
    super.key,
    required this.title,
    required this.imageUrl,
    this.actions,
    this.leading,
    this.bottom,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: AppColors.green93,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.light,
      ),
      elevation: 0,
      leading: leading,
      automaticallyImplyLeading: true,
      backgroundColor: AppColors.white,
      flexibleSpace: Stack(
        children: [
          Positioned(
            top: 0,
            right: 0,
            left: 0,
            child: Container(
              color: AppColors.green93,
              height: 190.sp,
            ),
          ),
          AppBarPhoto(
            imageUrl: imageUrl ?? "",
          )
        ],
      ),
      title: Text(title),
      actions: actions
          ?.map((action) => Container(
                padding: EdgeInsets.all(10.sp),
                child: action,
              ))
          .toList(),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(220.sp);
}

class AppBarPhoto extends StatelessWidget {
  String imageUrl;
  AppBarPhoto({super.key, required this.imageUrl});
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: EdgeInsets.only(top: 90.sp),
          decoration: BoxDecoration(
              border: Border.all(
                color: AppColors.white,
                width: 3.sp,
              ),
              shape: BoxShape.circle),
          child: AppNetworkImage(
            imageUrl: imageUrl,
            height: 150.sp,
            width: 150.sp,
            radius: 100.sp,
            fit: BoxFit.cover,
          ),
        ),
      ],
    );
  }
}
