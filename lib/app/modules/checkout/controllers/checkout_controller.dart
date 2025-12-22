import 'package:barsel_ecommerce_flutter_application_alter/app/data/services/payment_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CheckoutController extends GetxController {
  // variabel produk
  final idProduk = ''.obs;
  final idReseller = ''.obs;
  final satuan = ''.obs;

  final idPenjualanDetail = RxnString();

  final eror = ''.obs;

  // variabel kurir
  final kurir = <Map<String, dynamic>>[].obs;
  final selectKurir = ''.obs;

  // variabel form
  final checkoutKeyForm = GlobalKey<FormState>();
  // text edit controller
  final namaPenerimaController = TextEditingController();
  final nomerTeleponController = TextEditingController();
  final alamatLengkapController = TextEditingController();

  //alamat
  final provinsi = '14';
  final kabupaten = '44';
  final selectKecamatan = '641'.obs;

  // variabel produk
  final namaReseller = ''.obs;
  final namaProduk = ''.obs;
  final jumlah = ''.obs;
  final hargaJual = 0.obs;
  final keteranganOrder = ''.obs;
  final gambar = ''.obs;
  final variasiDipilih = [].obs;

  // init class
  final _paymentService = PaymentService();

  @override
  void onInit() {
    super.onInit();
    loadKurir();
    loadUserData();

    final args = Get.arguments ?? {};

    print(args);

    idProduk.value = args['id_produk'];
    namaReseller.value = args['nama_reseller'];
    namaProduk.value = args['nama_produk'];
    jumlah.value = args['jumlah'];
    hargaJual.value = args['harga_jual'];
    keteranganOrder.value = args['keterangan_order'];
    gambar.value = args['gambar'];
    idReseller.value = args['id_reseller'];
    satuan.value = args['satuan'];

    // 🔥 INI PENTING
    if (args.containsKey('id_penjualan_detail')) {
      idPenjualanDetail.value = args['id_penjualan_detail'];
    } else {
      idPenjualanDetail.value = null;
    }

    variasiDipilih.value = keteranganOrder.value
        .split(';')
        .where((e) => e.isNotEmpty)
        .toList();
  }

  Future<void> loadKurir() async {
    try {
      final response = await _paymentService.fetchLokasiCOD();

      kurir.assignAll(List<Map<String, dynamic>>.from(response['data']));
    } catch (e) {
      Get.snackbar('Error', '$e', backgroundColor: Colors.red);
    }
  }

  Future<void> loadUserData() async {
    final prefs = await SharedPreferences.getInstance();

    namaPenerimaController.text = prefs.getString('username')!;
    nomerTeleponController.text = prefs.getString('phone_number')!;
    alamatLengkapController.text = prefs.getString('address')!;
    selectKecamatan.value = prefs.getString('subdistrict')!;
  }

  Future<void> checkout() async {
    // 🔥 VALIDASI FORM
    if (!checkoutKeyForm.currentState!.validate()) {
      Get.snackbar(
        'Error',
        'Lengkapi data penerima terlebih dahulu',
        backgroundColor: Colors.red,
      );
      return;
    }

    // 🔥 VALIDASI KURIR
    if (selectKurir.value.isEmpty) {
      Get.snackbar(
        'Error',
        'Silakan pilih lokasi COD terlebih dahulu',
        backgroundColor: Colors.red,
      );
      return;
    }

    final prefs = await SharedPreferences.getInstance();
    final idPembeli = prefs.getString('id_user')!;
    final idKecamatan = prefs.getString('subdistrict')!;

    try {
      final response = await _paymentService.checkout(
        idPembeli,
        idReseller.value,
        service,
        biayaOngkir.toString(),
        idKecamatan,
        alamatLengkapController.text,
        idProduk.value,
        jumlah.value,
        totalPembayaran.toString(),
        idPenjualanDetail: idPenjualanDetail.value,
        keteranganOrder: keteranganOrder.value,
        satuan: satuan.value,
      );

      if (response['status'] == true) {
        Get.snackbar(
          response['message'],
          'Silakan menyelesaikan pembayaran',
          backgroundColor: Colors.blue,
        );

        // 🔥 RESET STACK: HOME → BELUM BAYAR
        Get.offAllNamed('/home');
      } else {
        Get.snackbar('Error', response['message'], backgroundColor: Colors.red);
      }
    } catch (e) {
      eror.value = e.toString();
      Get.snackbar('Error', e.toString(), backgroundColor: Colors.red);
    }
  }

  int get biayaAdmin => 1500;

  int get biayaOngkir {
    if (selectKurir.value.isEmpty) return 0;

    final selected = kurir.firstWhereOrNull(
      (e) => e['id_cod'] == selectKurir.value,
    );

    if (selected == null) return 0;

    return int.tryParse(selected['biaya_cod'].toString()) ?? 0;
  }

  int get totalPembayaran {
    return hargaJual.value + biayaOngkir + biayaAdmin;
  }

  String get service {
    if (selectKurir.value.isEmpty) return '';

    final selected = kurir.firstWhereOrNull(
      (e) => e['id_cod'] == selectKurir.value,
    );

    if (selected == null) return '';

    return selected['nama_alamat'].toString();
  }
}
