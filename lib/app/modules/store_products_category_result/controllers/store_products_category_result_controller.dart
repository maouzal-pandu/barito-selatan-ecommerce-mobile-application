import 'package:barsel_ecommerce_flutter_application_alter/app/data/services/item_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StoreProductsCategoryResultController extends GetxController {
  final isLoading = false.obs;
  final isLoadingMoreProducts = false.obs;

  final products = <Map<String, dynamic>>[].obs;

  final page = 0.obs;
  final totalPage = 0.obs;

  final _itemService = ItemsService();

  final categoryId = ''.obs;
  final resellerId = ''.obs;

  final scrollController = ScrollController();

  @override
  void onInit() {
    super.onInit();
    final args = Get.arguments;

    resellerId.value = args['reseller_id'];
    categoryId.value = args['category_id'];

    loadProducts();

    scrollController.addListener(() {
      if (scrollController.position.pixels >=
              scrollController.position.maxScrollExtent - 25 &&
          !isLoadingMoreProducts.value &&
          page.value < totalPage.value) {
        loadMoreProducts();
      }
    });
  }

  Future<void> loadProducts() async {
    try {
      isLoading.value = true;

      final response = await _itemService.storeProductsCategory(
        resellerId.value,
        categoryId.value,
      );

      if (response['status'] == true) {
        page.value = 1;
        products.addAll(List<Map<String, dynamic>>.from(response['data']));
      }
    } catch (e) {
      Get.snackbar('Error', '$e', backgroundColor: Colors.red);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> loadMoreProducts() async {
    try {
      isLoadingMoreProducts.value = true;
      page.value++;

      final result = await _itemService.fetchProducts(page: page.value);

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
