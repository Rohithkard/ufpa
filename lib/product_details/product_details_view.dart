import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:upfa/app_bar/app_bar.dart';
import 'package:upfa/app_buttons/app_buttons.dart';
import 'package:upfa/app_network_image/app_network_image.dart';
import 'package:upfa/color/color.dart';
import 'package:upfa/error_page/error_page.dart';
import 'package:upfa/loading_animation/loading_animation.dart';
import 'package:upfa/product_details/product_details_controller.dart';
import 'package:upfa/product_listing/product_listing_model.dart';

class ProductDetailsView extends StatelessWidget {
  const ProductDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
          backGroundColor: AppColors.green93,
          title: ProductDetailsController.to.product?.productName ?? ""),
      body: GetX<ProductDetailsController>(builder: (controller) {
        return controller.isLoading.value
            ? LoadingBarsAnimation()
            : controller.isError.value
                ? ErrorPage()
                : ListView(
                    padding: EdgeInsets.symmetric(
                        horizontal: 15.sp, vertical: 20.sp),
                    children: [
                      Text(
                        controller.productName ?? "",
                        style:
                            TextStyle(fontSize: 18.sp, color: AppColors.black),
                      ),
                      SizedBox(
                        height: 10.sp,
                      ),
                      SizedBox(
                        height: 230.sp,
                        child: PageView(
                          children: ProductDetailsController.to.productImages
                              .map((image) => Container(
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 5.sp),
                                    child: AppNetworkImage(
                                      width: Get.width,
                                      height: 230.sp,
                                      radius: 10.sp,
                                      imageUrl: image ?? "",
                                      fit: BoxFit.cover,
                                    ),
                                  ))
                              .toList(),
                        ),
                      ),
                      SizedBox(
                        height: 10.sp,
                      ),
                      Container(
                        height: 60.sp,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: ProductDetailsController.to.productImages
                              .map((image) => Container(
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 10.sp),
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(10.sp),
                                        border: Border.all()),
                                    child: AppNetworkImage(
                                      imageUrl: image ?? "",
                                      width: 80.sp,
                                      height: 60.sp,
                                      fit: BoxFit.cover,
                                      radius: 10.sp,
                                    ),
                                  ))
                              .toList(),
                        ),
                      ),
                      SizedBox(
                        height: 10.sp,
                      ),
                      Text(controller.description ?? ""),
                      SizedBox(
                        height: 20.sp,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.sp),
                                  boxShadow: [
                                    BoxShadow(
                                        color: AppColors.grey.withOpacity(.2),
                                        spreadRadius: 2,
                                        blurRadius: 4)
                                  ]),
                              child: BlackBorderedButton(
                                  width: 120.sp,
                                  height: 30.sp,
                                  radius: 10.sp,
                                  fontSize: 14.sp,
                                  text: "Price ₹${controller.price ?? 0}")),
                          Row(
                            children: [
                              Icon(
                                Icons.lens,
                                color: AppColors.green93,
                                size: 12.sp,
                              ),
                              Text(
                                controller.available ?? false
                                    ? " InStock"
                                    : " Out of Stock",
                                style: TextStyle(
                                    color: controller.available ?? false
                                        ? AppColors.green93
                                        : AppColors.red,
                                    fontWeight: FontWeight.w600),
                              )
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20.sp,
                      ),
                      const GreenButton(text: "Enquire Now"),
                      SizedBox(
                        height: 10.sp,
                      ),
                      SizedBox(
                        height: 40.sp,
                      ),
                      RecentProducts()
                    ],
                  );
      }),
    );
  }
}

class RecentProducts extends StatelessWidget {
  const RecentProducts({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Recent Products",
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16.sp),
          ),
          SizedBox(
            height: 15.sp,
          ),
          Container(
            height: 180.sp,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: ProductDetailsController.to.products
                  .map((product) => RecentProductsListingItem(
                        product: product,
                      ))
                  .toList(),
            ),
          )
        ],
      ),
    );
  }
}

class RecentProductsListingItem extends StatelessWidget {
  Product product;
  RecentProductsListingItem({required this.product});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 15.sp),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppNetworkImage(
            imageUrl: product.productImage ?? "",
            height: 150.sp,
            width: 150.sp,
            radius: 10.sp,
          ),
          SizedBox(
            height: 5.sp,
          ),
          Text(
            product.productName ?? "",
            style: TextStyle(
                fontSize: 14.sp,
                color: AppColors.black,
                fontWeight: FontWeight.w600),
            maxLines: 2,
          )
        ],
      ),
    );
  }
}
