import 'package:barsel_ecommerce_flutter_application_alter/app/data/services/item_service.dart';
import 'package:barsel_ecommerce_flutter_application_alter/app/data/services/store_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProductDetailsController extends GetxController {
  final productId = ''.obs;

  final resellerId = ''.obs;

  final productImages = [].obs;
  final data = <String, dynamic>{}.obs;

  final storeProfilePicture = ''.obs;
  final storeData = <String, dynamic>{};

  final reviews = <Map<String, dynamic>>[].obs;

  final relatedProducts = <Map<String, dynamic>>[].obs;
  final productVariations = <String, List<Map<String, dynamic>>>{}.obs;
  final selectedVariation = <String, Map<String, dynamic>>{}.obs;

  final isInWishlist = false.obs;

  final isLoadingProduct = false.obs;
  final isLoadingMoreProducts = false.obs;
  final isLoadingReviews = false.obs;
  final isLoadingStore = false.obs;
  final isLoadingRelatedProducts = false.obs;

  final totalProductPage = 0.obs;
  final currentProductPage = 0.obs;

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

    scrollController.addListener(() {
      if (scrollController.position.pixels >=
              scrollController.position.maxScrollExtent - 25 &&
          !isLoadingMoreProducts.value &&
          currentProductPage.value < totalProductPage.value) {
        loadMoreRelatedProducts();
      }
    });
  }

  Future<void> _initializeData() async {
    await loadProduct();
    loadRelatedProducts();
    loadReviews();
    loadStore();
    checkWishlist();
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
      // productVariations.assignAll(data['variasi']);

      // Load variations
      if (response['data']["variasi"] != null) {
        productVariations.value =
            (response['data']["variasi"] as Map<String, dynamic>).map(
              (key, value) =>
                  MapEntry(key, List<Map<String, dynamic>>.from(value)),
            );
      }
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
        storeProfilePicture.value = storeData['foto'] ?? '';
        // print(response);
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

      currentProductPage.value = 1;

      final response = await _itemsService.categoryProducts(
        data['nama_kategori'],
        page: currentProductPage.value,
      );

      if (response['status'] == false) {}

      totalProductPage.value = response['total_pages'];

      final relatedProductsResponse = response['data'];
      relatedProducts.assignAll(relatedProductsResponse);
      // print(relatedProducts);
    } catch (e) {
      Get.snackbar('Error', '$e', backgroundColor: Colors.red);
    } finally {
      isLoadingRelatedProducts.value = false;
    }
  }

  Future<void> loadMoreRelatedProducts() async {
    try {
      isLoadingMoreProducts.value = true;
      currentProductPage.value++;

      final response = await _itemsService.categoryProducts(
        data['nama_kategori'],
        page: currentProductPage.value,
      );

      if (response['status'] == false) {}

      final relatedProductsResponse = response['data'];
      relatedProducts.addAll(relatedProductsResponse);
    } catch (e) {
      Get.snackbar('Error', '$e', backgroundColor: Colors.red);
    } finally {
      isLoadingMoreProducts.value = false;
    }
  }

  Future<void> addRemoveProductWishlist() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final isLogin = prefs.getBool('login') ?? false;

      if (isLogin) {
        final consumerId = prefs.getString('id_user');

        final response = await _itemsService.addRemoveProductWishlist(
          productId.value,
          consumerId!,
        );

        if (response['status']) {
          isInWishlist.value = !isInWishlist.value;
          Get.snackbar(
            'Berhasil',
            response['message'],
            backgroundColor: Colors.white,
          );
        } else {
          Get.snackbar(
            'Gagal',
            response['message'],
            backgroundColor: Colors.red,
          );
        }
      } else {
        // Dialog login
        Get.defaultDialog(
          title: 'Gagal',
          titleStyle: TextStyle(fontSize: 20),

          content: Column(
            children: [
              SizedBox(width: double.infinity, child: const Divider()),

              const SizedBox(height: 30),

              const Text(
                'Silahkan login terlebih dahulu untuk menggunakan fitur ini.',
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 30),
            ],
          ),

          // Login button
          actions: [
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                style: ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(Colors.amber),
                ),
                onPressed: () => Get.toNamed('/login'),
                child: const Text('Login'),
              ),
            ),
          ],
        );
      }
    } catch (e) {
      Get.snackbar('Error', '$e');
    }
  }

  Future<void> checkWishlist() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final isLogin = prefs.getBool('login') ?? false;

      if (isLogin) {
        final consumerId = prefs.getString('id_user')!;
        final response = await _itemsService.productWishlistCheck(
          productId.value,
          consumerId,
        );

        if (response['status'] == true) {
          isInWishlist.value = true;
        } else {
          isInWishlist.value = false;
        }
      }
    } catch (e) {
      Get.snackbar('Error', '$e', backgroundColor: Colors.red);
    }
  }

  void selectVariation(String namaVariasi, Map<String, dynamic> opsi) {
    selectedVariation[namaVariasi] = opsi;
    selectedVariation.refresh();
  }
}
