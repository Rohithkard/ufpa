import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:upfa/assets/icons.dart';
import 'package:upfa/blogs/blogs_controller.dart';
import 'package:upfa/events/event_controller.dart';
import 'package:upfa/home/home_controller.dart';
import 'package:upfa/landing_page/landing_page_model.dart';
import 'package:upfa/profile/profile_controller.dart';

class LandingPageControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(LandingPageController());
    Get.put(HomeController());
    Get.put(EventController());
    Get.put(ProfileController());
    Get.put(BlogsControllerBinding());
  }
}

class LandingPageController extends GetxController {
  static LandingPageController get to => Get.find();
  RxInt currentIndex = 0.obs;
  PageController pageController = PageController();
  changePageIndex({required int index}) {
    currentIndex.value = index;
    pageController.jumpToPage(currentIndex.value);
  }

  int userType = 1;
  BottomSheetMenuItems home =
      BottomSheetMenuItems(image: AppIcons.home, name: "Home");
  BottomSheetMenuItems empty = BottomSheetMenuItems(image: "", name: "");
  BottomSheetMenuItems updates =
      BottomSheetMenuItems(image: AppIcons.blogs, name: "Updates");
  BottomSheetMenuItems products =
      BottomSheetMenuItems(image: AppIcons.products, name: "UFPA CO");
  BottomSheetMenuItems event =
      BottomSheetMenuItems(image: AppIcons.executiveMembers, name: "event");
  BottomSheetMenuItems reportGeneration = BottomSheetMenuItems(
      image: AppIcons.reportGeneration, name: "Report Generation");
  BottomSheetMenuItems userReview =
      BottomSheetMenuItems(image: AppIcons.userReview, name: "User Review");
  BottomSheetMenuItems collectionCampaigns = BottomSheetMenuItems(
      image: AppIcons.collectionCampaign, name: "Collection Campaigns");
  BottomSheetMenuItems logout =
      BottomSheetMenuItems(image: AppIcons.logout, name: "logout");
  BottomSheetMenuItems membershipRenewal = BottomSheetMenuItems(
      image: AppIcons.membershipRenewal, name: "Membership Renewal");
  BottomSheetMenuItems executiveMembers = BottomSheetMenuItems(
      image: AppIcons.executiveMembers, name: "Executive Members");
  BottomSheetMenuItems profile =
      BottomSheetMenuItems(image: AppIcons.profile, name: "profile");
  RxBool isExpanded = false.obs;
}
