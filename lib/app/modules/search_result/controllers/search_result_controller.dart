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

  // if from category button
  final isCategory = false.obs;
  final categoryName = ''.obs;
  // if using keyword
  final searchKeyword = ''.obs;

  // filter variables
  final minPrice = 0.obs;
  final maxPrice = 100000.obs;
  final selectedSort = ''.obs; // terbaru, termurah, termahal

  final products = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    final args = Get.arguments;

    if (args['category'] == true) {
      isCategory.value = args['category'];
      categoryName.value = args['category_name'];
      loadProducts();
    } else {
      searchKeyword.value = args['keyword'];
      loadProducts();
      // products.assignAll(List<Map<String, dynamic>>.from(args['products']));
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

      if (isCategory.value) {
        final response = await _itemService.categoryProducts(
          categoryName.value,
          sort: selectedSort.value,
        );

        if (response['status'] == true) {
          currentProductPage.value = 1;
          totalProductPage.value = response['total_pages'];
          products.addAll(response['data']);
        }
      } else {
        final response = await _itemService.searchProducts(
          keyword: searchKeyword.value,
          sort: selectedSort.value,
        );

        if (response['status'] == true) {
          currentProductPage.value = 1;
          totalProductPage.value = response['total_pages'];
          products.addAll(List<Map<String, dynamic>>.from(response['data']));
        }
      }
    } catch (e) {
      Get.snackbar('Error', '$e', backgroundColor: Colors.red);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> loadMoreProducts() async {
    try {
      if (isCategory.value) {
        isLoadingMoreProducts.value = true;
        currentProductPage.value++;

        final response = await _itemService.categoryProducts(
          categoryName.value,
          sort: selectedSort.value,
          page: currentProductPage.value,
        );

        if (response['status'] == true) {
          products.addAll(response['data']);
        }
      } else {
        isLoadingMoreProducts.value = true;
        currentProductPage.value++;

        final response = await _itemService.searchProducts(
          keyword: searchKeyword.value,
          page: currentProductPage.value,
          sort: selectedSort.value,
        );

        if (response['status'] == true) {
          products.addAll(List<Map<String, dynamic>>.from(response['data']));
        }
      }
    } catch (e) {
      Get.snackbar('Error', '$e', backgroundColor: Colors.red);
    } finally {
      isLoadingMoreProducts.value = false;
    }
  }

  Future<void> applyFilter() async {
    try {
      isLoading.value = true;

      products.clear();

      if (isCategory.value) {
        final response = await _itemService.categoryProducts(
          categoryName.value,
          sort: selectedSort.value,
        );

        if (response['status'] == true) {
          currentProductPage.value = 1;
          totalProductPage.value = response['total_pages'];
          products.addAll(response['data']);
        }
      } else {
        final response = await _itemService.searchProducts(
          keyword: searchKeyword.value,
          sort: selectedSort.value,
        );

        if (response['status'] == true) {
          currentProductPage.value = 1;
          totalProductPage.value = response['total_pages'];
          products.addAll(List<Map<String, dynamic>>.from(response['data']));
        }
      }
    } catch (e) {
      Get.snackbar('Error', '$e', backgroundColor: Colors.red);
    } finally {
      isLoading.value = false;
    }
  }
}
