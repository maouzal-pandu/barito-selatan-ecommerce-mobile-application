import 'package:barsel_ecommerce_flutter_application_alter/app/data/services/user_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyStoreController extends GetxController {
  final isLogin = false.obs;
  final haveStore = false.obs;
  final userId = ''.obs;
  final storeName = ''.obs;
  final storeProfilePicture = ''.obs;

  // first time load boolean
  final isLoading = false.obs;

  // load more store prodects
  final isLoadingMoreProducts = false.obs;

  final _userServices = UserService();
  final products = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    getStoreInfo();
  }

  Future<void> getStoreInfo() async {
    final prefs = await SharedPreferences.getInstance();
    isLogin.value = prefs.getBool('login')!;

    if (isLogin.value) {
      try {
        isLoading.value = true;
        userId.value = prefs.getString('id_user')!;

        final response = await _userServices.getUserStore(userId.value);

        if (response['status'] == true && response['have_store'] == true) {
          haveStore.value = true;
          prefs.setBool('is_have_store', haveStore.value);
          final data = response['data'];
          storeName.value = data['nama_reseller'];
          storeProfilePicture.value = data['foto'] ?? '';

          prefs.setString('reseller_id', data['id_reseller']);
          prefs.setString('store_name', data['nama_reseller']);
          prefs.setString('subdistrict_id', data['kecamatan_id']);
          prefs.setString('city_id', data['kota_id']);
          prefs.setString('province_id', data['provinsi_id']);
          prefs.setString('store_address', data['alamat_lengkap']);
          prefs.setString('store_phone_number', data['no_telpon']);
          prefs.setString('bank_name', data['nama_bank']);
          prefs.setString('bank_number', data['norek_bank']);
          prefs.setString('bank_owner', data['an_bank']);
          prefs.setString('store_about', data['keterangan'] ?? '');
          prefs.setString('store_picture', data['foto'] ?? '');
          prefs.setString('regist_date', data['tanggal_daftar']);

          // print(response['data']);
        } else if (response['status'] == true &&
            response['have_store'] == false) {
          haveStore.value = false;
          prefs.setBool('is_have_store', haveStore.value);
        } else {
          Get.snackbar('Gagal', response['message']);
          prefs.setBool('is_have_store', haveStore.value);
        }
      } catch (e) {
        Get.snackbar('Error', '$e', backgroundColor: Colors.redAccent);
      } finally {
        isLoading.value = false;
      }
    }
  }

  Future<void> storeProducts() async {
    try {
      isLoadingMoreProducts.value = true;
    } catch (e) {
      Get.snackbar('Error', '$e', backgroundColor: Colors.redAccent);
    } finally {
      isLoadingMoreProducts.value = false;
    }
  }
}
