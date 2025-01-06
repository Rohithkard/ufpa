import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_getx_widget.dart';
import 'package:upfa/app_buttons/app_buttons.dart';
import 'package:upfa/blogs/blogs_view.dart';
import 'package:upfa/color/color.dart';
import 'package:upfa/constants/get_storage_constants.dart';
import 'package:upfa/events/event_view.dart';
import 'package:upfa/home/home_view.dart';
import 'package:upfa/landing_page/landing_page_controller.dart';
import 'package:upfa/main.dart';
import 'package:upfa/route/routes.dart';

import '../snackbar/snackbar.dart';
import 'landing_page_model.dart';

class LandingPageView extends StatelessWidget {
  const LandingPageView({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (value) => LandingPageController.to.currentIndex.value != 0
          ? LandingPageController.to.changePageIndex(index: 0)
          : Get.defaultDialog(
              middleText: "Are you srue you want to exit app",
              confirm: GreenButton(
                width: 80.sp,
                radius: 10.sp,
                height: 50.sp,
                text: "yes",
                onTap: () => exit(0),
              ),
              cancel: GreenBorderedButton(
                text: "No",
                width: 80.sp,
                radius: 10.sp,
                height: 50.sp,
                onTap: () => Get.back(),
              )),
      child: Scaffold(
        body: PageView(
          physics: NeverScrollableScrollPhysics(),
          controller: LandingPageController.to.pageController,
          children: [
            HomeView(),
            BlogsView(),
            EventView(),
          ],
        ),
        bottomSheet: Container(
          decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10.sp),
                topRight: Radius.circular(10.sp),
              ),
              boxShadow: [
                BoxShadow(
                    offset: const Offset(3, 0),
                    blurRadius: 3,
                    spreadRadius: 3,
                    color: AppColors.black77.withOpacity(.2)),
              ]),
          child: GetX<LandingPageController>(builder: (controller) {
            return AnimatedSwitcher(
                duration: const Duration(milliseconds: 250),
                transitionBuilder: (Widget child, animation) {
                  return SizeTransition(
                    sizeFactor: child.key == const ValueKey('icon1')
                        ? Tween<double>(begin: 1, end: 0).animate(animation)
                        : Tween<double>(begin: 0, end: 1).animate(animation),
                    child: ScaleTransition(scale: animation, child: child),
                  );
                },
                child: LandingPageController.to.isExpanded.value
                    ? ListView(
                        padding:
                            EdgeInsets.fromLTRB(20.sp, 20.sp, 20.sp, 10.sp),
                        shrinkWrap: true,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Container(
                                padding: EdgeInsets.all(3.sp),
                                decoration: BoxDecoration(
                                    border:
                                        Border.all(color: AppColors.green47),
                                    shape: BoxShape.circle),
                                child: GestureDetector(
                                    onTap: () => LandingPageController
                                        .to.isExpanded.value = false,
                                    child: Icon(Icons.close,
                                        size: 16.sp, color: AppColors.green47)),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 30.sp,
                          ),
                          GridView(
                            key: ValueKey("icon1"),
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    mainAxisSpacing: 20.sp,
                                    crossAxisSpacing: 10.sp,
                                    crossAxisCount: 3,
                                    childAspectRatio: 55.sp / 35.sp),
                            children: (box.read(BoxKeys.membershipType) ??
                                        "") !=
                                    MembershipType.normal
                                ? [
                                    BottomSheetListingItem(
                                      item: LandingPageController
                                          .to.collectionCampaigns,
                                      onTap: () {
                                        LandingPageController
                                            .to.isExpanded.value = false;
                                        Get.toNamed(
                                            AppRoutes.collectionCampaign);
                                      },
                                    ),
                                    BottomSheetListingItem(
                                      item: LandingPageController.to.userReview,
                                      onTap: () {
                                        LandingPageController
                                            .to.isExpanded.value = false;
                                        Get.toNamed(
                                            AppRoutes.userReviewListing);
                                      },
                                    ),
                                    BottomSheetListingItem(
                                      item: LandingPageController
                                          .to.reportGeneration,
                                      onTap: () {
                                        if ((box.read(BoxKeys.reportable)) ==
                                            "1") {
                                          LandingPageController
                                              .to.isExpanded.value = false;
                                          Get.toNamed(
                                              AppRoutes.reportGeneration);
                                        } else {
                                          Get.showSnackbar(const GetSnackBar(
                                              duration: Duration(seconds: 5),
                                              backgroundColor:
                                                  Colors.transparent,
                                              padding: EdgeInsets.zero,
                                              messageText: AppSnackBar(
                                                text:
                                                    "You don't have permission to access this",
                                              )));
                                        }
                                      },
                                    ),
                                    BottomSheetListingItem(
                                      item: LandingPageController
                                          .to.executiveMembers,
                                      onTap: () {
                                        LandingPageController
                                            .to.isExpanded.value = false;
                                        Get.toNamed(AppRoutes.executiveMembers);
                                      },
                                    ),
                                    BottomSheetListingItem(
                                      item: LandingPageController
                                          .to.membershipRenewal,
                                      onTap: () {
                                        if ((box.read(BoxKeys.reviewable) ??
                                                "0") ==
                                            "1") {
                                          LandingPageController
                                              .to.isExpanded.value = false;
                                          Get.toNamed(
                                              AppRoutes.memberShipRenewal);
                                        } else {
                                          Get.showSnackbar(const GetSnackBar(
                                              duration: Duration(seconds: 5),
                                              backgroundColor:
                                                  Colors.transparent,
                                              padding: EdgeInsets.zero,
                                              messageText: AppSnackBar(
                                                text:
                                                    "You don't have permission to access this",
                                              )));
                                        }
                                      },
                                    ),
                                    BottomSheetListingItem(
                                      item: LandingPageController.to.profile,
                                      onTap: () {
                                        Get.toNamed(AppRoutes.profile);
                                        LandingPageController
                                            .to.isExpanded.value = false;
                                      },
                                    ),
                                    BottomSheetListingItem(
                                        item: LandingPageController.to.logout,
                                        onTap: () {
                                          box.erase();
                                          LandingPageController
                                              .to.isExpanded.value = false;
                                          Get.offAllNamed(AppRoutes.login);
                                        }),
                                    BottomSheetListingItem(
                                        item: LandingPageController.to.products,
                                        onTap: () {
                                          LandingPageController
                                              .to.isExpanded.value = false;
                                          Get.toNamed(AppRoutes.products);
                                        }),
                                    BottomSheetListingItem(
                                        item: LandingPageController.to.empty,
                                        onTap: () {}),
                                    BottomSheetListingItem(
                                      item: LandingPageController.to.home,
                                      onTap: () {
                                        LandingPageController.to
                                            .changePageIndex(index: 0);
                                        LandingPageController
                                            .to.isExpanded.value = false;
                                      },
                                    ),
                                    BottomSheetListingItem(
                                        item: LandingPageController.to.updates,
                                        onTap: () {
                                          LandingPageController.to
                                              .changePageIndex(index: 1);
                                          LandingPageController
                                              .to.isExpanded.value = false;
                                        }),
                                    BottomSheetListingItem(
                                        item: LandingPageController.to.event,
                                        onTap: () {
                                          LandingPageController.to
                                              .changePageIndex(index: 1);
                                          LandingPageController
                                              .to.isExpanded.value = false;
                                        }),
                                  ]
                                : [
                                    BottomSheetListingItem(
                                      item: LandingPageController.to.profile,
                                      onTap: () {
                                        Get.toNamed(AppRoutes.profile);
                                        LandingPageController
                                            .to.isExpanded.value = false;
                                      },
                                    ),
                                    BottomSheetListingItem(
                                      item: LandingPageController
                                          .to.executiveMembers,
                                      onTap: () {
                                        LandingPageController
                                            .to.isExpanded.value = false;
                                        Get.toNamed(AppRoutes.executiveMembers);
                                      },
                                    ),
                                    BottomSheetListingItem(
                                        item: LandingPageController.to.logout,
                                        onTap: () {
                                          box.erase();
                                          LandingPageController
                                              .to.isExpanded.value = false;
                                          Get.offAllNamed(AppRoutes.login);
                                        }),
                                    BottomSheetListingItem(
                                        item: LandingPageController.to.products,
                                        onTap: () {
                                          LandingPageController
                                              .to.isExpanded.value = false;
                                          Get.toNamed(AppRoutes.products);
                                        }),
                                    BottomSheetListingItem(
                                      item: LandingPageController
                                          .to.membershipRenewal,
                                      onTap: () {
                                        if ((box.read(BoxKeys.reviewable) ??
                                                "0") ==
                                            "1") {
                                          LandingPageController
                                              .to.isExpanded.value = false;
                                          Get.toNamed(
                                              AppRoutes.memberShipRenewal);
                                        } else {
                                          Get.showSnackbar(const GetSnackBar(
                                              duration: Duration(seconds: 5),
                                              backgroundColor:
                                                  Colors.transparent,
                                              padding: EdgeInsets.zero,
                                              messageText: AppSnackBar(
                                                text:
                                                    "You don't have permission to access this",
                                              )));
                                        }
                                      },
                                    ),
                                    BottomSheetListingItem(
                                      item: LandingPageController
                                          .to.collectionCampaigns,
                                      onTap: () {
                                        LandingPageController
                                            .to.isExpanded.value = false;
                                        Get.toNamed(
                                            AppRoutes.collectionCampaign);
                                      },
                                    ),
                                    BottomSheetListingItem(
                                      item: LandingPageController.to.home,
                                      onTap: () {
                                        LandingPageController.to
                                            .changePageIndex(index: 0);
                                        LandingPageController
                                            .to.isExpanded.value = false;
                                      },
                                    ),
                                    BottomSheetListingItem(
                                        item: LandingPageController.to.updates,
                                        onTap: () {
                                          LandingPageController.to
                                              .changePageIndex(index: 1);
                                          LandingPageController
                                              .to.isExpanded.value = false;
                                        }),
                                    BottomSheetListingItem(
                                        item: LandingPageController.to.event,
                                        onTap: () {
                                          LandingPageController.to
                                              .changePageIndex(index: 2);
                                          LandingPageController
                                              .to.isExpanded.value = false;
                                        }),
                                  ],
                          ),
                        ],
                      )
                    : GridView(
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            mainAxisSpacing: 20.sp,
                            crossAxisSpacing: 10.sp,
                            crossAxisCount: 3,
                            childAspectRatio: 55.sp / 35.sp),
                        children: [
                          BottomSheetListingItem(
                            item: LandingPageController.to.home,
                            onTap: () => LandingPageController.to
                                .changePageIndex(index: 0),
                          ),
                          BottomSheetListingItem(
                              item: LandingPageController.to.updates,
                              onTap: () {
                                LandingPageController.to
                                    .changePageIndex(index: 1);
                                LandingPageController.to.isExpanded.value =
                                    false;
                              }),
                          BottomSheetListingItem(
                            item: LandingPageController.to.event,
                            onTap: () => LandingPageController.to
                                .changePageIndex(index: 2),
                          ),
                        ],
                      ));
          }),
        ),
      ),
    );
  }
}

class BottomSheetListingItem extends StatelessWidget {
  BottomSheetMenuItems item;
  void Function()? onTap;
  BottomSheetListingItem({super.key, required this.item, this.onTap});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          item.image.isEmpty
              ? const SizedBox()
              : Image.asset(
                  item.image,
                  height: 30.sp,
                  width: 30.sp,
                ),
          Text(
            item.name,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w600),
          )
        ],
      ),
    );
  }
}
