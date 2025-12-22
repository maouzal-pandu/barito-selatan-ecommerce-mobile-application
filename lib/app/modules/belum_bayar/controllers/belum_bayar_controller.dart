import 'dart:io';

import 'package:barsel_ecommerce_flutter_application_alter/app/data/services/payment_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BelumBayarController extends GetxController {
  final isLogin = false.obs;
  final isLoading = false.obs;

  // transaksi
  final transaksi = <Map<String, dynamic>>[].obs;

  final _paymentService = PaymentService();
  final picker = ImagePicker();

  // id_penjualan => image path
  final RxMap<String, String> gambarBuktiPembayaran = <String, String>{}.obs;

  @override
  void onInit() {
    super.onInit();
    _initFunctions();
  }

  void _initFunctions() async {
    await loginCheck();
    fetchTransaksi();
  }

  Future<void> loginCheck() async {
    final prefs = await SharedPreferences.getInstance();
    isLogin.value = prefs.getBool('login') ?? false;
  }

  Future<void> fetchTransaksi() async {
    if (!isLogin.value) return;

    final prefs = await SharedPreferences.getInstance();
    final idKonsumen = prefs.getString('id_user')!;

    try {
      final response = await _paymentService.fetchTransaksiBelumBayar(
        idKonsumen,
      );

      if (response['status'] == true) {
        transaksi.assignAll(List<Map<String, dynamic>>.from(response['data']));
      } else {
        Get.snackbar('Error', response['message']);
      }
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }

  Future<void> pictureFromGallery(String idPenjualan) async {
    final image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      gambarBuktiPembayaran[idPenjualan] = image.path;
    }
  }

  Future<void> takePicture(String idPenjualan) async {
    final image = await picker.pickImage(source: ImageSource.camera);
    if (image != null) {
      gambarBuktiPembayaran[idPenjualan] = image.path;
    }
  }

  Future<void> uploadBuktiPembayaran(
    String idPenjualan,
    String totalTransfer,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    final namaPengirim = prefs.getString('fullname') ?? '-';

    if (!gambarBuktiPembayaran.containsKey(idPenjualan)) {
      debugPrint('❌ Tidak ada bukti pembayaran');
      return;
    }

    final imagePath = gambarBuktiPembayaran[idPenjualan]!;

    try {
      final response = await _paymentService.uploadBuktiPembayaran(
        idPenjualan: idPenjualan,
        namaPengirim: namaPengirim,
        totalTransfer: totalTransfer,
        imageFile: File(imagePath),
      );

      if (response['status'] == true) {
        Get.snackbar('Sukses', response['message']);
      } else {
        Get.snackbar('Gagal', response['message']);
      }
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }
}
