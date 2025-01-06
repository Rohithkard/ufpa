import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_getx_widget.dart';
import 'package:upfa/app_bar/app_bar.dart';
import 'package:upfa/app_network_image/app_network_image.dart';
import 'package:upfa/color/color.dart';
import 'package:upfa/route/routes.dart';
import 'package:upfa/user_review_listing/user_review_listing_controller.dart';
import 'package:upfa/user_review_listing/user_review_model.dart';

import '../empty_page/empty_page.dart';
import '../error_page/error_page.dart';
import '../loading_animation/loading_animation.dart';

class UserReviewListingView extends StatelessWidget {
  const UserReviewListingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: "Users",
      ),
      body: GetX<UserReviewListingController>(builder: (controller) {
        return controller.isLoading.value
            ? LoadingBarsAnimation()
            : controller.isError.value
                ? ErrorPage()
                : (controller.users?.isEmpty ?? false)
                    ? EmptyPage()
                    : ListView(
                        controller: controller.scrollController,
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 15.sp),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  UserReviewListingController.to.area ?? "",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16.sp),
                                ),
                                Text(
                                  "Member :  ${UserReviewListingController.to.memberCount ?? " "}",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16.sp),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 20.sp,
                          ),
                          Column(
                              children:
                                  (UserReviewListingController.to.users ?? [])
                                      .map((user) =>
                                          UserListingContainer(user: user))
                                      .toList()),
                          GetX<UserReviewListingController>(
                              builder: (controller) {
                            return controller.next.value == null
                                ? SizedBox()
                                : LoadingBarsAnimation(
                                    height: 300.sp,
                                  );
                          })
                        ],
                      );
      }),
    );
  }
}

class UserListingContainer extends StatelessWidget {
  Users user;
  UserListingContainer({super.key, required this.user});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.toNamed(AppRoutes.userReviewDetails, arguments: user),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 15.sp, vertical: 7.sp),
        decoration: BoxDecoration(
            color: (UserReviewListingController.to.users?.indexOf(user) ?? 0) %
                        2 ==
                    1
                ? AppColors.white
                : AppColors.white222),
        child: Row(
          children: [
            Container(
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.green93, width: 3.sp)),
              child: AppNetworkImage(
                imageUrl: user.image ?? "",
                height: 40.sp,
                width: 40.sp,
                radius: 65.sp,
              ),
            ),
            SizedBox(
              width: 5.sp,
            ),
            SizedBox(
              width: 65.sp,
              child: Text(user.name ?? "",
                  style: TextStyle(
                    fontSize: 12.sp,
                  )),
            ),
            SizedBox(
              width: 100.sp,
              child: Text(
                user.phoneNumber ?? "",
                style: TextStyle(
                  fontSize: 12.sp,
                ),
              ),
            ),
            user.membershipValidity != null
                ? SizedBox(
                    width: 70.sp,
                    child: Text(
                      user.membershipValidity!.isBefore(DateTime.now())
                          ? "Active"
                          : "Expired",
                      style: TextStyle(
                          fontSize: 12.sp,
                          color:
                              user.membershipValidity!.isBefore(DateTime.now())
                                  ? AppColors.green93
                                  : AppColors.red),
                    ),
                  )
                : SizedBox(),
            SizedBox(
              width: 30.sp,
              child: Text(
                "View",
                style: TextStyle(fontSize: 12.sp, color: AppColors.blue),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
