import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:upfa/app_bar/app_bar.dart';
import 'package:upfa/app_network_image/app_network_image.dart';
import 'package:upfa/blogs/blogs_controller.dart';
import 'package:upfa/blogs/blogs_model.dart';
import 'package:upfa/color/color.dart';
import 'package:upfa/error_page/error_page.dart';

import '../custom_animated_switcher.dart';
import '../landing_page/landing_page_controller.dart';
import '../loading_animation/loading_animation.dart';

class BlogsView extends StatelessWidget {
  const BlogsView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(BlogsController());
    return Scaffold(
      appBar: CustomAppBar(
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
        backGroundColor: AppColors.green93,
        title: "UPDATES",
      ),
      body: GetX<BlogsController>(builder: (controller) {
        return Container(
          child: controller.isLoading.value
              ? LoadingBarsAnimation()
              : controller.isError.value
                  ? ErrorPage()
                  : ListView(
                      controller: BlogsController.to.scrollController,
                      padding: EdgeInsets.symmetric(
                          horizontal: 15.sp, vertical: 20.sp),
                      shrinkWrap: true,
                      children: [
                        GetX<BlogsController>(builder: (controller) {
                          return Column(
                            children: BlogsController.to.blogs
                                .map((blog) => BlogListingContainer(
                                      blog: blog,
                                    ))
                                .toList(),
                          );
                        }),
                        GetX<BlogsController>(builder: (controller) {
                          return controller.next.value == ""
                              ? SizedBox()
                              : LoadingBarsAnimation(
                                  height: 200.sp,
                                );
                        })
                      ],
                    ),
        );
      }),
    );
  }
}

class BlogListingContainer extends StatelessWidget {
  Blogs blog;
  Rx<int?> maxLine = Rx<int?>(5);
  BlogListingContainer({required this.blog});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20.sp),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.sp),
              color: AppColors.grey150.withOpacity(.1),
              border: Border.all(color: AppColors.grey150),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                (blog.image ?? "").isNotEmpty
                    ? AppNetworkImage(
                        imageUrl: blog.image ?? "",
                        width: Get.width,
                        radius: 10.sp,
                        height: 250.sp,
                        fit: BoxFit.cover,
                      )
                    : SizedBox(),
                Container(
                  padding: EdgeInsets.all(10.sp),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 10.sp,
                      ),
                      Text(
                        blog.title ?? "",
                        style: TextStyle(
                            fontSize: 16.sp,
                            color: AppColors.black,
                            fontWeight: FontWeight.w600),
                      ),
                      SizedBox(
                        height: 5.sp,
                      ),
                      GetX<BlogsController>(builder: (controller) {
                        return Text(
                          blog.content ?? "",
                          maxLines: maxLine.value,
                          style: TextStyle(
                            fontSize: 12.sp,
                          ),
                        );
                      }),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          GetX<BlogsController>(builder: (controller) {
                            return IconButton(
                              onPressed: () {
                                if (maxLine.value == null) {
                                  maxLine.value = 5;
                                  print("xd");
                                } else {
                                  maxLine.value = null;
                                  print("dv");
                                }
                              },
                              icon: Text(
                                maxLine.value == null
                                    ? "Read More"
                                    : "Read less",
                                style: TextStyle(
                                    fontSize: 14.sp,
                                    color: Colors.blueAccent,
                                    fontWeight: FontWeight.w600),
                              ),
                            );
                          })
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: 5.sp,
          ),
          blog.createdAt != null
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(DateFormat("hh:mm").format(blog.createdAt!)),
                  ],
                )
              : SizedBox()
        ],
      ),
    );
  }
}
