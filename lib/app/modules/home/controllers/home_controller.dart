import 'package:barsel_ecommerce_flutter_application_alter/app/data/services/item_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';

class HomeController extends GetxController {
  final isLogin = false.obs;
  final username = ''.obs;
  final profilePicture = ''.obs;
  final idReseller = ''.obs;

  final _itemService = ItemsService();

  final products = <Map<String, dynamic>>[].obs;

  final currentProductPage = 0.obs;

  final isLoading = false.obs;
  final isLoadingMoreProducts = false.obs;

  final totalProductPage = 0.obs;

  final scrollController = ScrollController();

  @override
  void onInit() {
    super.onInit();
    checkLogin();

    loadProducts();

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

      currentProductPage.value = 1;

      final result = await _itemService.fetchProducts(
        page: currentProductPage.value,
      );

      print(result);

      if (result['status'] == true) {
        products.assignAll(result['data']);
        totalProductPage.value = result['total_page'];
      }
    } catch (e) {
      Get.showSnackbar(
        GetSnackBar(
          backgroundColor: const Color(0xFFD10000),
          title: "Failed to fetch products",
          message: '$e',
          duration: const Duration(seconds: 3),
        ),
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> loadMoreProducts() async {
    try {
      isLoadingMoreProducts.value = true;
      currentProductPage.value++;

      final result = await _itemService.fetchProducts(
        page: currentProductPage.value,
      );

      if (result['status'] == true) {
        products.addAll(result['data']);
      }
    } catch (e) {
      print("Error loading more: $e");
    } finally {
      isLoadingMoreProducts.value = false;
    }
  }

  void checkLogin() async {
    final prefs = await SharedPreferences.getInstance();

    isLogin.value = prefs.getBool('login') ?? false;

    if (isLogin.value == true) {
      username.value = prefs.getString('username') ?? 'null';
      profilePicture.value = prefs.getString('profile_picture') ?? '';
      idReseller.value = prefs.getString('id_reseller')!;
    }
  }

  void logout() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.clear();

    isLogin.value = false;

    Phoenix.rebirth(Get.context!);
  }
}
