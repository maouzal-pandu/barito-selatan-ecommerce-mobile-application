import 'package:get/get.dart';

import '../controllers/my_store_controller.dart';

class MyStoreBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MyStoreController>(
      () => MyStoreController(),
    );
  }
}
