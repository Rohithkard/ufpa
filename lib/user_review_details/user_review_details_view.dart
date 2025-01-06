import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_getx_widget.dart';
import 'package:intl/intl.dart';
import 'package:upfa/app_bar/app_bar.dart';
import 'package:upfa/app_buttons/app_buttons.dart';
import 'package:upfa/textfields/textfields.dart';
import 'package:upfa/user_review_details/user_review_details_controller.dart';
import 'package:upfa/validators/validations.dart';

import '../color/color.dart';
import '../error_page/error_page.dart';
import '../loading_animation/loading_animation.dart';

class UserReviewDetailsView extends StatelessWidget {
  const UserReviewDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWithImage(
        title: "User Review",
        imageUrl: UserReviewDetailsController.to.member?.image ?? "",
      ),
      body: GetX<UserReviewDetailsController>(builder: (controller) {
        return controller.isLoading.value
            ? LoadingBarsAnimation()
            : controller.isError.value
                ? ErrorPage()
                : ListView(
                    padding: EdgeInsets.symmetric(
                        vertical: 20.sp, horizontal: 15.sp),
                    children: [
                      Text(
                        controller.userName ?? "",
                        style: TextStyle(
                            fontSize: 25.sp, fontWeight: FontWeight.w600),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        controller.area ?? "Area",
                        style: TextStyle(fontSize: 16.sp),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: 10.sp,
                      ),
                      UserReviewItem(
                        text: "Address",
                        value: UserReviewDetailsController.to.address ?? "",
                      ),
                      SizedBox(
                        height: 10.sp,
                      ),
                      UserReviewItem(
                        text: "Phone",
                        value: UserReviewDetailsController.to.phoneNumber ?? "",
                      ),
                      SizedBox(
                        height: 10.sp,
                      ),
                      UserReviewItem(
                        text: "Email",
                        value: UserReviewDetailsController.to.email ?? "",
                      ),
                      SizedBox(
                        height: 10.sp,
                      ),
                      UserReviewDetailsController.to.memberValidity != null
                          ? UserReviewItem(
                              text: "Membership Validity",
                              value: DateFormat("dd / MM / yyyy").format(
                                  UserReviewDetailsController
                                      .to.memberValidity!),
                            )
                          : SizedBox(),
                      SizedBox(
                        height: 30.sp,
                      ),
                      Form(
                        key: UserReviewDetailsController.to.userReviewFormKey,
                        child: AppTextFormField(
                          controller:
                              UserReviewDetailsController.to.controllerReview,
                          header: "Write a review",
                          validator: (value) =>
                              Validators.isEmpty(value: value),
                          minLines: 4,
                          maxLInes: 5,
                        ),
                      ),
                      SizedBox(
                        height: 20.sp,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          GetX<UserReviewDetailsController>(
                              builder: (controller) {
                            return GreenButton(
                              text: "Submit",
                              isLoading: controller.isReviewButtonLoading.value,
                              onTap: () =>
                                  UserReviewDetailsController.to.submit(),
                              radius: 10.sp,
                              height: 40.sp,
                              width: 150.sp,
                            );
                          }),
                        ],
                      )
                    ],
                  );
      }),
    );
  }
}

class UserReviewItem extends StatelessWidget {
  String text;
  String value;
  UserReviewItem({
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
