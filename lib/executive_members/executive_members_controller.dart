import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../api_services/api_services.dart';
import 'executive_members_model.dart';

class ExecutiveMembersControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ExecutiveMembersController());
  }
}

class ExecutiveMembersController extends GetxController {
  static ExecutiveMembersController get to => Get.find();
  void onInit() async {
    super.onInit();
    try {
      isLoading.value = true;
      await Future.wait(
          [getExecutiveMembers(), getExecutiveOfficial(), getMeghalaMembers()]);
      pageCount = pageCount + 1;
      scrollController.addListener(() {
        if (scrollController.position.pixels ==
            scrollController.position.maxScrollExtent) {
          getExecutiveMembers();
          getMeghalaMembers();
          pageCount = pageCount + 1;
        }
      });
    } catch (error) {
      isError.value = true;
    } finally {
      isLoading.value = false;
    }
  }

  RxBool isLoading = true.obs;
  RxBool isError = false.obs;
  ScrollController scrollController = ScrollController();
  int pageCount = 1;
  RxString next = "".obs;
  RxString nextMegahala = "".obs;
  RxList<ExecutiveMember> executiveMembers = <ExecutiveMember>[].obs;
  RxList<ExecutiveMember> megahalaMembers = <ExecutiveMember>[].obs;
  RxList<ExecutiveMember> executiveMembersOfficial = <ExecutiveMember>[].obs;
  Future<void> getExecutiveMembers() async {
    var response =
        await ApiServices.executive(body: {"page": pageCount.toString()});
    executiveMembers?.addAllIf(true, response.results ?? []);
    print(executiveMembers?.length);
  }

// 8111929086
  Future<void> getMeghalaMembers() async {
    var response =
        await ApiServices.meghala(body: {"page": pageCount.toString()});
    megahalaMembers?.addAllIf(true, response.results ?? []);
    nextMegahala.value = response.next ?? "";
  }

  Future<void> getExecutiveOfficial() async {
    var response = await ApiServices.executiveOfficial(
        body: {"page": pageCount.toString()});
    executiveMembersOfficial?.addAllIf(true, response.results ?? []);
  }
}
