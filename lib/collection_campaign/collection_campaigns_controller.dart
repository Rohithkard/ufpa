import 'package:get/get.dart';

import '../api_services/api_services.dart';
import 'collection_campaigns_model.dart';

class CollectionCampaignsControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CollectionCampaignsController());
  }
}

class CollectionCampaignsController extends GetxController {
  static CollectionCampaignsController get to => Get.find();

  @override
  void onInit() async {
    super.onInit();
    try {
      isLoading.value = true;
      await getCampaigns();
      isError.value = false;
    } catch (error) {
      isError.value = true;
    } finally {
      isLoading.value = false;
    }
  }

  RxBool isLoading = false.obs;
  RxBool isError = false.obs;

  List<GetCampaignResponseModel>? campaigns;
  getCampaigns() async {
    campaigns = await ApiServices.campaigns(queryParameter: {});
  }
}
