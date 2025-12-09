import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../controllers/store_controller.dart';

class StoreView extends GetView<StoreController> {
  const StoreView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(240, 240, 240, 1),

      appBar: AppBar(backgroundColor: Colors.amber),

      body: Obx(
        () => controller.isLoading.value
            ? Center(child: CircularProgressIndicator())
            : Column(
                children: [
                  // Store profile picture, store name and chat button
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.amber, Colors.amber[800]!],
                        begin: AlignmentGeometry.topCenter,
                        end: AlignmentGeometry.bottomCenter,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              // profile picture
                              Obx(
                                () => CircleAvatar(
                                  radius: 22.5,
                                  backgroundColor: Colors.grey[200],
                                  child:
                                      !controller.storeProfilePicture.value
                                              .endsWith('null') &&
                                          controller
                                              .storeProfilePicture
                                              .value
                                              .isNotEmpty
                                      ? ClipOval(
                                          child: Image.network(
                                            controller
                                                .resellerInformation['foto'],
                                            height: double.infinity,
                                            width: double.infinity,
                                            fit: BoxFit.cover,
                                            errorBuilder:
                                                (context, error, stackTrace) {
                                                  return Icon(
                                                    Icons.store_rounded,
                                                    color: Colors.amber,
                                                    size: 24,
                                                  );
                                                },
                                          ),
                                        )
                                      : Icon(
                                          Icons.store_rounded,
                                          color: Colors.amber,
                                          size: 24,
                                        ),
                                ),
                              ),

                              const SizedBox(width: 10),

                              // store name
                              Obx(
                                () => Text(
                                  controller
                                          .resellerInformation['nama_reseller'] ??
                                      '',
                                ),
                              ),

                              const Spacer(),

                              // Wa chat button
                              FilledButton.icon(
                                onPressed: () => controller.openWhatsapp(),
                                label: const Text(
                                  'Whatsapp',
                                  style: TextStyle(fontSize: 12),
                                ),
                                icon: Image.asset(
                                  height: 30,
                                  width: 30,
                                  'assets/images/whatsapp-icon.png',
                                ),
                                style: ButtonStyle(
                                  backgroundColor: WidgetStatePropertyAll(
                                    Colors.green[700],
                                  ),
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 15),

                          // Container(
                          //   decoration: BoxDecoration(
                          //     borderRadius: const BorderRadius.vertical(
                          //       top: Radius.circular(25),
                          //     ),
                          //     gradient: const LinearGradient(
                          //       begin: Alignment.topCenter,
                          //       end: Alignment.center,
                          //       colors: [
                          //         Color(0xFFFFFFFF),
                          //         Color.fromRGBO(240, 240, 240, 1),
                          //       ],
                          //     ),
                          //   ),
                          //   child: Padding(
                          //     padding: const EdgeInsets.all(8.0),
                          //     child: Column(
                          //       children: [
                          //         GridView.builder(
                          //           gridDelegate:
                          //               const SliverGridDelegateWithFixedCrossAxisCount(
                          //                 crossAxisCount: 2,
                          //                 childAspectRatio: 0.65,
                          //                 mainAxisSpacing: 2.5,
                          //                 crossAxisSpacing: 2.5,
                          //               ),
                          //           shrinkWrap: true,
                          //           itemCount:
                          //               controller.resellerProducts.length,
                          //           physics: NeverScrollableScrollPhysics(),
                          //           itemBuilder: (content, index) {
                          //             if (controller
                          //                 .resellerProducts
                          //                 .isEmpty) {
                          //               return null;
                          //             } else if (controller
                          //                 .isLoadingMoreProducts
                          //                 .value) {
                          //               return Center(
                          //                 child: CircularProgressIndicator(
                          //                   color: Colors.amber,
                          //                 ),
                          //               );
                          //             }
                          //             final item =
                          //                 controller.resellerProducts[index];
                          //             final gambarString =
                          //                 item['gambar'] ?? '';
                          //             final gambarList = gambarString.split(
                          //               ';',
                          //             );
                          //             final gambarUtama =
                          //                 gambarList.isNotEmpty
                          //                 ? gambarList.first
                          //                 : '';
                          //             return InkWell(
                          //               onTap: () => Get.toNamed(
                          //                 '/item-details',
                          //                 arguments: {
                          //                   'id_product': item['id_produk'],
                          //                   'name_product':
                          //                       item['nama_produk'],
                          //                   'price_product':
                          //                       double.tryParse(
                          //                         item['harga_konsumen'],
                          //                       ),
                          //                   'id_reseller':
                          //                       item['id_reseller'],
                          //                   'subdistrict_reseller':
                          //                       item['subdistrict_name'],
                          //                 },
                          //                 preventDuplicates: false,
                          //               ),
                          //               child: Card(
                          //                 shape: RoundedRectangleBorder(
                          //                   borderRadius:
                          //                       BorderRadius.circular(12),
                          //                 ),
                          //                 color: const Color(0xFFFFFFFF),
                          //                 child: Column(
                          //                   crossAxisAlignment:
                          //                       CrossAxisAlignment.start,
                          //                   children: [
                          //                     AspectRatio(
                          //                       aspectRatio: 1,
                          //                       child: ClipRRect(
                          //                         borderRadius:
                          //                             const BorderRadius.vertical(
                          //                               top:
                          //                                   Radius.circular(
                          //                                     12,
                          //                                   ),
                          //                             ),
                          //                         child: Image.network(
                          //                           gambarUtama,
                          //                           fit: BoxFit.cover,
                          //                           errorBuilder:
                          //                               (
                          //                                 context,
                          //                                 error,
                          //                                 stackTrace,
                          //                               ) {
                          //                                 return Container(
                          //                                   color: Colors
                          //                                       .grey[300],
                          //                                   child: const Icon(
                          //                                     Icons
                          //                                         .broken_image,
                          //                                     size: 50,
                          //                                   ),
                          //                                 );
                          //                               },
                          //                         ),
                          //                       ),
                          //                     ),
                          //                     Container(
                          //                       child: Padding(
                          //                         padding:
                          //                             const EdgeInsets.only(
                          //                               left: 8.0,
                          //                               right: 8,
                          //                             ),
                          //                         child: Column(
                          //                           crossAxisAlignment:
                          //                               CrossAxisAlignment
                          //                                   .start,
                          //                           // mainAxisAlignment:
                          //                           // MainAxisAlignment.spaceAround,
                          //                           children: [
                          //                             const SizedBox(
                          //                               height: 2.5,
                          //                             ),
                          //                             Text(
                          //                               item['nama_produk'] ??
                          //                                   '-',
                          //                               maxLines: 2,
                          //                               overflow:
                          //                                   TextOverflow
                          //                                       .ellipsis,
                          //                               style: TextStyle(
                          //                                 fontSize: 12,
                          //                               ),
                          //                             ),
                          //                             const SizedBox(
                          //                               height: 5,
                          //                             ),
                          //                             Text(
                          //                               NumberFormat.currency(
                          //                                 locale: 'id_ID',
                          //                                 symbol: 'Rp',
                          //                               ).format(
                          //                                 int.tryParse(
                          //                                       item['harga_konsumen'],
                          //                                     ) ??
                          //                                     0,
                          //                               ),
                          //                               style: TextStyle(
                          //                                 color: Colors
                          //                                     .amber[900],
                          //                                 fontWeight:
                          //                                     FontWeight
                          //                                         .w600,
                          //                               ),
                          //                             ),
                          //                             const SizedBox(
                          //                               height: 5,
                          //                             ),
                          //                             Row(
                          //                               children: [
                          //                                 Icon(
                          //                                   Icons
                          //                                       .pin_drop_rounded,
                          //                                   size: 12,
                          //                                   color: Colors
                          //                                       .grey[700],
                          //                                 ),
                          //                                 Text(
                          //                                   item['subdistrict_name'] ??
                          //                                       '',
                          //                                   style: TextStyle(
                          //                                     fontSize: 12,
                          //                                     color: Colors
                          //                                         .grey[700],
                          //                                   ),
                          //                                 ),
                          //                               ],
                          //                             ),
                          //                           ],
                          //                         ),
                          //                       ),
                          //                     ),
                          //                   ],
                          //                 ),
                          //               ),
                          //             );
                          //           },
                          //         ),
                          //       ],
                          //     ),
                          //   ),
                          // ),
                        ],
                      ),
                    ),
                  ),

                  // Store, products, and category button
                  Container(
                    decoration: BoxDecoration(color: Colors.white),
                    child: Row(
                      children: [
                        // Store text button
                        Expanded(
                          child: Obx(
                            () => Container(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    Colors.white,
                                    controller.storeIndex.value == 1
                                        ? Color.fromRGBO(230, 230, 230, 1)
                                        : Colors.white,
                                  ],
                                  begin: AlignmentGeometry.topCenter,
                                  end: AlignmentGeometry.bottomCenter,
                                ),
                              ),
                              child: TextButton(
                                style: ButtonStyle(
                                  splashFactory: NoSplash.splashFactory,
                                ),
                                onPressed: () => controller.changeStoreIndex(1),
                                child: const Text(
                                  'Toko',
                                  // style: TextStyle(
                                  //   decoration: TextDecoration.underline,
                                  // ),
                                ),
                              ),
                            ),
                          ),
                        ),

                        // Products text button
                        Expanded(
                          child: Obx(
                            () => Container(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    Colors.white,
                                    controller.storeIndex.value == 2
                                        ? Color.fromRGBO(230, 230, 230, 1)
                                        : Colors.white,
                                  ],
                                  begin: AlignmentGeometry.topCenter,
                                  end: AlignmentGeometry.bottomCenter,
                                ),
                              ),
                              child: TextButton(
                                style: ButtonStyle(
                                  splashFactory: NoSplash.splashFactory,
                                ),
                                onPressed: () => controller.changeStoreIndex(2),
                                child: const Text('Produk'),
                              ),
                            ),
                          ),
                        ),

                        // Category producst text button
                        Expanded(
                          child: Obx(
                            () => Container(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    Colors.white,
                                    controller.storeIndex.value == 3
                                        ? Color.fromRGBO(230, 230, 230, 1)
                                        : Colors.white,
                                  ],
                                  begin: AlignmentGeometry.topCenter,
                                  end: AlignmentGeometry.bottomCenter,
                                ),
                              ),
                              child: TextButton(
                                style: ButtonStyle(
                                  splashFactory: NoSplash.splashFactory,
                                ),
                                onPressed: () => controller.changeStoreIndex(3),
                                child: const Text('Kategori'),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  Expanded(
                    child: Obx(() {
                      switch (controller.storeIndex.value) {
                        case 1:
                          return _storeInformationView();

                        case 2:
                          return _storeProductsView();

                        case 3:
                          return _storeCategoryProduct();

                        default:
                          return _storeInformationView();
                      }
                    }),
                  ),
                ],
              ),
      ),
    );
  }

  // Store information view
  Widget _storeInformationView() {
    final info = controller.resellerInformation;

    return SingleChildScrollView(
      child: Card(
        elevation: 3,
        margin: const EdgeInsets.all(12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header (Foto + Nama + lokasi)
              // Row(
              //   children: [
              //     CircleAvatar(
              //       radius: 35,
              //       backgroundColor: Colors.grey[200],
              //       backgroundImage:
              //           info['foto'] != null &&
              //               !info['foto'].toString().endsWith("null")
              //           ? NetworkImage(info['foto'])
              //           : null,
              //       child:
              //           info['foto'] == null ||
              //               info['foto'].toString().endsWith("null")
              //           ? Icon(Icons.store_rounded, color: Colors.amber, size: 35)
              //           : null,
              //     ),
              //     const SizedBox(width: 15),

              //     Expanded(
              //       child: Column(
              //         crossAxisAlignment: CrossAxisAlignment.start,
              //         children: [
              //           Text(
              //             info['nama_reseller'] ?? '-',
              //             style: const TextStyle(
              //               fontSize: 16,
              //               fontWeight: FontWeight.bold,
              //             ),
              //           ),

              //           const SizedBox(height: 4),

              //           Row(
              //             children: [
              //               Icon(
              //                 Icons.pin_drop_rounded,
              //                 size: 16,
              //                 color: Colors.grey[700],
              //               ),
              //               const SizedBox(width: 5),
              //               Expanded(
              //                 child: Text(
              //                   "${info['subdistrict_name'] ?? ''}, "
              //                   "${info['city_name'] ?? ''}",
              //                   overflow: TextOverflow.ellipsis,
              //                   style: TextStyle(
              //                     fontSize: 13,
              //                     color: Colors.grey[700],
              //                   ),
              //                 ),
              //               ),
              //             ],
              //           ),
              //         ],
              //       ),
              //     ),
              //   ],
              // ),

              // const SizedBox(height: 20),

              // Kecamatan
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.pin_drop_rounded,
                    size: 22,
                    color: Colors.amber[800],
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Kecamatan",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          info['subdistrict_name'] ?? '-',
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.grey[800],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 15),

              // Kabupaten
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.pin_drop_rounded,
                    size: 22,
                    color: Colors.amber[800],
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Kabupaten",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                          ),
                        ),

                        const SizedBox(height: 4),

                        Text(
                          'Barito Selatan',
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.grey[800],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 15),

              // Provinsi
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.pin_drop_rounded,
                    size: 22,
                    color: Colors.amber[800],
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Provinsi",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                          ),
                        ),

                        const SizedBox(height: 4),

                        Text(
                          'Kalimantan Tengah',
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.grey[800],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 15),

              // Alamat lengkap
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.home_rounded, size: 22, color: Colors.amber[800]),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Alamat Lengkap",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          info['alamat_lengkap'] ?? '-',
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.grey[800],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 15),

              // Nomor telepon
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.phone_rounded, size: 22, color: Colors.amber[800]),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Nomor Telepon",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          info['no_telpon'] ?? '-',
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.grey[800],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 15),

              // Deskripsi
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.info_rounded, size: 22, color: Colors.amber[800]),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Deskripsi",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          info['keterangan'] ?? '-',
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.grey[800],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 15),

              // Tanggal daftar
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.calendar_month_rounded,
                    size: 22,
                    color: Colors.amber[800],
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Bergabung Pada",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          info['tanggal_daftar'] ?? '-',
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.grey[800],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Store products view
  Widget _storeProductsView() {
    return SingleChildScrollView(
      controller: controller.scrollController,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
          gradient: const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.center,
            colors: [Color(0xFFFFFFFF), Color.fromRGBO(240, 240, 240, 1)],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
          child: GridView.builder(
            // controller: controller.innerScrollController,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount:
                controller.storeProducts.length +
                (controller.isLoadingMoreProducts.value ? 1 : 0),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.65,
              mainAxisSpacing: 2.5,
              crossAxisSpacing: 2.5,
            ),
            itemBuilder: (context, index) {
              if (index == controller.storeProducts.length &&
                  controller.isLoadingMoreProducts.value) {
                return const Center(
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: CircularProgressIndicator(color: Colors.amber),
                  ),
                );
              }

              final item = controller.storeProducts[index];
              final gambarString = item['gambar'] as String? ?? '';
              final gambarList = gambarString.split(';');
              final gambarUtama = gambarList.isNotEmpty ? gambarList.first : '';

              return InkWell(
                onTap: () => Get.toNamed(
                  '/product-details',
                  arguments: {
                    'id_product': item['id_produk'],
                    'id_reseller': item['id_reseller'],
                  },
                ),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  color: const Color(0xFFFFFFFF),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AspectRatio(
                        aspectRatio: 1,
                        child: ClipRRect(
                          borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(12),
                          ),
                          child: Image.network(
                            gambarUtama,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                color: Colors.grey[300],
                                child: const Icon(Icons.broken_image, size: 50),
                              );
                            },
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0, right: 8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          // mainAxisAlignment:
                          // MainAxisAlignment.spaceAround,
                          children: [
                            const SizedBox(height: 2.5),

                            Text(
                              item['nama_produk'] ?? '-',
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(fontSize: 12),
                            ),

                            const SizedBox(height: 5),

                            Text(
                              NumberFormat.currency(
                                locale: 'id_ID',
                                symbol: 'Rp',
                              ).format(
                                int.tryParse(item['harga_konsumen']) ?? 0,
                              ),
                              style: TextStyle(
                                color: Colors.amber[900],
                                fontWeight: FontWeight.w600,
                              ),
                            ),

                            const SizedBox(height: 5),

                            Row(
                              children: [
                                Icon(
                                  Icons.pin_drop_rounded,
                                  size: 12,
                                  color: Colors.grey[700],
                                ),
                                Text(
                                  item['subdistrict_name'] ?? '',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey[700],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  // Store category view
  Widget _storeCategoryProduct() {
    if (controller.resellerProductCategory.isEmpty) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Text('Tidak ada kategori'),
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(8),
      itemCount: controller.resellerProductCategory.length,
      itemBuilder: (context, index) {
        final category = controller.resellerProductCategory[index];

        return InkWell(
          onTap: () {
            Get.toNamed(
              '/store-products-category-result',
              arguments: {
                'reseller_id': controller.resellerId.value,
                'category_id': category['id_kategori_produk'],
              },
            );
          },
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: ListTile(
              // Category name
              title: Row(
                children: [
                  Text(
                    category['nama_kategori'],
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 13,
                    ),
                  ),

                  const SizedBox(width: 5),

                  // product category sum
                  Text(
                    '(${category['total_produk']})',
                    style: const TextStyle(fontSize: 13, color: Colors.grey),
                  ),

                  // Text(
                  //   '(${category['id_kategori_produk']})',
                  //   style: const TextStyle(fontSize: 13, color: Colors.grey),
                  // ),
                ],
              ),

              trailing: const Icon(
                Icons.arrow_forward_ios_rounded,
                color: Colors.amber,
              ),
            ),
          ),
        );
      },
    );
  }
}
