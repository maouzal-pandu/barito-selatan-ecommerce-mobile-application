import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../controllers/store_products_category_result_controller.dart';

class StoreProductsCategoryResultView
    extends GetView<StoreProductsCategoryResultController> {
  const StoreProductsCategoryResultView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('StoreProductsCategoryResultView'),
        centerTitle: true,
      ),
      body: Obx(
        () => controller.isLoading.value
            ?
              // loading
              const Center(
                child: CircularProgressIndicator(color: Colors.amber),
              )
            :
              // show products
              SingleChildScrollView(
                controller: controller.scrollController,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(16),
                    ),
                    gradient: const LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.center,
                      colors: [
                        Color(0xFFFFFFFF),
                        Color.fromRGBO(240, 240, 240, 1),
                      ],
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
                    child: GridView.builder(
                      // controller: controller.innerScrollController,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount:
                          controller.products.length +
                          (controller.isLoadingMoreProducts.value ? 1 : 0),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 0.65,
                            mainAxisSpacing: 2.5,
                            crossAxisSpacing: 2.5,
                          ),
                      itemBuilder: (context, index) {
                        if (index == controller.products.length &&
                            controller.isLoadingMoreProducts.value) {
                          return const Center(
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: CircularProgressIndicator(
                                color: Colors.amber,
                              ),
                            ),
                          );
                        }

                        final item = controller.products[index];
                        final gambarString = item['gambar'] as String? ?? '';
                        final gambarList = gambarString.split(';');
                        final gambarUtama = gambarList.isNotEmpty
                            ? gambarList.first
                            : '';

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
                                      errorBuilder:
                                          (context, error, stackTrace) {
                                            return Container(
                                              color: Colors.grey[300],
                                              child: const Icon(
                                                Icons.broken_image,
                                                size: 50,
                                              ),
                                            );
                                          },
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                    left: 8.0,
                                    right: 8,
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                          int.tryParse(
                                                item['harga_konsumen'],
                                              ) ??
                                              0,
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
              ),
      ),
    );
  }
}
