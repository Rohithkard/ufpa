import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_getx_widget.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:upfa/color/color.dart';
import 'package:upfa/constants/get_storage_constants.dart';
import 'package:upfa/error_page/error_page.dart';
import 'package:upfa/loading_animation/loading_animation.dart';
import 'package:upfa/main.dart';
import 'package:upfa/profile/profile_controller.dart';
import 'package:upfa/route/routes.dart';

import '../app_bar/app_bar.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWithImage(
        title: "Profile",
        imageUrl: box.read(BoxKeys.image) ?? "",
        actions: [
          GestureDetector(
            onTap: () => ProfileController.to.onInit(),
            child: Text(
              "Refresh",
              style: TextStyle(color: AppColors.white, fontSize: 16.sp),
            ),
          ),
          GetX<ProfileController>(builder: (controller) {
            return (controller.isEditable.value ?? false)
                ? GestureDetector(
                    onTap: () => Get.toNamed(AppRoutes.editProfile),
                    child: Text(
                      "Edit",
                      style: TextStyle(color: AppColors.white, fontSize: 16.sp),
                    ),
                  )
                : SizedBox();
          }),
        ],
      ),
      body: GetX<ProfileController>(builder: (controller) {
        return controller.isLoading.value
            ? LoadingBarsAnimation()
            : controller.isError.value
                ? ErrorPage()
                : ListView(
                    padding: EdgeInsets.symmetric(horizontal: 30.sp),
                    shrinkWrap: true,
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
                      ProfileInfoListingItem(
                        text: "Address",
                        value: controller.address ?? "",
                      ),
                      SizedBox(
                        height: 20.sp,
                      ),
                      ProfileInfoListingItem(
                        text: "Phone",
                        value: controller.phoneNumber ?? "",
                      ),
                      SizedBox(
                        height: 20.sp,
                      ),
                      ProfileInfoListingItem(
                        text: "Email",
                        value: controller.email ?? "",
                      ),
                      SizedBox(
                        height: 20.sp,
                      ),
                      ProfileInfoListingItem(
                        text: "Blood Group",
                        value: controller.bloodGroup ?? "",
                      ),
                      SizedBox(
                        height: 20.sp,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          QrImageView(
                            data:
                                'https://ufpa.algobiz.dev/user/details/${box.read(BoxKeys.userID)}',
                            version: QrVersions.auto,
                            size: 170.sp,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 70.sp,
                      ),
                    ],
                  );
      }),
    );
  }
}

class ProfileInfoListingItem extends StatelessWidget {
  String text;
  String value;
  ProfileInfoListingItem({
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
