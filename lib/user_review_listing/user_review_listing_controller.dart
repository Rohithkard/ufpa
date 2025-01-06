import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:upfa/api_services/api_services.dart';
import 'package:upfa/constants/get_storage_constants.dart';
import 'package:upfa/user_review_listing/user_review_model.dart';

import '../main.dart';

class UserReviewListingControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => UserReviewListingController());
  }
}

class UserReviewListingController extends GetxController {
  static UserReviewListingController get to => Get.find();

  void onInit() async {
    super.onInit();

    try {
      isLoading.value = true;
      await getMembers();
      area = box.read(BoxKeys.area);
      scrollController.addListener(() async {
        if (scrollController.position.pixels ==
            scrollController.position.maxScrollExtent) {
          await getMembers();
        }
      });
    } catch (error) {
      isError.value = true;
    } finally {
      isLoading.value = false;
    }
  }

  RxBool isLoading = true.obs;

  int pageCount = 1;
  RxList<Users> users = <Users>[].obs;
  int? memberCount;
  String? area;
  Rx<String?> next = Rx<String?>(null);

  RxBool isError = false.obs;
  ScrollController scrollController = ScrollController();
  getMembers() async {
    MembershipResponseModel response =
        await ApiServices.members(body: {"page": pageCount});
    area = box.read(BoxKeys.area);
    memberCount = response.count;
    users.addAllIf(true, response.results ?? []);
    pageCount = pageCount + 1;
    next.value = response.next;
  }
}
