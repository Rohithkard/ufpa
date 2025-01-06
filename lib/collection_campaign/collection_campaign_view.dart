import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_getx_widget.dart';
import 'package:intl/intl.dart';
import 'package:upfa/app_bar/app_bar.dart';
import 'package:upfa/app_network_image/app_network_image.dart';
import 'package:upfa/collection_campaign/collection_campaigns_controller.dart';
import 'package:upfa/color/color.dart';

import '../empty_page/empty_page.dart';
import '../error_page/error_page.dart';
import '../loading_animation/loading_animation.dart';
import 'collection_campaigns_model.dart';

class CollectionCampaignView extends StatelessWidget {
  const CollectionCampaignView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        backGroundColor: AppColors.green93,
        title: "Collection Campaign",
      ),
      body: GetX<CollectionCampaignsController>(builder: (controller) {
        return controller.isLoading.value
            ? LoadingBarsAnimation()
            : controller.isError.value
                ? ErrorPage()
                : (controller.campaigns?.isEmpty ?? false)
                    ? EmptyPage()
                    : ListView(
                        padding: EdgeInsets.symmetric(horizontal: 15.sp),
                        children:
                            (CollectionCampaignsController.to.campaigns ?? [])
                                .map((event) => CampaignListingContainer(
                                      event: event,
                                    ))
                                .toList(),
                      );
      }),
    );
  }
}

class CampaignListingContainer extends StatelessWidget {
  GetCampaignResponseModel event;
  CampaignListingContainer({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    return GetX<CollectionCampaignsController>(builder: (controller) {
      return Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.sp),
            color: event.isPaid?.value ?? false
                ? AppColors.white222
                : AppColors.white,
            boxShadow: [
              BoxShadow(
                  color: AppColors.black77.withOpacity(.1),
                  offset: const Offset(3, 3),
                  blurRadius: 5,
                  spreadRadius: 5)
            ]),
        margin: EdgeInsets.symmetric(vertical: 10.sp),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10.sp),
                  bottomLeft: Radius.circular(10.sp)),
              child: AppNetworkImage(
                imageUrl: event.image ?? "",
                height: 185.sp,
                width: 120.sp,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(
              width: 10.sp,
            ),
            SizedBox(
              width: 210.sp,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 15.sp,
                  ),
                  Text(
                    event.campaignName ?? "",
                    style:
                        TextStyle(fontWeight: FontWeight.w600, fontSize: 16.sp),
                  ),
                  SizedBox(
                    height: 5.sp,
                  ),
                  event.dueDate != null
                      ? CollectionCampaignDetailsItem(
                          text: "Due Date",
                          value: DateFormat("dd / MM / yyyy")
                              .format(event.dueDate!),
                        )
                      : SizedBox(),
                  SizedBox(
                    height: 5.sp,
                  ),
                  CollectionCampaignDetailsItem(
                      text: "Amount", value: "Rs ${event.amount}"),
                  SizedBox(
                    height: 20.sp,
                  ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.end,
                  //   children: [
                  //     GreenButton(
                  //       text: event.isPaid?.value ?? false ? "Paid" : "Pay now",
                  //       fontSize: 13.sp,
                  //       height: 30.sp,
                  //       // onTap: () => event.isPaid?.value = true,
                  //       radius: 5.sp,
                  //       width: 90.sp,
                  //     ),
                  //   ],
                  // ),
                  SizedBox(
                    height: 10.sp,
                  ),
                ],
              ),
            )
          ],
        ),
      );
    });
  }
}

class CollectionCampaignDetailsItem extends StatelessWidget {
  String text;
  String value;
  CollectionCampaignDetailsItem({
    super.key,
    required this.text,
    required this.value,
  });
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: 70.sp,
          child: Text(
            "$text :",
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14.sp),
          ),
        ),
        SizedBox(
          width: 5.sp,
        ),
        Container(
          width: 135.sp,
          decoration: BoxDecoration(
              border: Border.all(color: AppColors.grey, width: 1.5.sp),
              borderRadius: BorderRadius.circular(5.sp)),
          padding: EdgeInsets.symmetric(horizontal: 8.sp, vertical: 2.sp),
          child: Text(
            value,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 15.sp,
                color: AppColors.grey),
          ),
        )
      ],
    );
  }
}
