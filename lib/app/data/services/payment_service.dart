import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

class PaymentService {
  final url = 'http://192.168.1.2/umkm_barsel/payment';

  Future<Map<String, dynamic>> fetchLokasiCOD() async {
    try {
      final response = await http.post(Uri.parse('$url/fetchKurir'));
      return jsonDecode(response.body);
    } catch (e) {
      throw Exception('error : $e');
    }
  }

  Future<Map<String, dynamic>> checkout(
    String idPembeli,
    String idPenjual,
    String service,
    String ongkirService,
    String idKecamatan,
    String alamat,
    String idProduk,
    String jumlah,
    String hargaJual, {
    String? idPenjualanDetail,
    String? satuan,
    String? keteranganOrder,
  }) async {
    try {
      final Map<String, String> body = {
        'id_pembeli': idPembeli,
        'id_penjual': idPenjual,
        'service': service,
        'ongkir_service': ongkirService,
        'id_kecamatan': idKecamatan,
        'alamat': alamat,
        'id_produk': idProduk,
        'jumlah': jumlah,
        'harga_jual': hargaJual,
      };

      // 🔥 OPTIONAL FIELD (WAJIB pakai IF)
      if (satuan != null) {
        body['satuan'] = satuan;
      }

      if (keteranganOrder != null) {
        body['keterangan_order'] = keteranganOrder;
      }

      if (idPenjualanDetail != null) {
        body['id_penjualan_detail'] = idPenjualanDetail;
      }

      final response = await http.post(Uri.parse('$url/checkout'), body: body);

      return jsonDecode(response.body);
    } catch (e) {
      throw Exception('Error : $e');
    }
  }

  Future<Map<String, dynamic>> fetchTransaksiBelumBayar(
    String idKonsumen,
  ) async {
    try {
      final response = await http.get(
        Uri.parse(
          '$url/fetchNotYetPaidTransactionUser?id_konsumen=$idKonsumen',
        ),
      );

      return jsonDecode(response.body);
    } catch (e) {
      throw Exception('Error : $e');
    }
  }

  // =========================================================
  // 🔥 UPLOAD BUKTI PEMBAYARAN
  // =========================================================
  Future<Map<String, dynamic>> uploadBuktiPembayaran({
    required String idPenjualan,
    required String namaPengirim,
    required String totalTransfer,
    required File imageFile,
  }) async {
    try {
      final request = http.MultipartRequest(
        'POST',
        Uri.parse('$url/konfirmasiPembayaran'),
      );

      // text fields
      request.fields['id_penjualan'] = idPenjualan;
      request.fields['nama_pengirim'] = namaPengirim;
      request.fields['total_transfer'] = totalTransfer;

      // file field
      request.files.add(
        await http.MultipartFile.fromPath('bukti_transfer', imageFile.path),
      );

      // send request
      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      return jsonDecode(response.body);
    } catch (e) {
      throw Exception('Upload error : $e');
    }
  }

  Future<Map<String, dynamic>> fetchMenungguKonfirmasi(String idPenjual) async {
    try {
      final response = await http.get(
        Uri.parse('$url/fetchMenungguKonfirmasi?id_penjual=$idPenjual'),
      );

      return jsonDecode(response.body);
    } catch (e) {
      throw Exception('Error : $e');
    }
  }

  Future<Map<String, dynamic>> konfirmasiPembayaranAdmin(
    String idPenjualan,
  ) async {
    try {
      final response = await http.post(
        Uri.parse('$url/konfirmasiPembayaranAdmin'),
        body: {'id_penjualan': idPenjualan},
      );

      return jsonDecode(response.body);
    } catch (e) {
      throw Exception('Error : $e');
    }
  }

  Future<Map<String, dynamic>> fetchTransaksiDikirim(String idPembeli) async {
    try {
      final response = await http.get(
        Uri.parse('$url/fetchTransaksiDikirim?id_pembeli=$idPembeli'),
      );
      return jsonDecode(response.body);
    } catch (e) {
      throw Exception('Error : $e');
    }
  }

  Future<Map<String, dynamic>> konfirmasiProdukDiterima(
    String idPenjualan,
  ) async {
    try {
      final response = await http.post(
        Uri.parse('$url/konfirmasiProdukDiterima'),
        body: {'id_penjualan': idPenjualan},
      );
      return jsonDecode(response.body);
    } catch (e) {
      throw Exception('Error : $e');
    }
  }
}
