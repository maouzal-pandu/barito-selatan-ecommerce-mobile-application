import 'package:get/get.dart';

import '../controllers/edit_my_store_controller.dart';

class EditMyStoreBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EditMyStoreController>(
      () => EditMyStoreController(),
    );
  }
}
