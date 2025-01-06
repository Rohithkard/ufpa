import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_getx_widget.dart';
import 'package:upfa/app_bar/app_bar.dart';
import 'package:upfa/app_network_image/app_network_image.dart';
import 'package:upfa/color/color.dart';
import 'package:upfa/constants/get_storage_constants.dart';
import 'package:upfa/home/home_controller.dart';
import 'package:upfa/landing_page/landing_page_controller.dart';
import 'package:upfa/route/routes.dart';

import '../custom_animated_switcher.dart';
import '../main.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "",
        leading: GetX<LandingPageController>(builder: (controller) {
          return CustomAnimatedIcon(
            onTap: () =>
                controller.isExpanded.value = !controller.isExpanded.value,
            firstChild: Icon(Icons.close),
            secondChild: Container(
              padding: EdgeInsets.all(5.sp),
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.green47)),
              child: Icon(
                Icons.menu,
                color: AppColors.green47,
                size: 25.sp,
              ),
            ),
            key: ValueKey("icon1"),
            value: controller.isExpanded.value,
          );
        }),
        actions: [
          GestureDetector(
            onTap: () {
              LandingPageController.to.isExpanded.value = false;
              Get.toNamed(AppRoutes.profile);
            },
            child: Container(
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.green93, width: 3.sp)),
              child: AppNetworkImage(
                imageUrl: box.read(BoxKeys.image) ?? "",
                height: 40.sp,
                radius: 50.sp,
                fit: BoxFit.cover,
                width: 40.sp,
              ),
            ),
          )
        ],
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 15.sp, vertical: 15.sp),
        shrinkWrap: true,
        children: [
          const HomePageSlider(),
          SizedBox(
            height: 25.sp,
          ),
          Text(
            "ABOUT UFPA",
            style: TextStyle(
                fontSize: 24.sp,
                fontWeight: FontWeight.w500,
                color: AppColors.green93),
          ),
          SizedBox(
            height: 10.sp,
          ),
          Text(
            HomeController.to.aboutUFPA ?? "",
          ),
          SizedBox(
            height: 70.sp,
          )
        ],
      ),
    );
  }
}

class HomePageSlider extends StatelessWidget {
  const HomePageSlider({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 225.sp,
      child: Stack(
        children: [
          SizedBox(
            child: PageView(
                onPageChanged: (index) =>
                    HomeController.to.currentIndex.value = index,
                children: HomeController.to.sliderImages
                    .map(
                      (image) => Container(
                        padding: EdgeInsets.symmetric(horizontal: 5.sp),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10.sp),
                          child: Image.asset(
                            image,
                            fit: BoxFit.cover,
                            height: 220.sp,
                            width: Get.width,
                          ),
                        ),
                      ),
                    )
                    .toList()),
          ),
          Positioned(
              right: 0, bottom: 10.sp, left: 0, child: const DotIndicator())
        ],
      ),
    );
  }
}

class DotIndicator extends StatelessWidget {
  const DotIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(4, ((index) => index))
          .map((index) => GetX<HomeController>(builder: (controller) {
                return Container(
                  height: 12.sp,
                  width: 12.sp,
                  margin: EdgeInsets.symmetric(horizontal: 5.sp),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: AppColors.white),
                      color: controller.currentIndex.value == index
                          ? AppColors.white
                          : Colors.transparent),
                );
              }))
          .toList(),
    );
  }
}
