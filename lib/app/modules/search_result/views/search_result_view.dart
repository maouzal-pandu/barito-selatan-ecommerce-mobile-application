import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../controllers/search_result_controller.dart';

class SearchResultView extends GetView<SearchResultController> {
  const SearchResultView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,

        // Search bar
        title: Container(
          height: 40,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            color: Colors.white,
          ),
          child: TextFormField(
            onTap: () => Get.back(),
            // controller: controller.keywordController,
            // onEditingComplete: () {
            //   controller.searchProducts();
            // },
            decoration: InputDecoration(
              border: UnderlineInputBorder(borderSide: BorderSide.none),
              contentPadding: EdgeInsets.fromLTRB(16, 0, 16, 0),
            ),
            validator: (value) {
              if (value!.isEmpty) {
                return '';
              }

              return null;
            },
          ),
        ),

        // Filter product
        actions: [
          IconButton(
            onPressed: () => Get.bottomSheet(filterBottomSheet(context)),
            icon: Icon(
              Icons.filter_list_rounded,
              color: Colors.green[700],
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),

      body: Obx(
        () => controller.isLoading.value
            ? Center(child: CircularProgressIndicator(color: Colors.amber))
            : controller.products.isEmpty
            ?
              // No produts find
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/product-not-found.png',
                      height: 300,
                      width: 300,
                    ),

                    const Text(
                      'Maaf produk yang kamu cari kosong, cobalah untuk  mengunakan kata kunci yang berbeda',
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              )
            : SingleChildScrollView(
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
                    child: controller.isCategory.value
                        ?
                          // If from cateogry button at search page
                          GridView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount:
                                controller.products.length +
                                (controller.isLoadingMoreProducts.value
                                    ? 1
                                    : 0),
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
                              final gambarString =
                                  item['gambar'] as String? ?? '';
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      AspectRatio(
                                        aspectRatio: 1,
                                        child: ClipRRect(
                                          borderRadius:
                                              const BorderRadius.vertical(
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
                                                  item['subdistrict_name'] ??
                                                      '',
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
                          )
                        :
                          // Found products
                          GridView.builder(
                            // controller: controller.innerScrollController,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount:
                                controller.products.length +
                                (controller.isLoadingMoreProducts.value
                                    ? 1
                                    : 0),
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
                              final gambarString = item['gambar'] ?? [];
                              // final gambarList = gambarString.split(';');
                              final gambarUtama = gambarString.isNotEmpty
                                  ? gambarString.first
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      AspectRatio(
                                        aspectRatio: 1,
                                        child: ClipRRect(
                                          borderRadius:
                                              const BorderRadius.vertical(
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
                                                  item['subdistrict_name'] ??
                                                      '',
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

  // Filter bottom sheet
  Widget filterBottomSheet(BuildContext context) {
    return Container(
      height: Get.height * 0.75,
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// HANDLE
          Center(
            child: Container(
              width: 40,
              height: 4,
              margin: EdgeInsets.only(bottom: 16),
              decoration: BoxDecoration(
                color: Colors.grey[400],
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),

          /// TITLE
          Text(
            'Filter & Urutkan',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),

          SizedBox(height: 24),

          /// SORTING
          Text('Urutkan', style: TextStyle(fontWeight: FontWeight.w600)),
          SizedBox(height: 8),

          Obx(
            () => Wrap(
              spacing: 8,
              children: [
                _sortChip('Terbaru', 'newest'),
                _sortChip('Termurah', 'cheapest'),
                _sortChip('Termahal', 'highest'),
              ],
            ),
          ),

          SizedBox(height: 24),

          /// PRICE RANGE
          Text('Rentang Harga', style: TextStyle(fontWeight: FontWeight.w600)),
          Column(
            children: [
              Obx(
                () => RangeSlider(
                  min: 0,
                  max: 1000000,
                  divisions: 100,
                  labels: RangeLabels(
                    'Rp${controller.minPrice.value}',
                    'Rp${controller.maxPrice.value}',
                  ),
                  values: RangeValues(
                    controller.minPrice.value.toDouble(),
                    controller.maxPrice.value.toDouble(),
                  ),
                  onChanged: (value) {
                    controller.minPrice.value = value.start.toInt();
                    controller.maxPrice.value = value.end.toInt();
                  },
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Rp${controller.minPrice.value}'),
                  Text('Rp${controller.maxPrice.value}'),
                ],
              ),
            ],
          ),

          SizedBox(height: 24),

          /// STOCK
          // Obx(
          //   () => SwitchListTile(
          //     title: Text('Stok Tersedia'),
          //     value: controller.inStockOnly.value,
          //     onChanged: (value) {
          //       controller.inStockOnly.value = value;
          //     },
          //   ),
          // ),
          Spacer(),

          /// APPLY BUTTON
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () {
                    controller.selectedSort.value = '';
                    controller.minPrice.value = 0;
                    controller.maxPrice.value = 1000000;
                    // controller.inStockOnly.value = false;
                  },
                  child: Text('Reset'),
                ),
              ),
              SizedBox(width: 12),

              // Filter button
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    controller.applyFilter();
                    Get.back();
                  },
                  child: Text('Terapkan'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _sortChip(String label, String value) {
    return ChoiceChip(
      label: Text(label),
      selected: controller.selectedSort.value == value,
      onSelected: (_) {
        controller.selectedSort.value = value;
      },
    );
  }
}
