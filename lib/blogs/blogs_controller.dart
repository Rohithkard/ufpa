import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:upfa/api_services/api_services.dart';

import 'blogs_model.dart';

class BlogsControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(BlogsController());
  }
}

class BlogsController extends GetxController {
  static BlogsController get to => Get.find();

  Future<void> onInit() async {
    try {
      isLoading.value = true;
      await getBlogs();
      scrollController.addListener(() {
        if (scrollController.position.maxScrollExtent ==
            scrollController.position.pixels) {
          getBlogs();
        }
      });
    } catch (error) {
      isError.value = true;
    } finally {
      isLoading.value = false;
    }
  }

  ScrollController scrollController = ScrollController();

  getBlogs() async {
    GetBlogsResponseModel response =
        await ApiServices.getBlogs(body: {"page": pageCount.toString()});
    blogs.value = response.results ?? [];
    pageCount = pageCount + 1;

    next.value = response.next ?? "";
  }

  RxBool isError = false.obs;
  RxBool isLoading = false.obs;
  int pageCount = 1;
  RxString next = "".obs;
  RxList<Blogs> blogs = <Blogs>[].obs;
}
