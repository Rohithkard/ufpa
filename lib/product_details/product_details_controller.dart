import 'package:get/get.dart';
import 'package:upfa/api_services/api_services.dart';
import 'package:upfa/product_details/product_details_model.dart';
import 'package:upfa/product_listing/product_listing_model.dart';

class ProductDetailsControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ProductDetailsController());
  }
}

class ProductDetailsController extends GetxController {
  @override
  onInit() async {
    super.onInit();
    try {
      isLoading.value = true;
      product = Get.arguments;
      await getProductDetails();
      await getProducts();
    } catch (error) {
      isError.value = true;
    } finally {
      isLoading.value = false;
    }
  }

  Product? product;
  static ProductDetailsController get to => Get.find();
  getProducts() async {
    GetProductsResponseModel response =
        await ApiServices.productListing(body: {"page": "1"});
    products.addAll(response.results ?? []);
    (products ?? []).removeWhere((element) => element.id == product?.id);
  }

  RxList<Product> products = <Product>[].obs;

  getProductDetails() async {
    GetProductsDetailsResponseModel response =
        await ApiServices.getProductDetails(id: product?.id);
    productImages = [
      response.productImage1,
      response.productImage2,
      response.productImage3,
      response.productImage4,
      response.productImage5,
    ];
    productImages.removeWhere((image) => (image ?? "").isEmpty);
    productName = response.productName ?? "";
    price = response.productPrice;
    description = response.productDescription;
    available = response.availability;
  }

  RxBool isLoading = false.obs;
  RxBool isError = false.obs;
  List<String?> productImages = <String?>[];
  String? productName;
  String? description;
  int? price;
  bool? available;
}
