import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:upfa/api_services/api_services.dart';
import 'package:upfa/product_listing/product_listing_model.dart';

class ProductListingControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ProductListingController());
  }
}

class ProductListingController extends GetxController {
  static ProductListingController get to => Get.find();

  @override
  Future<void> onInit() async {
    super.onInit();
    try {
      isLoading.value = true;
      await getProducts();
      scrollController.addListener(() {
        if (scrollController.position.maxScrollExtent ==
            scrollController.position.pixels) {
          getProducts();
        }
      });
    } catch (error) {
      isError.value = true;
    } finally {
      isLoading.value = false;
    }
  }

  TextEditingController controllerSearch = TextEditingController();
  RxBool isLoading = false.obs;
  RxBool isError = false.obs;
  int pageCount = 1;
  RxString next = "".obs;
  ScrollController scrollController = ScrollController();
  getProducts() async {
    GetProductsResponseModel response =
        await ApiServices.productListing(body: {"page": pageCount.toString()});
    products.addAll(response.results ?? []);
    pageCount = pageCount + 1;
    next.value = response.next ?? "";
  }

  RxList<Product> products = <Product>[].obs;
}
