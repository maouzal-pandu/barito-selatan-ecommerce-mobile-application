import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/store_controller.dart';

class StoreView extends GetView<StoreController> {
  const StoreView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('StoreView'), centerTitle: true),
      body: Obx(
        () => controller.isLoading.value
            ? Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                controller: controller.scrollController,

                child: Column(
                  children: [
                    InkWell(
                      onTap: () => Get.toNamed('/store-info', arguments: {}),
                      child: SizedBox(
                        width: double.infinity,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(8, 16, 8, 8),
                          child: Column(
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  // profile picture
                                  CircleAvatar(
                                    radius: 22.5,
                                    backgroundColor: Colors.grey[200],
                                    child:
                                        !controller.resellerInformation['foto']
                                            .endsWith('null')
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

                                  const SizedBox(width: 10),

                                  // store name
                                  Text(
                                    controller
                                            .resellerInformation['nama_reseller'] ??
                                        '',
                                  ),

                                  const Icon(
                                    Icons.arrow_forward_ios,
                                    size: 15.5,
                                  ),

                                  const Spacer(),

                                  OutlinedButton(
                                    onPressed: () {},
                                    style: ButtonStyle(),
                                    child: Text('Chat'),
                                  ),
                                ],
                              ),

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
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
