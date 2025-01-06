import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../color/color.dart';
import '../text_style/text_style.dart';

class AppTextFormField extends StatelessWidget {
  final String header;
  final int? maxLInes;
  final int? minLines;
  final double? fontSize;
  final int? maxLength;
  final bool? readOnly;
  final EdgeInsetsGeometry? contentPadding;
  final String? placeHolder;
  final bool? showBanner;
  String? errorText;
  final String? Function(String?)? validator;
  final void Function(String)? onChange;
  final TextEditingController controller;
  final TextInputType? textInputType;

  final List<TextInputFormatter>? inputFormatters;

  AppTextFormField(
      {super.key,
      required this.controller,
      this.validator,
      this.maxLInes,
      this.showBanner,
      this.readOnly,
      this.maxLength,
      this.minLines,
      this.errorText,
      this.onChange,
      this.placeHolder,
      this.fontSize,
      required this.header,
      this.textInputType,
      this.contentPadding,
      this.inputFormatters});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          controller: controller,
          style: interRegular.copyWith(fontSize: fontSize ?? 14.sp),
          readOnly: readOnly ?? false,
          validator: validator,
          onChanged: onChange,
          inputFormatters: inputFormatters,
          keyboardType: textInputType,
          smartDashesType: SmartDashesType.enabled,
          maxLines: maxLInes ?? 1,
          minLines: minLines ?? 1,
          maxLength: maxLength,
          decoration: InputDecoration(
            isDense: true,
            filled: true,
            counterText: "",
            contentPadding: contentPadding ??
                EdgeInsets.symmetric(horizontal: 15.sp, vertical: 15.sp),
            label: Text(header),
            floatingLabelBehavior: showBanner ?? false
                ? FloatingLabelBehavior.always
                : FloatingLabelBehavior.never,
            alignLabelWithHint: true,
            errorText: (errorText ?? "").isEmpty ? null : errorText,
            floatingLabelStyle: interRegular.copyWith(
                fontSize: 18.sp, color: AppColors.black77),
            labelStyle: interRegular.copyWith(
                fontSize: 14.sp, color: AppColors.black77),
            fillColor: AppColors.white,
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.sp),
                borderSide: BorderSide(color: AppColors.grey)),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.sp),
                borderSide: BorderSide(color: AppColors.grey)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.sp),
                borderSide: BorderSide(color: AppColors.grey)),
            disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.sp),
                borderSide: BorderSide(color: AppColors.grey)),
          ),
        )
      ],
    );
  }
}

class AppTextFormFieldSmaller extends StatelessWidget {
  final String header;
  final int? maxLInes;
  final int? minLines;
  final double? fontSize;
  final int? maxLength;
  final bool? readOnly;
  final String? placeHolder;
  String? errorText;
  final String? Function(String?)? validator;
  final void Function(String)? onChange;
  final TextEditingController controller;
  final TextInputType? textInputType;

  final List<TextInputFormatter>? inputFormatters;

  AppTextFormFieldSmaller(
      {super.key,
      required this.controller,
      this.validator,
      this.maxLInes,
      this.readOnly,
      this.maxLength,
      this.minLines,
      this.errorText,
      this.onChange,
      this.placeHolder,
      this.fontSize,
      required this.header,
      this.textInputType,
      this.inputFormatters});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          controller: controller,
          style: interRegular.copyWith(fontSize: 14.sp),
          readOnly: readOnly ?? false,
          validator: validator,
          onChanged: onChange,
          inputFormatters: inputFormatters,
          keyboardType: textInputType,
          smartDashesType: SmartDashesType.enabled,
          maxLines: maxLInes ?? 1,
          minLines: minLines ?? 1,
          maxLength: maxLength,
          decoration: InputDecoration(
            isDense: true,
            counterText: "",
            contentPadding:
                EdgeInsets.symmetric(horizontal: 15.sp, vertical: 8.sp),
            alignLabelWithHint: true,
            errorText: (errorText ?? "").isEmpty ? null : errorText,
            floatingLabelStyle: interRegular.copyWith(
                fontSize: 14.sp, color: AppColors.black77),
            labelStyle: interRegular.copyWith(
                fontSize: 14.sp, color: AppColors.black77),
            filled: true,
            fillColor: AppColors.white,
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.sp),
                borderSide: BorderSide(color: AppColors.grey)),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.sp),
                borderSide: BorderSide(color: AppColors.grey)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.sp),
                borderSide: BorderSide(color: AppColors.grey)),
            disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.sp),
                borderSide: BorderSide(color: AppColors.grey)),
          ),
        )
      ],
    );
  }
}

class AppDropDownFormField<T> extends StatelessWidget {
  final String header;
  final String? placeHolder;
  final String? errorText;
  final bool? validationNeeded;
  final double? width;
  final bool? readOnly;
  final String? Function(T) label;
  T? value;
  final String? Function(T?)? validator;
  void Function(T?)? onChange;
  final List<T> itemList;

  AppDropDownFormField(
      {super.key,
      required this.header,
      required this.onChange,
      required this.value,
      required this.itemList,
      this.errorText,
      this.width,
      this.readOnly,
      this.placeHolder,
      required this.label,
      this.validationNeeded,
      this.validator});

  @override
  Widget build(BuildContext context) {
    return AbsorbPointer(
      absorbing: readOnly ?? false,
      child: DropdownButtonFormField<T>(
          iconSize: 0,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: validator ??
              (value) {
                if (value == null) {
                  return errorText ?? "This field is required";
                } else {
                  return null;
                }
              },
          itemHeight: null,
          isExpanded: true,
          hint: Text(
            placeHolder ?? "Select",
            style: TextStyle(color: AppColors.grey, fontSize: 14.sp),
          ),
          style: TextStyle(
            fontSize: 16.sp,
          ),
          decoration: InputDecoration(
              isDense: true,
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 15.sp, vertical: 13.sp),
              floatingLabelAlignment: FloatingLabelAlignment.start,
              floatingLabelBehavior: FloatingLabelBehavior.auto,
              filled: true,
              label: Text(header),
              counterText: "",
              fillColor: AppColors.white,
              border: OutlineInputBorder(
                  borderSide: BorderSide(color: AppColors.grey),
                  borderRadius: BorderRadius.circular(8.sp)),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: AppColors.grey),
                  borderRadius: BorderRadius.circular(8.sp)),
              focusedErrorBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: AppColors.grey),
                  borderRadius: BorderRadius.circular(8.sp)),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: AppColors.grey),
                  borderRadius: BorderRadius.circular(8.sp))),
          isDense: true,
          iconEnabledColor: AppColors.grey,
          iconDisabledColor: AppColors.grey,
          items: itemList
              .map((e) => DropdownMenuItem(
                    value: e,
                    child: Text(
                      label(e) ?? "",
                      style:
                          TextStyle(fontSize: 16.sp, color: AppColors.black77),
                    ),
                  ))
              .toList(),
          value: value,
          onChanged: onChange),
    );
  }
}
