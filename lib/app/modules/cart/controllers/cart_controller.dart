import 'package:barsel_ecommerce_flutter_application_alter/app/data/services/item_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartController extends GetxController {
  final isLogin = false.obs;

  // ===== USER =====
  final idKonsumen = ''.obs;

  // ===== CART PRODUCTS =====
  final products = <Map<String, dynamic>>[].obs;

  // ===== SERVICE =====
  final _itemService = ItemsService();

  @override
  void onInit() {
    super.onInit();
    _initFunctions();
  }

  Future<void> _initFunctions() async {
    await checkLogin();
    if (isLogin.value) {
      await fetchCartProducts();
    }
  }

  // ================= LOGIN =================
  Future<void> checkLogin() async {
    final prefs = await SharedPreferences.getInstance();

    isLogin.value = prefs.getBool('login') ?? false;

    if (isLogin.value) {
      idKonsumen.value = prefs.getString('id_user') ?? '';
    }
  }

  // ================= FETCH CART =================
  Future<void> fetchCartProducts() async {
    try {
      final response = await _itemService.fetchCartProducts(idKonsumen.value);

      if (response['status'] == true) {
        products.assignAll(List<Map<String, dynamic>>.from(response['data']));
        print(response);
      } else {
        products.clear();
        Get.snackbar('Info', response['message']);
      }
    } catch (e) {
      Get.snackbar('Error', e.toString(), backgroundColor: Colors.red);
    }
  }

  // ================= VARIASI FORMAT (OPTIONAL) =================
  String formatVariasi(dynamic variasi) {
    if (variasi is Map<String, dynamic>) {
      return variasi.entries
          .map((e) => '${e.key}: ${e.value.first['value']}')
          .join(', ');
    }
    return '';
  }

  // ================= UPDATE VARIASI =================
  Future<void> updateVariasiCart(
    String idPenjualanDetail,
    String variasi,
    int hargaTambahan,
  ) async {
    try {
      // final response = await _itemService.updateCartVariasi(
      //   idPenjualanDetail,
      //   variasi,
      //   hargaTambahan,
      // );

      // if (response['status'] == true) {
      //   await fetchCartProducts(); // 🔥 refresh cart
      //   Get.snackbar('Berhasil', response['message']);
      // } else {
      //   Get.snackbar('Gagal', response['message'], backgroundColor: Colors.red);
      // }
    } catch (e) {
      Get.snackbar('Error', e.toString(), backgroundColor: Colors.red);
    }
  }

  // ================= DELETE CART ITEM =================
  Future<void> deleteProductCart(String idPenjualanDetail) async {
    try {
      final response = await _itemService.deleteCartProduct(idPenjualanDetail);

      if (response['status'] == true) {
        await fetchCartProducts(); // 🔥 refresh cart
        Get.snackbar('Berhasil', response['message']);
      } else {
        Get.snackbar('Gagal', response['message'], backgroundColor: Colors.red);
      }
    } catch (e) {
      Get.snackbar('Error', e.toString(), backgroundColor: Colors.red);
    }
  }

  // ================= VARIASI PICKER =================
  void showVariasiPicker(
    BuildContext context,
    String idPenjualanDetail,
    Map<String, dynamic> variasi,
  ) {
    final selected = <String>[].obs;

    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Obx(
          () => Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Pilih Variasi',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),

              ...variasi.entries.map((entry) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      entry.key,
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 6),

                    Wrap(
                      spacing: 8,
                      children: entry.value.map<Widget>((item) {
                        final value = item['value'];

                        final isSelected = selected.contains(value);

                        return ChoiceChip(
                          label: Text(value),
                          selected: isSelected,
                          onSelected: (val) {
                            if (val) {
                              selected.add(value);
                            } else {
                              selected.remove(value);
                            }
                          },
                        );
                      }).toList(),
                    ),

                    const SizedBox(height: 12),
                  ],
                );
              }).toList(),

              const SizedBox(height: 20),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.amber,
                  ),
                  onPressed: () {
                    final result = selected.join(';');

                    updateVariasiCart(idPenjualanDetail, '$result;', 0);

                    Get.back();
                  },
                  child: const Text(
                    'Simpan Variasi',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
