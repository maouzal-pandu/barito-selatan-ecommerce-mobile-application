import 'package:barsel_ecommerce_flutter_application_alter/app/data/services/item_service.dart';
import 'package:barsel_ecommerce_flutter_application_alter/app/models/option_item.dart';
import 'package:barsel_ecommerce_flutter_application_alter/app/models/product_variation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddProductController extends GetxController {
  final formKey = GlobalKey<FormState>();

  final isPreOrder = false.obs;

  final selectedCategoryId = ''.obs;
  final productNameController = TextEditingController();
  final productWeightController = TextEditingController();
  final productStockController = TextEditingController();
  // final productModalController = TextEditingController();
  final productPriceController = TextEditingController();
  final productDiscountController = TextEditingController();
  final productSKUController = TextEditingController();
  final productMinOrderController = TextEditingController();
  final productDescriptionController = TextEditingController();
  final productEstimationController = TextEditingController();

  final productCategories = <Map<String, dynamic>>[].obs;

  final productVariations = <ProductVariation>[].obs;

  final _itemService = ItemsService();

  @override
  void onInit() {
    super.onInit();
    fetchCategories();
    productVariations.add(ProductVariation());
  }

  Future<void> fetchCategories() async {
    try {
      final response = await _itemService.category();

      productCategories.assignAll(response);
    } catch (e) {
      Get.snackbar('Error', '$e', backgroundColor: Colors.red);
    }
  }

  void addVariation() {
    productVariations.add(ProductVariation());
  }

  void removeVariation(int index) {
    if (productVariations.length > 1) {
      // dispose controllers inside the variation before removing
      productVariations[index].dispose();
      productVariations.removeAt(index);
    }
  }

  /// Add a new option (input + price) to a specific variation
  void addOption(int variationIndex) {
    if (variationIndex < 0 || variationIndex >= productVariations.length) {
      return;
    }
    productVariations[variationIndex].options.add(OptionItem());
  }

  /// Remove option row inside a specific variation
  void removeOption(int variationIndex, int optionIndex) {
    if (variationIndex < 0 || variationIndex >= productVariations.length) {
      return;
    }
    final opts = productVariations[variationIndex].options;
    if (opts.length > 1) {
      opts[optionIndex].dispose();
      opts.removeAt(optionIndex);
    }
  }

  @override
  void onClose() {
    // dispose all controllers to avoid leaks
    for (final v in productVariations) {
      v.dispose();
    }
    // also dispose other controllers (productNameController etc.) if you have them
    super.onClose();
  }

  void addProduct() {
    if (!formKey.currentState!.validate()) return;
    // prepare data & send to backend...
  }
}
