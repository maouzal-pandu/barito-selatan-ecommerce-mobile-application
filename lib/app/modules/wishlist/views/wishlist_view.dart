import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../controllers/wishlist_controller.dart';

class WishlistView extends GetView<WishlistController> {
  const WishlistView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('Wishlist'),
      //   backgroundColor: Colors.amber,
      //   centerTitle: true,
      // ),
      body: Obx(
        () => Center(
          child: controller.isLogin.value
              ?
                // If user already login
                controller.isLoading.value
                    ? Center(
                        child: CircularProgressIndicator(color: Colors.amber),
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
                            child: GridView.builder(
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    childAspectRatio: 0.65,
                                    mainAxisSpacing: 2.5,
                                    crossAxisSpacing: 2.5,
                                  ),
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount:
                                  controller.products.length +
                                  (controller.isLoadingMoreProducts.value
                                      ? 1
                                      : 0),
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
                            ),
                          ),
                        ),
                      )
              :
                // If not login yet
                Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        // Color(0xFFFFF8E1), // Amber 50 (sangat muda)
                        Color(0xFFFFECB3), // Amber 100
                        Color(0xFFFFD54F), // Amber 300
                        Color(0xFFFFB300), // Amber 600 (lebih kuat)
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/images/login_first_vector.png',
                          width: 300,
                          height: 300,
                        ),

                        Text(
                          'Silahkan login atau daftar terlebih dahulu untuk menggunakan fitur ini',
                          style: const TextStyle(fontSize: 15),
                          textAlign: TextAlign.center,
                        ),

                        const SizedBox(height: 30),

                        // login filled button
                        FilledButton(
                          onPressed: () => Get.toNamed('/login'),
                          style: ButtonStyle(
                            backgroundColor: WidgetStatePropertyAll(
                              Colors.green,
                            ),
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
        ),
      ),
    );
  }
}
