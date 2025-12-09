import 'package:get/get.dart';

import '../controllers/store_products_category_result_controller.dart';

class StoreProductsCategoryResultBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<StoreProductsCategoryResultController>(
      () => StoreProductsCategoryResultController(),
    );
  }
}
