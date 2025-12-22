import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../controllers/cart_controller.dart';

class CartView extends GetView<CartController> {
  const CartView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Keranjang'),
        backgroundColor: Colors.amber,
      ),

      body: Obx(() {
        // ================= BELUM LOGIN =================
        if (!controller.isLogin.value) {
          return Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFFFFECB3),
                  Color(0xFFFFD54F),
                  Color(0xFFFFB300),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/login_first_vector.png',
                      width: 250,
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Silahkan login atau daftar terlebih dahulu untuk menggunakan fitur ini',
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 30),
                    FilledButton(
                      onPressed: () => Get.toNamed('/login'),
                      style: const ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(Colors.green),
                      ),
                      child: const Text(
                        'Login',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }

        // ================= KERANJANG KOSONG =================
        if (controller.products.isEmpty) {
          return const Center(child: Text('Keranjang masih kosong'));
        }

        // ================= LIST CART =================
        return ListView.builder(
          padding: const EdgeInsets.all(12),
          itemCount: controller.products.length,
          itemBuilder: (context, index) {
            final product = controller.products[index];
            final gambar = product['gambar'] as List;

            final String variasiDipilih = product['keterangan_order'];

            final listVariasiDipilih = variasiDipilih
                .split(';')
                .where((e) => e.isNotEmpty)
                .toList();
            // final variasi = product['variasi'];

            return Card(
              margin: const EdgeInsets.only(bottom: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 3,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // ================= GAMBAR =================
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.network(
                            gambar.first,
                            width: 80,
                            height: 80,
                            fit: BoxFit.cover,
                          ),
                        ),

                        const SizedBox(width: 10),

                        // ================= INFO =================
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                product['nama_produk'],
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),

                              const SizedBox(height: 4),

                              Text(
                                product['nama_reseller'],
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey,
                                ),
                              ),

                              const SizedBox(height: 10),

                              Text(
                                'Kuantitas : ${product['jumlah']}',
                                style: TextStyle(fontSize: 12),
                              ),

                              // Container(
                              //   decoration: BoxDecoration(
                              //     color: Color.fromRGBO(240, 240, 240, 1),
                              //     border: Border.all(color: Colors.amber),
                              //     borderRadius: BorderRadius.circular(8),
                              //   ),
                              //   child: Padding(
                              //     padding: const EdgeInsets.symmetric(
                              //       horizontal: 8.0,
                              //       vertical: 4,
                              //     ),
                              //     child: Text(product['jumlah'].toString()),
                              //   ),
                              // ),
                              const SizedBox(height: 4),

                              // ===== VARIASI TERPILIH =====
                              Text(
                                'Variasi dipilih:',
                                style: const TextStyle(fontSize: 12),
                              ),

                              ...List.generate(listVariasiDipilih.length, (
                                index,
                              ) {
                                if (listVariasiDipilih.isEmpty) {
                                  return SizedBox.shrink();
                                }

                                return Column(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(color: Colors.amber),
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(8),
                                        ),
                                        color: Color.fromRGBO(240, 240, 240, 1),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                          vertical: 2,
                                          horizontal: 8,
                                        ),
                                        child: Text(listVariasiDipilih[index]),
                                      ),
                                    ),

                                    const SizedBox(height: 4.5),
                                  ],
                                );
                              }),

                              // ===== GANTI VARIASI =====
                              // if (variasi != null && variasi.isNotEmpty)
                              //   Align(
                              //     alignment: Alignment.centerLeft,
                              //     child: TextButton(
                              //       onPressed: () {
                              //         controller.showVariasiPicker(
                              //           context,
                              //           product['id_penjualan_detail'],
                              //           variasi,
                              //         );
                              //       },
                              //       child: const Text(
                              //         'Ganti Variasi',
                              //         style: TextStyle(fontSize: 12),
                              //       ),
                              //     ),
                              //   ),
                              const SizedBox(height: 10),

                              Text(
                                NumberFormat.currency(
                                  locale: 'ID',
                                  symbol: 'Rp. ',
                                ).format(product['harga_jual']),
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),

                        // ================= DELETE =================
                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () {
                            controller.deleteProductCart(
                              product['id_penjualan_detail'],
                            );
                          },
                        ),
                      ],
                    ),
                  ),

                  Container(
                    width: double.infinity,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(12),
                        bottomRight: Radius.circular(12),
                      ),
                    ),
                    child: TextButton(
                      onPressed: () {
                        Get.toNamed(
                          '/checkout',
                          arguments: {
                            'nama_reseller': product['nama_reseller'],
                            'id_produk': product['id_produk'],
                            'id_reseller': product['id_reseller'],
                            'nama_produk': product['nama_produk'],
                            'jumlah': product['jumlah'].toString(),
                            'harga_jual': product['harga_jual'],
                            'keterangan_order': product['keterangan_order'],
                            'gambar': product['gambar'][0],
                            'satuan': product['satuan'],
                            'id_penjualan_detail':
                                product['id_penjualan_detail'],
                          },
                        );
                      },
                      child: const Text(
                        'Bayar',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      }),
    );
  }
}
