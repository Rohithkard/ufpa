import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:upfa/app_buttons/app_buttons.dart';
import 'package:upfa/constants/get_storage_constants.dart';

import '../app_bar/app_bar.dart';
import '../color/color.dart';
import '../main.dart';
import '../route/routes.dart';
import 'member_ship_renewal_details_controller.dart';

class MemberShipRenewalDetailsView extends StatelessWidget {
  const MemberShipRenewalDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWithImage(
        title: "",
        imageUrl: box.read(BoxKeys.image) ?? "",
        actions: [
          GestureDetector(
            onTap: () {
              box.erase();
              Get.offAllNamed(AppRoutes.login);
            },
            child: Text(
              "Logout",
              style: TextStyle(color: AppColors.white, fontSize: 16.sp),
            ),
          )
        ],
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 15.sp),
        children: [
          Text(
            MemberShipRenewalDetailsController.to.userName ?? "",
            style: TextStyle(fontSize: 25.sp, fontWeight: FontWeight.w600),
            textAlign: TextAlign.center,
          ),
          Text(
            MemberShipRenewalDetailsController.to.area ?? "",
            style: TextStyle(fontSize: 16.sp),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 40.sp,
          ),
          MemberShipRenewalDetailsItem(
            text: "Extension",
            value:
                MemberShipRenewalDetailsController.to.extensionDuration ?? "",
          ),
          SizedBox(
            height: 20.sp,
          ),
          MemberShipRenewalDetailsItem(
            text: "Valid till",
            value: DateFormat("dd / MMM / yyy")
                .format(MemberShipRenewalDetailsController.to.validTo!),
          ),
          SizedBox(
            height: 20.sp,
          ),
          MemberShipRenewalDetailsItem(
            text: "Renewal Amount",
            value: "₹ ${MemberShipRenewalDetailsController.to.amount}",
          ),
          SizedBox(
            height: 40.sp,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GreyButton(
                text: "Pay and Renew",
                radius: 5.sp,
                padding:
                    EdgeInsets.symmetric(horizontal: 10.sp, vertical: 10.sp),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class MemberShipRenewalDetailsItem extends StatelessWidget {
  String text;
  String value;
  MemberShipRenewalDetailsItem({
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
          width: 150.sp,
          child: Text(
            text,
            style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),
          ),
        ),
        const Text(" : "),
        Container(
          width: 150.sp,
          padding: EdgeInsets.symmetric(vertical: 3.sp, horizontal: 15.sp),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5.sp),
              border: Border.all(
                color: AppColors.grey,
              )),
          child: Text(
            value,
            style: TextStyle(fontSize: 14.sp, color: AppColors.grey),
          ),
        )
      ],
    );
  }
}

class MemberShipRenewalDetailsItemWithBox extends StatelessWidget {
  String text;
  String value;
  MemberShipRenewalDetailsItemWithBox({
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
