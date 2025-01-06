import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_getx_widget.dart';
import 'package:upfa/app_bar/app_bar.dart';
import 'package:upfa/app_network_image/app_network_image.dart';
import 'package:upfa/color/color.dart';
import 'package:upfa/executive_members/executive_members_controller.dart';

import '../error_page/error_page.dart';
import '../loading_animation/loading_animation.dart';
import 'executive_members_model.dart';

class ExecutiveMembersView extends StatelessWidget {
  const ExecutiveMembersView({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: const CustomAppBar(
          title: "Executive Members",
        ),
        body: GetX<ExecutiveMembersController>(builder: (controller) {
          return controller.isLoading.value
              ? LoadingBarsAnimation()
              : controller.isError.value
                  ? ErrorPage()
                  : Column(
                      children: [
                        Container(
                          height: 170.sp,
                          child: ListView(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            children: (ExecutiveMembersController
                                        .to.executiveMembersOfficial ??
                                    [])
                                .map((member) =>
                                    MembersListingItem(member: member))
                                .toList(),
                          ),
                        ),
                        Column(
                          children: [
                            TabBar(
                                indicatorSize: TabBarIndicatorSize.tab,
                                labelColor: AppColors.green47,
                                unselectedLabelColor: AppColors.grey,
                                indicatorColor: AppColors.green47,
                                tabs: [
                                  Tab(text: "Executive Member"),
                                  Text("Meghala")
                                ]),
                            SizedBox(
                              height: 30.sp,
                            ),
                            GetX<ExecutiveMembersController>(
                                builder: (controller) {
                              return Container(
                                height: 430.sp,
                                child: TabBarView(
                                  children: [
                                    ListView(
                                      controller: ExecutiveMembersController
                                          .to.scrollController,
                                      shrinkWrap: true,
                                      children: [
                                        GridView(
                                          shrinkWrap: true,
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 15.sp),
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          gridDelegate:
                                              SliverGridDelegateWithFixedCrossAxisCount(
                                                  crossAxisCount: 3,
                                                  childAspectRatio:
                                                      45.sp / 71.sp,
                                                  mainAxisSpacing: 10.sp,
                                                  crossAxisSpacing: 10.sp),
                                          children: (ExecutiveMembersController
                                                      .to.executiveMembers ??
                                                  [])
                                              .map((member) =>
                                                  ExecutiveMembersListingItem(
                                                      member: member))
                                              .toList(),
                                        ),
                                        GetX<ExecutiveMembersController>(
                                            builder: (controller) {
                                          return controller.next.value == ""
                                              ? SizedBox()
                                              : LoadingBarsAnimation(
                                                  height: 200.sp,
                                                );
                                        })
                                      ],
                                    ),
                                    ListView(
                                      controller: ExecutiveMembersController
                                          .to.scrollController,
                                      shrinkWrap: true,
                                      children: [
                                        GridView(
                                          shrinkWrap: true,
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          gridDelegate:
                                              SliverGridDelegateWithFixedCrossAxisCount(
                                                  crossAxisCount: 3,
                                                  childAspectRatio:
                                                      45.sp / 71.sp,
                                                  mainAxisSpacing: 20.sp,
                                                  crossAxisSpacing: 20.sp),
                                          children: (ExecutiveMembersController
                                                      .to.megahalaMembers ??
                                                  [])
                                              .map((member) =>
                                                  ExecutiveMembersListingItem(
                                                      member: member))
                                              .toList(),
                                        ),
                                        GetX<ExecutiveMembersController>(
                                            builder: (controller) {
                                          return controller
                                                      .nextMegahala.value ==
                                                  ""
                                              ? SizedBox()
                                              : LoadingBarsAnimation(
                                                  height: 200.sp,
                                                );
                                        })
                                      ],
                                    ),
                                  ],
                                ),
                              );
                            }),
                          ],
                        ),
                      ],
                    );
        }),
      ),
    );
  }
}

class ExecutiveMembersListingItem extends StatelessWidget {
  ExecutiveMember member;
  ExecutiveMembersListingItem({super.key, required this.member});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.green93, width: 3.sp)),
            child: AppNetworkImage(
              imageUrl: member.image ?? "",
              height: 70.sp,
              width: 70.sp,
              radius: 70.sp,
              fit: BoxFit.cover,
            )),
        SizedBox(
          height: 10.sp,
        ),
        Text(
          member.name ?? "",
          style: TextStyle(fontSize: 12.sp),
        ),
        Text(
          member.area ?? "",
          style: TextStyle(fontSize: 12.sp),
        ),
        Text(
          member.designation ?? "",
          style: TextStyle(fontSize: 12.sp),
        ),
        Text(
          member.phoneNumber ?? "",
          style: TextStyle(fontSize: 12.sp),
        ),
      ],
    );
  }
}

class MembersListingItem extends StatelessWidget {
  ExecutiveMember member;
  MembersListingItem({super.key, required this.member});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15.sp),
      child: Column(
        children: [
          Container(
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.green93, width: 3.sp)),
              child: AppNetworkImage(
                imageUrl: member.image ?? "",
                height: 80.sp,
                width: 80.sp,
                radius: 70.sp,
                fit: BoxFit.cover,
              )),
          SizedBox(
            height: 10.sp,
          ),
          Text(
            member.name ?? "",
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 12.sp,
            ),
          ),
          Text(
            member.area ?? "",
            style: TextStyle(fontSize: 12.sp),
          ),
          Text(
            member.phoneNumber ?? "",
            style: TextStyle(fontSize: 12.sp),
          ),
        ],
      ),
    );
  }
}
