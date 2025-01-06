import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:upfa/app_buttons/app_buttons.dart';
import 'package:upfa/constants/get_storage_constants.dart';
import 'package:upfa/main.dart';
import 'package:upfa/member_ship_renewal/member_ship_renewal_model.dart';

import '../app_bar/app_bar.dart';
import '../color/color.dart';
import '../error_page/error_page.dart';
import '../loading_animation/loading_animation.dart';
import '../route/routes.dart';
import 'member_ship_renewal_controller.dart';

class MemberShipRenewalView extends StatelessWidget {
  const MemberShipRenewalView({super.key});

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
      body: GetX<MemberShipRenewalController>(builder: (controller) {
        return controller.isLoading.value
            ? LoadingBarsAnimation()
            : controller.isError.value
                ? ErrorPage()
                : ListView(
                    padding: EdgeInsets.symmetric(horizontal: 15.sp),
                    children: [
                      Text(
                        controller.userName ?? "",
                        style: TextStyle(
                            fontSize: 25.sp, fontWeight: FontWeight.w600),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        controller.area ?? "",
                        style: TextStyle(fontSize: 16.sp),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: 20.sp,
                      ),
                      MemberShipRenewalItem(
                        text: "Address",
                        value: MemberShipRenewalController.to.address ?? "",
                      ),
                      SizedBox(
                        height: 20.sp,
                      ),
                      MemberShipRenewalItem(
                        text: "Phone",
                        value: MemberShipRenewalController.to.phoneNumber ?? "",
                      ),
                      SizedBox(
                        height: 20.sp,
                      ),
                      Text(
                        "Membership Validity",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 16.sp, fontWeight: FontWeight.w600),
                      ),
                      SizedBox(
                        height: 20.sp,
                      ),
                      controller.validityExtensionDate == null
                          ? SizedBox()
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 15.sp, vertical: 5.sp),
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5.sp),
                                      border:
                                          Border.all(color: AppColors.black77)),
                                  child: Text(DateFormat("dd / MMM / yyyy")
                                      .format(MemberShipRenewalController
                                          .to.validityExtensionDate!)),
                                ),
                              ],
                            ),
                      SizedBox(
                        height: 20.sp,
                      ),
                      controller.validityExtensionDate!
                                  .difference(DateTime.now())
                                  .inDays >
                              (controller.daysToRenewal ?? 0)
                          ? SizedBox()
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                GreyButton(
                                  text: "Renew Now",
                                  onTap: () => Get.toNamed(
                                      AppRoutes.memberShipRenewalDetails,
                                      arguments: ArgumentModelForRenewalDetails(
                                          amount: controller.amount,
                                          area: controller.area,
                                          userName: controller.userName,
                                          validityDate: controller
                                              .validityExtensionDate)),
                                  radius: 5.sp,
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 10.sp, vertical: 10.sp),
                                ),
                              ],
                            )
                    ],
                  );
      }),
    );
  }
}

class MemberShipRenewalItem extends StatelessWidget {
  String text;
  String value;
  MemberShipRenewalItem({
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
