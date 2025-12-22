import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/menunggu_konfirmasi_controller.dart';

class MenungguKonfirmasiView extends GetView<MenungguKonfirmasiController> {
  const MenungguKonfirmasiView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Menunggu Konfirmasi'),
        centerTitle: true,
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.transaksi.isEmpty) {
          return const Center(child: Text('Tidak ada transaksi'));
        }

        return ListView.builder(
          itemCount: controller.transaksi.length,
          itemBuilder: (context, index) {
            final item = controller.transaksi[index];

            return Card(
              margin: const EdgeInsets.all(8),
              child: ListTile(
                title: Text('ID Penjualan: ${item['id_penjualan']}'),
                subtitle: Text('Total: ${item['total_transfer'] ?? '-'}'),
                trailing: ElevatedButton(
                  onPressed: () {
                    controller.konfirmasiPembayaran(
                      item['id_penjualan'].toString(),
                    );
                  },
                  child: const Text('Konfirmasi'),
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
