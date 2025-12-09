import 'package:barsel_ecommerce_flutter_application_alter/widgets/review_stars_widget.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../controllers/product_details_controller.dart';

class ProductDetailsView extends GetView<ProductDetailsController> {
  String? get tag => Get.parameters['tag'];

  const ProductDetailsView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(240, 240, 240, 1),

      body: Obx(
        () =>
            controller.isLoadingProduct.value || controller.isLoadingStore.value
            ?
              // loading screen
              const Center(
                child: CircularProgressIndicator(color: Colors.amber),
              )
            :
              // product detail view
              SingleChildScrollView(
                controller: controller.scrollController,
                child: Column(
                  children: [
                    // Product images
                    Stack(
                      children: [
                        // Product images
                        controller.productImages.length > 1
                            ? SizedBox(
                                height: 300,
                                width: double.infinity,
                                child: PageView.builder(
                                  controller: controller.imageController,
                                  itemCount: controller.productImages.length,
                                  onPageChanged: (value) {
                                    controller.currentImageIndex.value = value;
                                  },
                                  itemBuilder: (context, index) {
                                    return Image.network(
                                      controller.productImages[index],
                                      fit: BoxFit.fill,
                                      width: double.infinity,
                                    );
                                  },
                                ),
                              )
                            : Image.network(
                                controller.productImages[0],
                                width: double.infinity,
                                height: 300,
                                fit: BoxFit.fill,
                              ),

                        // App bar.
                        AppBar(
                          backgroundColor: const Color(0x00000000),
                          elevation: 0,
                          shadowColor: const Color(0x00000000),
                          leading: Container(
                            margin: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(200, 60, 60, 60),
                              shape: BoxShape.circle,
                            ),
                            child: IconButton(
                              icon: const Icon(
                                Icons.arrow_back,
                                color: Colors.amber,
                              ),
                              onPressed: () => Get.back(),
                            ),
                          ),
                        ),

                        // Product image indicator
                        Positioned(
                          left: 0,
                          right: 0,
                          bottom: 10,
                          child: Align(
                            alignment: Alignment.center,
                            child: IntrinsicWidth(
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: Color.fromRGBO(0, 0, 0, 0.5),
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: Obx(
                                  () => Text(
                                    '${controller.currentImageIndex.value + 1}/${controller.productImages.length}',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    // Product name, price, wish list feature, and variant
                    Container(
                      color: const Color(0xFFFFFFFF),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Product price and wish list button
                            Row(
                              children: [
                                Text(
                                  NumberFormat.currency(
                                    locale: 'ID',
                                    symbol: 'Rp.',
                                  ).format(
                                    int.tryParse(
                                      controller.data['harga_konsumen'],
                                    ),
                                  ),
                                  style: TextStyle(
                                    color: Colors.amber,
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),

                                const Spacer(),

                                Obx(
                                  () => IconButton(
                                    onPressed: () =>
                                        controller.addRemoveProductWishlist(),
                                    icon: controller.isInWishlist.value
                                        ? Icon(
                                            Icons.favorite_rounded,
                                            color: Colors.amber,
                                          )
                                        : Icon(
                                            Icons.favorite_outline_rounded,
                                            color: Colors.amber,
                                          ),
                                  ),
                                ),
                              ],
                            ),

                            // Item name
                            Text(controller.data['nama_produk']),

                            const SizedBox(height: 15),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 10),

                    // Product description and information
                    Container(
                      color: const Color(0xFFFFFFFF),
                      child: Column(
                        children: [
                          Align(
                            alignment: AlignmentGeometry.centerLeft,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 8.0,
                                horizontal: 16,
                              ),
                              child: const Text(
                                'Spesifikasi & Deskripsi',
                                style: TextStyle(
                                  fontSize: 14.5,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),

                          Padding(
                            padding: const EdgeInsets.all(16),
                            child: Table(
                              children: [
                                TableRow(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 8.0,
                                      ),
                                      child: const Text(
                                        'Berat',
                                        style: TextStyle(color: Colors.grey),
                                      ),
                                    ),

                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 8.0,
                                      ),
                                      child: Text(
                                        controller.data['berat'] == '' ||
                                                controller.data['berat'] == null
                                            ? '-'
                                            : controller.data['berat'],
                                      ),
                                    ),
                                  ],
                                ),

                                TableRow(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 8.0,
                                      ),
                                      child: const Text(
                                        'Jenis Produk',
                                        style: TextStyle(color: Colors.grey),
                                      ),
                                    ),

                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 8.0,
                                      ),
                                      child: Text(
                                        controller.data['jenis_produk'] == '' ||
                                                controller
                                                        .data['jenis_produk'] ==
                                                    null
                                            ? '-'
                                            : controller.data['jenis_produk'] ??
                                                  '-',
                                      ),
                                    ),
                                  ],
                                ),

                                TableRow(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 8.0,
                                      ),
                                      child: const Text(
                                        'Satuan',
                                        style: TextStyle(color: Colors.grey),
                                      ),
                                    ),

                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 8.0,
                                      ),
                                      child: Text(
                                        controller.data['satuan'] == '' ||
                                                controller.data['satuan'] ==
                                                    null
                                            ? '-'
                                            : controller.data['satuan'],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),

                          controller.data['tentang_produk'] == '' ||
                                  controller.data['tentang_produk'] == null
                              ? const SizedBox.shrink()
                              : const SizedBox(
                                  width: double.infinity,
                                  child: Divider(
                                    color: Colors.grey,
                                    indent: 16,
                                    endIndent: 16,
                                  ),
                                ),

                          Padding(
                            padding: const EdgeInsets.all(16),
                            child: Align(
                              alignment: AlignmentGeometry.centerLeft,
                              child: Text(
                                controller.data['tentang_produk'],
                                style: TextStyle(fontSize: 14.5),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 10),

                    // Product reviews
                    Container(
                      color: const Color(0xFFFFFFFF),
                      child: ExpansionTile(
                        title: Row(
                          children: [
                            const Text(
                              'Ulasan',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14.5,
                              ),
                            ),

                            Text(
                              ' (${controller.reviews.length})',
                              style: TextStyle(fontSize: 14.5),
                            ),
                          ],
                        ),
                        shape: Border(),
                        children: [
                          Obx(() {
                            if (controller.isLoadingReviews.value) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }

                            if (controller.reviews.isEmpty) {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: const Text(
                                  "Belum ada ulasan untuk produk ini.",
                                ),
                              );
                            }

                            return ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: controller.reviews.length,
                              itemBuilder: (context, index) {
                                final review = controller.reviews[index];
                                final String profilePicture =
                                    review['foto'] ?? '';
                                final hasProfilePicture =
                                    profilePicture.isNotEmpty &&
                                    !profilePicture.endsWith('/');

                                return ListTile(
                                  title: Row(
                                    children: [
                                      hasProfilePicture
                                          ? CircleAvatar(
                                              child: Image.network(
                                                profilePicture,
                                                height: 30,
                                                width: 30,
                                              ),
                                            )
                                          : CircleAvatar(
                                              child: const Icon(
                                                Icons.person_rounded,
                                                size: 25,
                                              ),
                                            ),

                                      const SizedBox(width: 5),

                                      Text(review['username']),
                                    ],
                                  ),
                                  subtitle: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      starsRating(
                                        int.tryParse(review['rating'])!,
                                      ),

                                      const SizedBox(height: 10),

                                      Text(review['ulasan']),

                                      const SizedBox(height: 7.5),

                                      Text(
                                        DateFormat('dd/MM/yyyy').format(
                                          DateTime.tryParse(
                                            review['waktu_kirim'],
                                          )!,
                                        ),
                                        style: const TextStyle(
                                          fontSize: 12,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            );
                          }),
                        ],
                      ),
                    ),

                    const SizedBox(height: 10),

                    // Store
                    Container(
                      color: const Color(0xFFFFFFFF),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            InkWell(
                              onTap: () => Get.toNamed(
                                '/store',
                                arguments: controller.resellerId.value,
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  CircleAvatar(
                                    radius: 20,
                                    backgroundColor: Colors.grey[200],
                                    child:
                                        controller
                                                .storeProfilePicture
                                                .value
                                                .isNotEmpty &&
                                            !controller
                                                .storeProfilePicture
                                                .value
                                                .endsWith('null')
                                        ? ClipOval(
                                            child: Image.network(
                                              controller.storeData['foto'],
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

                                  const SizedBox(width: 15),

                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        controller.storeData['nama_reseller'] ??
                                            '',
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.pin_drop,
                                            size: 12,
                                            color: Colors.grey[700],
                                          ),
                                          const SizedBox(width: 3),
                                          Text(
                                            controller
                                                .storeData['subdistrict_name'],
                                            style: TextStyle(
                                              color: Colors.grey[700],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),

                                  const Spacer(),

                                  TextButton(
                                    onPressed: () {},
                                    style: ButtonStyle(
                                      side: WidgetStatePropertyAll(
                                        BorderSide(color: Colors.amber),
                                      ),
                                    ),
                                    child: const Text(
                                      'Kunjungi',
                                      style: TextStyle(
                                        color: Colors.amber,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    // divider for related products
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: const SizedBox(
                            width: double.infinity,
                            child: Divider(
                              indent: 20,
                              endIndent: 10,
                              thickness: 2,
                            ),
                          ),
                        ),

                        const Text('Produk Terkait'),

                        Expanded(
                          child: const SizedBox(
                            width: double.infinity,
                            child: Divider(
                              indent: 10,
                              endIndent: 20,
                              thickness: 2,
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),

                    // Related products
                    Container(
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
                        padding: const EdgeInsets.all(8.0),
                        child: GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                childAspectRatio: 0.65,
                                mainAxisSpacing: 2.5,
                                crossAxisSpacing: 2.5,
                              ),
                          shrinkWrap: true,
                          itemCount: controller.relatedProducts.length,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (content, index) {
                            if (controller.relatedProducts.isEmpty) {
                              return null;
                            } else if (controller
                                .isLoadingRelatedProducts
                                .value) {
                              return Center(
                                child: CircularProgressIndicator(
                                  color: Colors.amber,
                                ),
                              );
                            }

                            final item = controller.relatedProducts[index];
                            final gambarString =
                                item['gambar'] as String? ?? '';
                            final gambarList = gambarString.split(';');
                            final gambarUtama = gambarList.isNotEmpty
                                ? gambarList.first
                                : '';

                            return InkWell(
                              onTap: () {
                                Get.toNamed(
                                  '/product-details',
                                  arguments: {
                                    'id_product': item['id_produk'],
                                    'id_reseller': item['id_reseller'],
                                  },
                                  parameters: {'tag': item['id_produk']},
                                  preventDuplicates: false,
                                );
                              },
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
                  ],
                ),
              ),
      ),

      bottomNavigationBar: Row(
        children: [
          // Tambahkan ke keranjang button
          Expanded(
            child: SizedBox(
              height: 50,
              child: TextButton(
                style: ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(Colors.blue),
                  shape: WidgetStatePropertyAll(LinearBorder()),
                ),
                onPressed: () {},
                child: const Text(
                  "Tambahkan ke Keranjang",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),

          // Beli sekarang button
          Expanded(
            child: SizedBox(
              height: 50,
              child: TextButton(
                style: ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(Colors.amber),
                  shape: WidgetStatePropertyAll(LinearBorder()),
                ),
                onPressed: () {},
                child: const Text(
                  "Beli Sekarang",
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
