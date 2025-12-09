import 'package:barsel_ecommerce_flutter_application_alter/app/data/services/item_service.dart';
import 'package:barsel_ecommerce_flutter_application_alter/app/data/services/store_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class StoreController extends GetxController {
  final resellerId = ''.obs;
  final resellerInformation = {}.obs;
  final storeProfilePicture = ''.obs;
  final storePhoneNumber = ''.obs;

  final isLoading = false.obs;
  final isLoadingMoreProducts = false.obs;

  final resellerProducts = <Map<String, dynamic>>[].obs;
  final resellerProductCategory = <Map<String, dynamic>>[].obs;

  final storeIndex = 1.obs;

  final _storeService = StoreService();
  final _itemService = ItemsService();

  final scrollController = ScrollController();
  final currentProductPage = 0.obs;
  final totalProductPage = 0.obs;

  final storeProducts = <Map<String, dynamic>>[].obs;

  @override
  void onInit() async {
    super.onInit();
    resellerId.value = await Get.arguments;
    loadStore();
    loadStoreProducts();
    fetchStoreProductsCategory();

    scrollController.addListener(() {
      if (scrollController.position.pixels >=
              scrollController.position.maxScrollExtent - 25 &&
          !isLoadingMoreProducts.value &&
          currentProductPage.value < totalProductPage.value) {
        loadMoreProducts();
      }
    });
  }

  Future<void> loadStore() async {
    try {
      isLoading.value = true;

      final response = await _storeService.fetchStore(resellerId.value);

      if (response['status'] == true) {
        resellerInformation.assignAll(response['data']);
        storeProfilePicture.value = resellerInformation['foto'] ?? '';
        storePhoneNumber.value = resellerInformation['no_telpon'];
      } else {
        Get.snackbar(
          'Gagal memuat toko',
          response['message'],
          backgroundColor: Colors.red,
        );
      }
    } catch (e) {
      Get.snackbar('Error', '$e', backgroundColor: Colors.red);
    } finally {
      isLoading.value = false;
    }
  }

  void changeStoreIndex(int page) {
    if (storeIndex.value != page) {
      storeIndex.value = page;
    }
  }

  Future<void> loadStoreProducts() async {
    try {
      isLoading.value = true;

      final response = await _itemService.storeProduct(resellerId.value);

      if (response['status'] == true) {
        currentProductPage.value = 1;
        totalProductPage.value = response['total_pages'];

        storeProducts.addAll(List<Map<String, dynamic>>.from(response['data']));
      } else {
        Get.snackbar('Error', response['message'], backgroundColor: Colors.red);
      }
    } catch (e) {
      Get.snackbar('Error', '$e', backgroundColor: Colors.red);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> loadMoreProducts() async {
    try {
      // isLoading.value = true;
      currentProductPage.value++;

      final response = await _itemService.storeProduct(
        resellerId.value,
        page: currentProductPage.value,
      );

      if (response['status'] == true) {
        storeProducts.addAll(List<Map<String, dynamic>>.from(response['data']));
      } else {
        Get.snackbar('Error', response['message'], backgroundColor: Colors.red);
      }
    } catch (e) {
      Get.snackbar('Error', '$e', backgroundColor: Colors.red);
    } finally {
      // isLoading.value = false;
    }
  }

  Future<void> fetchStoreProductsCategory() async {
    try {
      final response = await _itemService.storeProductCategory(
        resellerId.value,
      );

      if (response['status'] == true) {
        resellerProductCategory.addAll(
          List<Map<String, dynamic>>.from(response['data']),
        );
      } else {
        Get.snackbar(
          'Gagal',
          'Gagal mengambil kategori produk toko',
          backgroundColor: Colors.red,
        );
      }
    } catch (e) {
      Get.snackbar('Error', '$e', backgroundColor: Colors.red);
    } finally {
      // laoding
    }
  }

  void openWhatsapp() async {
    final url = Uri.parse(
      'https://api.whatsapp.com/send?phone=${storePhoneNumber.value}',
    );

    // final url = Uri.parse('https://api.whatsapp.com/send?phone=6287788671514');

    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    } else {
      Get.snackbar('Gagal', 'Tidak dapat membuka Whatsapp');
    }
  }
}
