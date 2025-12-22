import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/belum_bayar_controller.dart';
import 'package:intl/intl.dart';

class BelumBayarView extends GetView<BelumBayarController> {
  const BelumBayarView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Belum Dibayar'),
        centerTitle: true,
        backgroundColor: Colors.amber,
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator(color: Colors.amber),
          );
        }

        if (!controller.isLogin.value) {
          return const Center(child: Text('Silakan login'));
        }

        if (controller.transaksi.isEmpty) {
          return const Center(child: Text('Tidak ada transaksi'));
        }

        return ListView.builder(
          padding: const EdgeInsets.all(12),
          itemCount: controller.transaksi.length,
          itemBuilder: (context, index) {
            final item = controller.transaksi[index];

            final ongkir = int.parse(item['ongkir']);
            final feeAdmin = int.parse(item['fee_admin']);
            final total = int.tryParse(item['harga_jual'])!;

            final hargaProduk = total - ongkir - feeAdmin;

            final idPenjualan = item['id_penjualan'].toString();

            return Card(
              elevation: 4,
              margin: const EdgeInsets.only(bottom: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Kode transaksi
                    Text(
                      item['kode_transaksi'],
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),

                    const SizedBox(height: 6),

                    Text('Service: ${item['service']}'),
                    Text('Kurir: ${item['kurir']}'),
                    Text(
                      'Tanggal: ${DateFormat('dd MMM yyyy, HH:mm').format(DateTime.parse(item['waktu_transaksi']))}',
                    ),

                    const Divider(height: 20),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Ongkir'),
                        Text('Rp ${ongkir.toString()}'),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Biaya Admin'),
                        Text('Rp ${feeAdmin.toString()}'),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Harga Produk'),
                        Text('Rp ${hargaProduk.toString()}'),
                      ],
                    ),

                    const SizedBox(height: 8),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Total Bayar',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'Rp $total',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.red,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 12),

                    Obx(
                      () =>
                          controller.gambarBuktiPembayaran.containsKey(
                            idPenjualan,
                          )
                          ? Container(
                              width: double.infinity,
                              margin: const EdgeInsets.only(bottom: 12),
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                border: Border.all(),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Row(
                                children: [
                                  const Icon(Icons.image_rounded),

                                  const SizedBox(width: 8),

                                  Expanded(
                                    child: Text(
                                      controller
                                          .gambarBuktiPembayaran[idPenjualan]!
                                          .split('/')
                                          .last,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),

                                  IconButton(
                                    onPressed: () {
                                      controller.gambarBuktiPembayaran.remove(
                                        idPenjualan,
                                      );
                                    },
                                    icon: const Icon(
                                      Icons.delete_forever_rounded,
                                      color: Colors.red,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : const SizedBox.shrink(),
                    ),

                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.amber,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        onPressed: () {
                          showModalBottomSheet(
                            context: context,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(
                                top: Radius.circular(16),
                              ),
                            ),
                            builder: (context) {
                              return SafeArea(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const SizedBox(height: 12),
                                    const Text(
                                      'Pilih sumber foto',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),

                                    const Divider(),

                                    ListTile(
                                      leading: const Icon(Icons.camera_alt),
                                      title: const Text('Kamera'),
                                      onTap: () {
                                        Navigator.pop(context);
                                        controller.takePicture(idPenjualan);
                                      },
                                    ),

                                    ListTile(
                                      leading: const Icon(Icons.photo),
                                      title: const Text('Galeri'),
                                      onTap: () {
                                        Navigator.pop(context);
                                        controller.pictureFromGallery(
                                          idPenjualan,
                                        );
                                      },
                                    ),

                                    const SizedBox(height: 12),
                                  ],
                                ),
                              );
                            },
                          );
                        },

                        child: const Text(
                          'Upload Bukti Pembayaran',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ),

                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          controller.uploadBuktiPembayaran(
                            idPenjualan,
                            total.toString(),
                          );
                        },
                        style: ButtonStyle(
                          backgroundColor: WidgetStatePropertyAll(Colors.amber),
                        ),
                        child: const Text(
                          'Konfirmasi',
                          style: TextStyle(color: Colors.black),
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
