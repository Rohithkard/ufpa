import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:upfa/text_style/text_style.dart';

import '../color/color.dart';

class WhiteButton extends StatelessWidget {
  final String text;
  final double? height;
  final double? width;
  final double? fontSize;
  final double? radius;
  final void Function()? onTap;
  final bool? isLoading;
  const WhiteButton({
    super.key,
    required this.text,
    this.height,
    this.fontSize,
    this.onTap,
    this.width,
    this.radius,
    this.isLoading,
  });
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: (isLoading ?? false) ? null : onTap,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 250),
            padding: EdgeInsets.all(5.sp),
            height: (isLoading ?? false) ? 60.sp : height ?? 50.sp,
            width: (isLoading ?? false) ? 60.sp : width ?? 343.sp,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                    (isLoading ?? false) ? 55.sp : radius ?? 55.sp),
                color: AppColors.white),
            child: Center(
              child: isLoading ?? false
                  ? CircularProgressIndicator(
                      color: AppColors.green93,
                    )
                  : Text(
                      text,
                      style: interSemiBold.copyWith(
                          fontSize: fontSize ?? 16.sp,
                          color: AppColors.green93),
                    ),
            ),
          ),
        ),
      ],
    );
  }
}

class GreenButton extends StatelessWidget {
  final String text;
  final double? height;
  final double? width;
  final double? fontSize;
  final double? radius;
  final void Function()? onTap;
  final bool? isLoading;
  const GreenButton({
    super.key,
    required this.text,
    this.height,
    this.fontSize,
    this.onTap,
    this.width,
    this.radius,
    this.isLoading,
  });
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (isLoading ?? false) ? null : onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        padding: EdgeInsets.all(5.sp),
        height: (isLoading ?? false) ? 60.sp : height ?? 50.sp,
        width: (isLoading ?? false) ? 60.sp : width ?? 300.sp,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(
                (isLoading ?? false) ? 55.sp : radius ?? 55.sp),
            gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [AppColors.green93, AppColors.green47])),
        child: Center(
          child: isLoading ?? false
              ? CircularProgressIndicator(
                  color: AppColors.white,
                )
              : Text(
                  text,
                  style: interSemiBold.copyWith(
                      fontSize: fontSize ?? 16.sp, color: AppColors.white),
                ),
        ),
      ),
    );
  }
}

class GreyButton extends StatelessWidget {
  final String text;
  final double? height;
  final double? width;
  final double? fontSize;
  final double? radius;
  final EdgeInsetsGeometry? padding;
  final void Function()? onTap;
  final bool? isLoading;
  const GreyButton({
    super.key,
    required this.text,
    this.height,
    this.fontSize,
    this.padding,
    this.onTap,
    this.width,
    this.radius,
    this.isLoading,
  });
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (isLoading ?? false) ? null : onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        padding: padding ?? EdgeInsets.all(5.sp),
        height: (isLoading ?? false) ? 60.sp : height ?? 50.sp,
        width: (isLoading ?? false) ? 60.sp : width ?? 300.sp,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(
                (isLoading ?? false) ? 55.sp : radius ?? 55.sp),
            color: AppColors.white222),
        child: Center(
          child: isLoading ?? false
              ? CircularProgressIndicator(
                  color: AppColors.white,
                )
              : Text(
                  text,
                  style: interSemiBold.copyWith(
                      fontSize: fontSize ?? 16.sp, color: AppColors.green47),
                ),
        ),
      ),
    );
  }
}

class GreenBorderedButton extends StatelessWidget {
  final String text;
  final double? height;
  final double? width;
  final double? fontSize;
  final double? radius;
  final void Function()? onTap;
  final bool? isLoading;
  const GreenBorderedButton({
    super.key,
    required this.text,
    this.height,
    this.fontSize,
    this.onTap,
    this.width,
    this.radius,
    this.isLoading,
  });
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (isLoading ?? false) ? null : onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        padding: EdgeInsets.all(5.sp),
        height: (isLoading ?? false) ? 60.sp : height ?? 50.sp,
        width: (isLoading ?? false) ? 60.sp : width ?? 300.sp,
        decoration: BoxDecoration(
            border: Border.all(color: AppColors.green93),
            borderRadius: BorderRadius.circular(
                (isLoading ?? false) ? 55.sp : radius ?? 55.sp),
            color: AppColors.white),
        child: Center(
          child: isLoading ?? false
              ? CircularProgressIndicator(
                  color: AppColors.green93,
                )
              : Text(
                  text,
                  style: interSemiBold.copyWith(
                      fontSize: fontSize ?? 16.sp, color: AppColors.green93),
                ),
        ),
      ),
    );
  }
}

class BlackBorderedButton extends StatelessWidget {
  final String text;
  final double? height;
  final double? width;
  final double? fontSize;
  final double? radius;
  final void Function()? onTap;
  final bool? isLoading;
  const BlackBorderedButton({
    super.key,
    required this.text,
    this.height,
    this.fontSize,
    this.onTap,
    this.width,
    this.radius,
    this.isLoading,
  });
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (isLoading ?? false) ? null : onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        padding: EdgeInsets.all(5.sp),
        height: (isLoading ?? false) ? 60.sp : height ?? 50.sp,
        width: (isLoading ?? false) ? 60.sp : width ?? 300.sp,
        decoration: BoxDecoration(
            border: Border.all(color: AppColors.black),
            borderRadius: BorderRadius.circular(
                (isLoading ?? false) ? 55.sp : radius ?? 55.sp),
            color: AppColors.white.withOpacity(.8)),
        child: Center(
          child: isLoading ?? false
              ? CircularProgressIndicator(
                  color: AppColors.green93,
                )
              : Text(
                  text,
                  style: interSemiBold.copyWith(
                      fontSize: fontSize ?? 16.sp, color: AppColors.green93),
                ),
        ),
      ),
    );
  }
}
