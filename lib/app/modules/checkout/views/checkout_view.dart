import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../controllers/checkout_controller.dart';

class CheckoutView extends GetView<CheckoutController> {
  const CheckoutView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('CheckoutView'), centerTitle: true),

      backgroundColor: Color.fromRGBO(240, 240, 240, 1),
      body: Obx(
        () => SingleChildScrollView(
          child: Form(
            key: controller.checkoutKeyForm,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  // Biodata penerima
                  Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFFFFF),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: Colors.grey.shade300),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 4),

                          const Text(
                            'Biodata Penerima',
                            style: TextStyle(fontSize: 16),
                            // textAlign: TextAlign.left,
                          ),

                          const SizedBox(height: 10),

                          // Nama penerima
                          Padding(
                            padding: const EdgeInsets.only(
                              // right: 8,
                              // left: 8,
                              bottom: 12,
                            ),
                            child: TextFormField(
                              controller: controller.namaPenerimaController,
                              decoration: const InputDecoration(
                                label: Text('Nama Penerima'),
                                border: OutlineInputBorder(),
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.always,
                              ),
                              validator: (value) => value!.isEmpty
                                  ? 'Nama penerima tidak boleh kosong'
                                  : null,
                            ),
                          ),

                          const SizedBox(height: 10),

                          // Nomer telepon
                          Padding(
                            padding: const EdgeInsets.only(
                              // right: 8,
                              // left: 8,
                              bottom: 12,
                            ),
                            child: TextFormField(
                              controller: controller.nomerTeleponController,
                              keyboardType: TextInputType.phone,
                              decoration: InputDecoration(
                                label: const Text('Nomor Telepon'),
                                prefixIcon: const Icon(Icons.phone_rounded),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                filled: true,
                                fillColor: Colors.grey[50],
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Nomor telepon tidak boleh kosong';
                                } else if (!RegExp(
                                  r'^08[1-9][0-9]{7,10}$',
                                ).hasMatch(value)) {
                                  return 'Nomor telepon tidak valid';
                                }
                                return null;
                              },
                            ),
                          ),

                          const SizedBox(height: 10),

                          // dropdown province
                          DropdownButtonFormField(
                            initialValue: controller.provinsi,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              label: const Text('Provinsi'),
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always,
                            ),
                            items: [
                              DropdownMenuItem(
                                value: "14",
                                child: const Text('Kalimantan Tengah'),
                              ),
                            ],
                            onChanged: (value) => controller.provinsi,
                            validator: (value) {
                              if (value == null) {
                                return 'Pilih provinsi terlebih dahulu';
                              }
                              return null;
                            },
                          ),

                          const SizedBox(height: 10),

                          // dropdown city / kabupaten
                          DropdownButtonFormField(
                            initialValue: controller.kabupaten,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              label: const Text('Kabupaten'),
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always,
                            ),
                            items: [
                              DropdownMenuItem(
                                value: "44",
                                child: const Text('Barito Selatan'),
                              ),
                            ],
                            onChanged: (value) {
                              controller.kabupaten;
                            },
                            validator: (value) {
                              if (value == null) {
                                return 'Pilih kecamatan terlebih dahulu';
                              }
                              return null;
                            },
                          ),

                          const SizedBox(height: 10),

                          // dropdown subdistrict
                          DropdownButtonFormField(
                            initialValue: controller.selectKecamatan.value,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              label: const Text('Kecamatana'),
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always,
                            ),
                            items: [
                              DropdownMenuItem(
                                value: "641",
                                child: const Text('Dusun Hilir'),
                              ),
                              DropdownMenuItem(
                                value: "642",
                                child: const Text('Dusun Selatan'),
                              ),
                              DropdownMenuItem(
                                value: "643",
                                child: const Text('Dusun Utara'),
                              ),
                              DropdownMenuItem(
                                value: "644",
                                child: const Text('Gunung Bintang Awai'),
                              ),
                              DropdownMenuItem(
                                value: "645",
                                child: const Text('Jenamas'),
                              ),
                              DropdownMenuItem(
                                value: "646",
                                child: const Text('Karau Kuala'),
                              ),
                            ],
                            onChanged: (value) {
                              controller.selectKecamatan.value = value!;
                            },
                            validator: (value) {
                              if (value == null) {
                                return 'Pilih kecamatan terlebih dahulu';
                              }
                              return null;
                            },
                          ),

                          const SizedBox(height: 10),

                          // alamat lengkap
                          Padding(
                            padding: const EdgeInsets.only(
                              // right: 8,
                              // left: 8,
                              // bottom: 12,
                            ),
                            child: TextFormField(
                              controller: controller.alamatLengkapController,
                              maxLines: 3,
                              decoration: InputDecoration(
                                label: const Text('Alamat lengkap'),
                                // hintText: 'contoh@email.com',
                                // prefixIcon: const Icon(Icons.home_rounded),
                                border: OutlineInputBorder(),
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.always,
                              ),
                              validator: (value) {
                                if (value!.isEmpty || value == '') {
                                  return 'Alamat lengkap tidak boleh kosong';
                                }

                                return null;
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 10),

                  // Produk
                  Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFFFFF),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: Colors.grey.shade300),
                    ),
                    child: Padding(
                      padding: EdgeInsetsGeometry.all(8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 4),

                          const Text(
                            'Produk ',
                            style: TextStyle(fontSize: 16),
                            // textAlign: TextAlign.left,
                          ),

                          const SizedBox(height: 10),

                          Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.network(
                                  controller.gambar.value,
                                  width: 80,
                                  height: 80,
                                  fit: BoxFit.cover,
                                ),
                              ),

                              const SizedBox(width: 10),

                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      controller.namaProduk.value,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),

                                    const SizedBox(height: 4),

                                    Text(
                                      controller.namaReseller.value,
                                      style: const TextStyle(
                                        fontSize: 12,
                                        color: Colors.grey,
                                      ),
                                    ),

                                    const SizedBox(height: 10),

                                    Text(
                                      'Kuantitas : ${controller.jumlah.value}',
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

                                    ...List.generate(
                                      controller.variasiDipilih.length,
                                      (index) {
                                        if (controller.variasiDipilih.isEmpty) {
                                          return SizedBox.shrink();
                                        }

                                        return Column(
                                          children: [
                                            Container(
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                  color: Colors.amber,
                                                ),
                                                borderRadius: BorderRadius.all(
                                                  Radius.circular(8),
                                                ),
                                                color: Color.fromRGBO(
                                                  240,
                                                  240,
                                                  240,
                                                  1,
                                                ),
                                              ),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                      vertical: 2,
                                                      horizontal: 8,
                                                    ),
                                                child: Text(
                                                  controller
                                                      .variasiDipilih[index],
                                                ),
                                              ),
                                            ),

                                            const SizedBox(height: 4.5),
                                          ],
                                        );
                                      },
                                    ),

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
                                  ],
                                ),
                              ),

                              // const Spacer(),
                              Text(
                                NumberFormat.currency(
                                  locale: 'ID',
                                  symbol: 'Rp. ',
                                ).format(controller.hargaJual.value).toString(),
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 10),

                  // Kurir
                  Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFFFFF),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: Colors.grey.shade300),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 5),

                          const Text(
                            'Pilih Lokasi COD',
                            style: TextStyle(fontSize: 16),
                          ),

                          const SizedBox(height: 5),

                          ...List.generate(controller.kurir.length, (index) {
                            final kurir = controller.kurir[index];
                            final biayaCOD = int.tryParse(kurir['biaya_cod']);

                            return InkWell(
                              onTap: () => controller.selectKurir.value =
                                  kurir['id_cod'],
                              child: Card(
                                color:
                                    controller.selectKurir.value ==
                                        kurir['id_cod']
                                    ? Colors.amber
                                    : Colors.white,
                                child: Padding(
                                  padding: EdgeInsetsGeometry.all(12),
                                  child: Row(
                                    children: [
                                      Text(kurir['nama_alamat']),
                                      Spacer(),
                                      Text(
                                        NumberFormat.currency(
                                          locale: 'ID',
                                          symbol: 'Rp. ',
                                        ).format(biayaCOD).toString(),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 10),

                  // Total
                  Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFFFFF),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: Colors.grey.shade300),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Table(
                        columnWidths: const {
                          0: FlexColumnWidth(),
                          1: IntrinsicColumnWidth(),
                        },
                        children: [
                          TableRow(
                            children: [
                              const Padding(
                                padding: EdgeInsets.symmetric(vertical: 4),
                                child: Text('Harga Produk'),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 4,
                                ),
                                child: Text(
                                  NumberFormat.currency(
                                    locale: 'ID',
                                    symbol: 'Rp. ',
                                  ).format(controller.hargaJual.value),
                                  textAlign: TextAlign.right,
                                ),
                              ),
                            ],
                          ),

                          TableRow(
                            children: [
                              const Padding(
                                padding: EdgeInsets.symmetric(vertical: 4),
                                child: Text('Biaya Ongkir'),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 4,
                                ),
                                child: Text(
                                  NumberFormat.currency(
                                    locale: 'ID',
                                    symbol: 'Rp. ',
                                  ).format(controller.biayaOngkir),
                                  textAlign: TextAlign.right,
                                ),
                              ),
                            ],
                          ),

                          TableRow(
                            children: [
                              const Padding(
                                padding: EdgeInsets.symmetric(vertical: 4),
                                child: Text('Biaya Admin'),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 4,
                                ),
                                child: Text(
                                  NumberFormat.currency(
                                    locale: 'ID',
                                    symbol: 'Rp. ',
                                  ).format(controller.biayaAdmin),
                                  textAlign: TextAlign.right,
                                ),
                              ),
                            ],
                          ),

                          const TableRow(children: [Divider(), Divider()]),

                          TableRow(
                            children: [
                              const Padding(
                                padding: EdgeInsets.symmetric(vertical: 6),
                                child: Text(
                                  'Total Pembayaran',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 6,
                                ),
                                child: Text(
                                  NumberFormat.currency(
                                    locale: 'ID',
                                    symbol: 'Rp. ',
                                  ).format(controller.totalPembayaran),
                                  textAlign: TextAlign.right,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 25),

                  // Bayar button
                  SizedBox(
                    width: double.infinity,
                    child: TextButton(
                      onPressed: () => controller.checkout(),
                      style: ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(Colors.amber),
                      ),
                      child: const Text(
                        'Bayar',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),

                  Text(controller.eror.value),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
