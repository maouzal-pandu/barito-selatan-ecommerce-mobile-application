import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../data/services/payment_service.dart';

class DikirimController extends GetxController {
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
      final idPembeli = prefs.getString('id_user');

      if (idPembeli == null) return;

      final response = await _paymentService.fetchTransaksiDikirim(idPembeli);

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

  Future<void> produkDiterima(String idPenjualan) async {
    try {
      final response = await _paymentService.konfirmasiProdukDiterima(
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
