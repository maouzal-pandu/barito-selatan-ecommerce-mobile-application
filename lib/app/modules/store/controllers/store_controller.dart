import 'package:barsel_ecommerce_flutter_application_alter/app/data/services/store_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StoreController extends GetxController {
  final resellerId = ''.obs;
  final resellerInformation = {}.obs;
  final isLoading = false.obs;
  final resellerProducts = <Map<dynamic, String>>[];

  final _storeService = StoreService();

  final scrollController = ScrollController();

  @override
  void onInit() async {
    super.onInit();
    resellerId.value = await Get.arguments;
    loadStore();
  }

  Future<void> loadStore() async {
    try {
      isLoading.value = true;

      final response = await _storeService.fetchStore(resellerId.value);

      if (response['status'] == true) {
        resellerInformation.assignAll(response['data']);
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
}
