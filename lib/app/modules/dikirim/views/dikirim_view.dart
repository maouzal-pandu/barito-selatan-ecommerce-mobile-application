import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/dikirim_controller.dart';

class DikirimView extends GetView<DikirimController> {
  const DikirimView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pesanan Dikirim'), centerTitle: true),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.transaksi.isEmpty) {
          return const Center(child: Text('Tidak ada pesanan dikirim'));
        }

        return ListView.builder(
          padding: const EdgeInsets.all(12),
          itemCount: controller.transaksi.length,
          itemBuilder: (context, index) {
            final item = controller.transaksi[index];
            final idPenjualan = item['id_penjualan'].toString();

            return Card(
              elevation: 3,
              margin: const EdgeInsets.only(bottom: 12),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item['kode_transaksi'],
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),

                    const SizedBox(height: 6),
                    Text('Kurir: ${item['kurir']}'),
                    Text('Service: ${item['service']}'),

                    const SizedBox(height: 12),

                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          controller.produkDiterima(idPenjualan);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                        ),
                        child: const Text(
                          'Produk Telah Diterima',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
