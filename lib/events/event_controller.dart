import 'package:get/get.dart';
import 'package:upfa/api_services/api_services.dart';
import 'package:upfa/events/event_model.dart';

class EventControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => EventController());
  }
}

class EventController extends GetxController {
  static EventController get to => Get.find();

  @override
  void onInit() async {
    super.onInit();
    try {
      isLoading.value = true;
      await getEvents();
      isError.value = false;
    } catch (error) {
      isError.value = true;
    } finally {
      isLoading.value = false;
    }
  }

  RxBool isLoading = false.obs;
  RxBool isError = false.obs;

  List<GetEventsResponseModel>? events;
  getEvents() async {
    events = await ApiServices.events(queryParameter: {});
  }
}
