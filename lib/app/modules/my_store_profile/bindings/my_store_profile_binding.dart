import 'package:get/get.dart';

import '../controllers/my_store_profile_controller.dart';

class MyStoreProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MyStoreProfileController>(
      () => MyStoreProfileController(),
    );
  }
}
