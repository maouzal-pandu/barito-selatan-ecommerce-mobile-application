import 'package:barsel_ecommerce_flutter_application_alter/app/data/services/user_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WishlistController extends GetxController {
  final isLogin = false.obs;

  final products = <Map<String, dynamic>>[].obs;

  final isLoadingMoreProducts = false.obs;
  final currentProductPage = 0.obs;
  final totalProductPage = 0.obs;

  final _userService = UserService();

  final scrollController = ScrollController();

  @override
  void onInit() {
    super.onInit();
    _initFunc();

    scrollController.addListener(() {
      if (scrollController.position.pixels >=
              scrollController.position.maxScrollExtent - 25 &&
          !isLoadingMoreProducts.value &&
          currentProductPage.value < totalProductPage.value) {
        loadMoreProducts();
      }
    });
  }

  Future<void> _initFunc() async {
    await loginCheck();
    loadProduct();
  }

  Future<void> loginCheck() async {
    final prefs = await SharedPreferences.getInstance();

    isLogin.value = prefs.getBool('login') ?? false;
  }

  Future<void> loadProduct() async {
    if (isLogin.value) {
      try {
        final prefs = await SharedPreferences.getInstance();
        final consumerId = prefs.getString('id_user')!;

        final response = await _userService.fetchUserWishlistItems(consumerId);

        if (response['status'] == true) {
          totalProductPage.value = response['total_pages'];
          currentProductPage.value = 1;

          products.addAll(List<Map<String, dynamic>>.from(response['data']));
        } else {
          Get.snackbar('Gagal mengambil wishlist', response['message']);
        }
      } catch (e) {
        Get.snackbar('Gagal Mengambil Wishlist', '$e');
        print(e);
      }
    }
  }

  Future<void> loadMoreProducts() async {
    if (isLogin.value) {
      try {
        currentProductPage.value++;
        isLoadingMoreProducts.value = true;

        final prefs = await SharedPreferences.getInstance();
        final consumerId = prefs.getString('id_user')!;

        final response = await _userService.fetchUserWishlistItems(
          consumerId,
          page: currentProductPage.value,
        );

        if (response['status'] == true) {
          products.addAll(List<Map<String, dynamic>>.from(response['data']));
        } else {
          Get.snackbar(
            'Gagal',
            response['message'],
            backgroundColor: Colors.red,
          );
        }
      } catch (e) {
        Get.snackbar('Error', '$e', backgroundColor: Colors.red);
      } finally {
        isLoadingMoreProducts.value = false;
      }
    }
  }
}
