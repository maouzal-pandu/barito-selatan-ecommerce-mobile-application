import 'package:barsel_ecommerce_flutter_application_alter/app/data/services/item_service.dart';
import 'package:barsel_ecommerce_flutter_application_alter/app/data/services/store_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductDetailsController extends GetxController {
  // Product variables
  final productId = ''.obs;

  // Store variables
  final resellerId = ''.obs;

  final productImages = [].obs;
  final data = <String, dynamic>{}.obs;
  final storeData = <String, dynamic>{};
  final reviews = <Map<String, dynamic>>[].obs;
  final relatedProducts = <Map<String, dynamic>>[].obs;

  final isLoadingProduct = false.obs;
  final isLoadingReviews = false.obs;
  final isLoadingStore = false.obs;
  final isLoadingRelatedProducts = false.obs;
  final isLoadingMoreRelatedProducts = false.obs;

  // Image variable
  final imageController = PageController();
  final currentImageIndex = 0.obs;

  final _itemsService = ItemsService();
  final _storeService = StoreService();

  final scrollController = ScrollController();

  @override
  void onInit() {
    super.onInit();
    final args = Get.arguments;

    productId.value = args['id_product']!;
    resellerId.value = args['id_reseller'];

    _initializeData();
  }

  Future<void> _initializeData() async {
    await loadProduct();
    loadRelatedProducts();
    loadReviews();
    loadStore();
  }

  Future<void> loadProduct() async {
    try {
      isLoadingProduct.value = true;

      final response = await _itemsService.product(productId.value);

      if (response['status'] == false) {
        Get.showSnackbar(
          GetSnackBar(
            backgroundColor: const Color(0xFFD10000),
            title: "Error",
            message: 'Figure out yourself',
            duration: const Duration(seconds: 3),
          ),
        );
      }

      data.assignAll(response['data']);
      productImages.assignAll(response['data']['gambar']);
    } catch (e) {
      Get.showSnackbar(
        GetSnackBar(
          backgroundColor: const Color(0xFFD10000),
          title: "Something wrong when load product",
          message: e.toString(),
          duration: const Duration(seconds: 3),
        ),
      );
    } finally {
      isLoadingProduct.value = false;
    }
  }

  Future<void> loadReviews() async {
    try {
      isLoadingReviews.value = true;

      final response = await _itemsService.fetchReview(productId.value);

      if (response['status'] == false) {
        return;
      }

      reviews.assignAll(response['data']);
    } catch (e) {
      Get.showSnackbar(
        GetSnackBar(
          backgroundColor: const Color(0xFFD10000),
          title: "Something wrong when load product reviews",
          message: e.toString(),
          duration: const Duration(seconds: 3),
        ),
      );
    } finally {
      isLoadingReviews.value = false;
    }
  }

  Future<void> loadStore() async {
    try {
      isLoadingStore.value = true;

      final response = await _storeService.fetchStore(resellerId.value);

      if (response['status'] == true) {
        storeData.assignAll(response['data']);
      }
    } catch (e) {
      Get.showSnackbar(
        GetSnackBar(
          backgroundColor: const Color(0xFFD10000),
          title: "Error load store data",
          message: e.toString(),
          duration: const Duration(seconds: 3),
        ),
      );
    } finally {
      isLoadingStore.value = false;
    }
  }

  Future<void> loadRelatedProducts() async {
    try {
      isLoadingRelatedProducts.value = true;

      final response = await _itemsService.categoryProducts(
        data['nama_kategori'],
      );

      print(response);

      if (response['status'] == false) {}

      final relatedProductsResponse = response['data'];
      relatedProducts.assignAll(relatedProductsResponse);
    } catch (e) {
      print(e);
    } finally {
      isLoadingRelatedProducts.value = false;
    }
  }
}
