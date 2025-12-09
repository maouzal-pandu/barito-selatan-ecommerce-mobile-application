import 'package:barsel_ecommerce_flutter_application_alter/app/data/services/item_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchResultController extends GetxController {
  final _itemService = ItemsService();

  final isLoading = false.obs;
  final isLoadingMoreProducts = false.obs;

  final scrollController = ScrollController();
  final currentProductPage = 0.obs;
  final totalProductPage = 0.obs;

  final categoryName = ''.obs;

  final products = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    final args = Get.arguments;

    if (args['category'] == true) {
      categoryName.value = args['category_name'];
      loadProducts();
    }

    scrollController.addListener(() {
      if (scrollController.position.pixels >=
              scrollController.position.maxScrollExtent - 25 &&
          !isLoadingMoreProducts.value &&
          currentProductPage.value < totalProductPage.value) {
        loadMoreProducts();
      }
    });
  }

  Future<void> loadProducts() async {
    try {
      isLoading.value = true;

      final response = await _itemService.categoryProducts(categoryName.value);

      if (response['status'] == true) {
        currentProductPage.value = 1;
        totalProductPage.value = response['total_pages'];
        products.addAll(response['data']);
      } else {}
    } catch (e) {
      Get.snackbar('Error', '$e', backgroundColor: Colors.red);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> loadMoreProducts() async {
    try {
      isLoadingMoreProducts.value = true;
      currentProductPage.value++;

      final result = await _itemService.categoryProducts(
        categoryName.value,
        page: currentProductPage.value,
      );

      if (result['status'] == true) {
        products.addAll(result['data']);
      }
    } catch (e) {
      Get.snackbar('Error', '$e', backgroundColor: Colors.red);
    } finally {
      isLoadingMoreProducts.value = false;
    }
  }
}
