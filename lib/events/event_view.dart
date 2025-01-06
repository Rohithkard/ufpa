import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:upfa/api_services/urls.dart';
import 'package:upfa/app_bar/app_bar.dart';
import 'package:upfa/constants/get_storage_constants.dart';
import 'package:upfa/empty_page/empty_page.dart';
import 'package:upfa/error_page/error_page.dart';
import 'package:upfa/events/event_controller.dart';
import 'package:upfa/events/event_model.dart';
import 'package:upfa/loading_animation/loading_animation.dart';
import 'package:upfa/snackbar/snackbar.dart';

import '../app_buttons/app_buttons.dart';
import '../color/color.dart';
import '../custom_animated_switcher.dart';
import '../landing_page/landing_page_controller.dart';
import '../main.dart';
import '../route/routes.dart';

class EventView extends StatelessWidget {
  const EventView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "Events",
        leading: GetX<LandingPageController>(builder: (controller) {
          return CustomAnimatedIcon(
            onTap: () =>
                controller.isExpanded.value = !controller.isExpanded.value,
            firstChild: Icon(Icons.close),
            secondChild: Container(
              padding: EdgeInsets.all(5.sp),
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.white)),
              child: Icon(
                Icons.menu,
                color: AppColors.white,
                size: 25.sp,
              ),
            ),
            key: ValueKey("icon1"),
            value: controller.isExpanded.value,
          );
        }),
        backGroundColor: AppColors.green93,
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
      body: GetX<EventController>(builder: (controller) {
        return controller.isLoading.value
            ? LoadingBarsAnimation()
            : controller.isError.value
                ? ErrorPage()
                : (controller.events?.isEmpty ?? false)
                    ? EmptyPage()
                    : ListView(
                        padding: EdgeInsets.symmetric(
                            horizontal: 15.sp, vertical: 70.sp),
                        children: (EventController.to.events ?? [])
                            .map((event) => EventItemContainer(
                                  event: event,
                                ))
                            .toList(),
                      );
      }),
    );
  }
}

class EventItemContainer extends StatelessWidget {
  GetEventsResponseModel event;

  EventItemContainer({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if ((DateFormat("dd/MMM/yyyy").format(event.date!) ==
            DateFormat("dd/MMM/yyyy").format(DateTime.now()))) {
          if (event.authorizedMembers?.contains(box.read(BoxKeys.userID)) ??
              false) {
            Get.toNamed(AppRoutes.qrCodeScanner, arguments: event);
          } else {
            Get.showSnackbar(GetSnackBar(
                duration: Duration(seconds: 5),
                backgroundColor: Colors.transparent,
                padding: EdgeInsets.zero,
                messageText: AppSnackBar(
                  text: "Only executive can accress this",
                )));
          }
        }
      },
      child: Container(
        height: 200.sp,
        width: Get.width,
        padding: EdgeInsets.all(16.sp),
        margin: EdgeInsets.only(bottom: 10.sp),
        decoration: BoxDecoration(
            color: AppColors.white222,
            borderRadius: BorderRadius.circular(8.sp),
            image: DecorationImage(
                image: CachedNetworkImageProvider(
                    "${AppUrls.baseForImage}${event.eventImage}"),
                colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(0.8), BlendMode.darken),
                fit: BoxFit.cover)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              event.event ?? "",
              style: TextStyle(fontSize: 20.sp, color: AppColors.white),
            ),
            SizedBox(
              height: 13.sp,
            ),
            Text(
              "Venue :  ${event.venue ?? ""}",
              style: TextStyle(fontSize: 16.sp, color: AppColors.white),
            ),
            event.date != null
                ? Text(
                    "Date & Time :   ${DateFormat("dd / MMM / yyyy").format(event.date!)}",
                    style: TextStyle(fontSize: 16.sp, color: AppColors.white),
                  )
                : SizedBox(),
            SizedBox(
              height: 19.sp,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                (DateFormat("dd/MMM/yyyy").format(event.date!) ==
                        DateFormat("dd/MMM/yyyy").format(DateTime.now()))
                    ? WhiteButton(
                        text: "Scan",
                        width: 100.sp,
                        height: 40.sp,
                      )
                    : const SizedBox()
              ],
            )
          ],
        ),
      ),
    );
  }
}
