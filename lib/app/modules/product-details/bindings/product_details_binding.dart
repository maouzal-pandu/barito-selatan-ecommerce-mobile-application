import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/product_details_controller.dart';

class ProductDetailsBinding extends Bindings {
  @override
  void dependencies() {
    final tag = Get.parameters['tag'] ?? UniqueKey().toString();

    Get.lazyPut<ProductDetailsController>(
      () => ProductDetailsController(),
      tag: tag,
    );
  }
}
