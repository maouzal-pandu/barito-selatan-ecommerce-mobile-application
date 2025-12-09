import 'package:get/get.dart';

import '../controllers/product_details_controller.dart';

class ProductDetailsBinding extends Bindings {
  @override
  void dependencies() {
    final tag = Get.parameters['tag'];

    if (tag != null) {
      // CASE 1: related product → tagged instance
      Get.lazyPut<ProductDetailsController>(
        () => ProductDetailsController(),
        tag: tag,
      );
    } else {
      // CASE 2: normal navigation → untagged instance
      Get.lazyPut<ProductDetailsController>(() => ProductDetailsController());
    }
  }
}
