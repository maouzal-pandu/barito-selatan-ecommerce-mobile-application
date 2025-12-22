import 'package:barsel_ecommerce_flutter_application_alter/app/data/services/payment_service.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MenungguKonfirmasiController extends GetxController {
  final transaksi = <Map<String, dynamic>>[].obs;
  final isLoading = false.obs;

  final _paymentService = PaymentService();

  @override
  void onInit() {
    super.onInit();
    fetchTransaksi();
  }

  Future<void> fetchTransaksi() async {
    try {
      isLoading.value = true;

      final prefs = await SharedPreferences.getInstance();
      final idPenjual = prefs.getString('id_user'); // asumsi penjual login

      if (idPenjual == null) {
        Get.snackbar('Error', 'ID Penjual tidak ditemukan');
        return;
      }

      final response = await _paymentService.fetchMenungguKonfirmasi(idPenjual);

      if (response['status'] == true) {
        transaksi.assignAll(List<Map<String, dynamic>>.from(response['data']));
      } else {
        transaksi.clear();
      }
    } catch (e) {
      Get.snackbar('Error', '$e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> konfirmasiPembayaran(String idPenjualan) async {
    try {
      final response = await _paymentService.konfirmasiPembayaranAdmin(
        idPenjualan,
      );

      if (response['status'] == true) {
        Get.snackbar('Sukses', response['message']);
        fetchTransaksi();
      } else {
        Get.snackbar('Error', response['message']);
      }
    } catch (e) {
      Get.snackbar('Error', '$e');
    }
  }
}
