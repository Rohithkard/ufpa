import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_getx_widget.dart';
import 'package:upfa/app_buttons/app_buttons.dart';
import 'package:upfa/error_page/error_page.dart';
import 'package:upfa/loading_animation/loading_animation.dart';
import 'package:upfa/record_entry/record_entry_controller.dart';
import 'package:upfa/textfields/textfields.dart';
import 'package:upfa/validators/validations.dart';

import '../app_bar/app_bar.dart';
import '../color/color.dart';

class RecordEntryView extends StatelessWidget {
  const RecordEntryView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWithImage(
        imageUrl: RecordEntryController.to.user?.image,
        title: "",
      ),
      body: GetX<RecordEntryController>(builder: (controller) {
        return controller.isLoading.value
            ? LoadingBarsAnimation()
            : controller.isError.value
                ? ErrorPage()
                : ListView(
                    padding: EdgeInsets.symmetric(horizontal: 15.sp),
                    shrinkWrap: true,
                    children: [
                      Text(
                        RecordEntryController.to.user?.name ?? "",
                        style: TextStyle(
                            fontSize: 25.sp, fontWeight: FontWeight.w600),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        RecordEntryController.to.user?.area ?? "",
                        style: TextStyle(fontSize: 16.sp),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: 20.sp,
                      ),
                      RecordEntryInfoListingItem(
                        text: "Address",
                        value:
                            "${RecordEntryController.to.user?.address1} ${RecordEntryController.to.user?.address2}${RecordEntryController.to.user?.address3}",
                      ),
                      SizedBox(
                        height: 20.sp,
                      ),
                      RecordEntryInfoListingItem(
                        text: "Phone",
                        value: RecordEntryController.to.user?.phoneNumber ?? "",
                      ),
                      SizedBox(
                        height: 20.sp,
                      ),
                      RecordEntryInfoListingItem(
                        text: "Email",
                        value: RecordEntryController.to.user?.email ?? "",
                      ),
                      SizedBox(
                        height: 40.sp,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          RecordEntryInfoAddingItem(
                            text: "Adult",
                            controller: RecordEntryController.to.adultCount,
                          ),
                          RecordEntryInfoAddingItem(
                            text: "Children",
                            controller: RecordEntryController.to.childCount,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20.sp,
                      ),
                      AppTextFormField(
                          controller: RecordEntryController.to.remark,
                          minLines: 3,
                          maxLInes: 4,
                          validator: (value) =>
                              Validators.isEmpty(value: value),
                          header: "Remarks"),
                      SizedBox(
                        height: 20.sp,
                      ),
                      GetX<RecordEntryController>(builder: (controller) {
                        return GreenButton(
                          text: "Record Entry",
                          isLoading:
                              RecordEntryController.to.isButtonLoading.value,
                          onTap: () => RecordEntryController.to.addUserCount(),
                        );
                      })
                    ],
                  );
      }),
    );
  }
}

class RecordEntryInfoListingItem extends StatelessWidget {
  String text;
  String value;
  RecordEntryInfoListingItem({
    super.key,
    required this.value,
    required this.text,
  });
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 100.sp,
          child: Text(
            text,
            style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),
          ),
        ),
        const Text(" : "),
        SizedBox(
          width: 200.sp,
          child: Text(
            value,
            style: TextStyle(fontSize: 16.sp, color: AppColors.grey),
          ),
        )
      ],
    );
  }
}

class RecordEntryInfoAddingItem extends StatelessWidget {
  String text;
  TextEditingController controller;
  bool? readOnly;
  RecordEntryInfoAddingItem({
    super.key,
    required this.text,
    required this.controller,
    this.readOnly,
  });
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          text,
          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16.sp),
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 20.sp),
          width: 70.sp,
          child: AppTextFormField(
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 10, vertical: 5.sp),
              controller: controller,
              validator: (value) => Validators.isEmpty(value: value),
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              textInputType: TextInputType.number,
              readOnly: readOnly,
              header: ""),
        ),
      ],
    );
  }
}
