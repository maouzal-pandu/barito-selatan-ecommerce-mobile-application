import 'package:barsel_ecommerce_flutter_application_alter/app/data/services/item_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchPageController extends GetxController {
  final _itemsService = ItemsService();

  final categories = <Map<String, dynamic>>[].obs;

  final isLoading = false.obs;

  final formKey = GlobalKey<FormState>();
  final keywordController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    getCategory();
  }

  Future<void> getCategory() async {
    try {
      isLoading.value = true;
      final result = await _itemsService.category();
      categories.assignAll(result);
    } catch (e) {
      Get.showSnackbar(
        GetSnackBar(
          backgroundColor: const Color(0xFFD10000),
          title: "Failed to fetch categories",
          message: '$e',
          duration: Duration(seconds: 3),
        ),
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> searchProducts() async {
    if (formKey.currentState!.validate()) {
      Get.toNamed(
        '/search-result',
        arguments: {'keyword': keywordController.text},
      );
    }
  }
}
