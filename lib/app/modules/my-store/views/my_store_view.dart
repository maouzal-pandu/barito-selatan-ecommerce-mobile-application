import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../controllers/my_store_controller.dart';

class MyStoreView extends GetView<MyStoreController> {
  const MyStoreView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => controller.isLogin.value == false
            ? _buildNotLogin()
            : controller.isLoading.value
            ? const Center(child: CircularProgressIndicator())
            : controller.haveStore.value
            ? _store()
            : _buildNoStore(),
      ),
    );
  }

  // =======================
  //     NOT LOGIN VIEW
  // =======================
  Widget _buildNotLogin() {
    return Center(
      child: Container(
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

  // =======================
  //     STORE VIEW
  // =======================
  Widget _store() {
    return RefreshIndicator(
      onRefresh: () => controller.getStoreInfo(),
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Center(
          child: Padding(
            padding: EdgeInsetsGeometry.symmetric(horizontal: 8),
            child: Column(
              children: [
                const SizedBox(height: 60),

                InkWell(
                  onTap: () => Get.toNamed('/my-store-profile'),
                  child: Card(
                    child: Container(
                      padding: EdgeInsets.all(16),
                      child: Row(
                        children: [
                          _buildProfilePicture(),

                          const SizedBox(width: 16),

                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(controller.storeName.value),

                              // Text(
                              //   'Kec. ${controller.subdistrictName.value} - Kab. Barito Selatan - Kalimantan Tengah ',
                              //   style: TextStyle(fontSize: 10),
                              // ),
                            ],
                          ),

                          Spacer(),

                          const Icon(
                            Icons.arrow_forward_ios_rounded,
                            color: Colors.amber,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                // SizedBox(
                //   height: 125,
                //   child: Row(
                //     children: [
                //       Expanded(
                //         child: Column(
                //           mainAxisAlignment: MainAxisAlignment.center,
                //           children: [
                //             const Icon(
                //               Icons.rectangle_rounded,
                //               color: Colors.amber,
                //             ),

                //             const SizedBox(height: 15),

                //             const Text('Jumlah Produk'),

                //             const SizedBox(height: 7.5),

                //             Text('data'),
                //           ],
                //         ),
                //       ),

                //       Expanded(
                //         child: Column(
                //           mainAxisAlignment: MainAxisAlignment.center,
                //           children: [
                //             const Icon(
                //               Icons.rectangle_rounded,
                //               color: Colors.amber,
                //             ),

                //             const SizedBox(height: 15),

                //             const Text('Jumlah Produk'),

                //             const SizedBox(height: 7.5),

                //             Text('data'),
                //           ],
                //         ),
                //       ),
                //     ],
                //   ),
                // ),

                // const SizedBox(
                //   width: double.infinity,
                //   child: Divider(indent: 16, endIndent: 16),
                // ),

                // button add prodcut
                Align(
                  alignment: AlignmentGeometry.centerRight,
                  child: FilledButton.icon(
                    onPressed: () => Get.toNamed('/add-product'),
                    label: const Text('Tambah Produk'),
                    icon: const Icon(Icons.add_rounded),
                    style: ButtonStyle(
                      shape: WidgetStatePropertyAll(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadiusGeometry.all(
                            Radius.circular(8),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 10),

                controller.products.isEmpty
                    ? SizedBox(
                        width: double.infinity,
                        height: 300,
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.asset(
                                'assets/images/empty-box.png',
                                width: 200,
                                height: 200,
                              ),

                              const Text(
                                'Produk kosong silahkan menambahkan produk terlebih dahulu.',
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      )
                    : SingleChildScrollView(
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
                                    '/item-details',
                                    arguments: {
                                      'id_product': item['id_produk'],
                                      'name_product': item['nama_produk'],
                                      'price_product': double.tryParse(
                                        item['harga_konsumen'],
                                      ),
                                      'id_reseller': item['id_reseller'],
                                      'subdistrict_reseller':
                                          item['subdistrict_name'],
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
              ],
            ),
          ),
        ),
      ),
    );
  }

  // =======================
  //     NO STORE VIEW
  // =======================
  Widget _buildNoStore() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/didnt_have_store.png', height: 250),
            const SizedBox(height: 20),
            const Text(
              'Anda belum memiliki toko, silahkan membuat toko terlebih dahulu',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 25),
            FilledButton.icon(
              onPressed: () => Get.toNamed(
                '/edit-my-store',
                arguments: controller.haveStore.value,
              ),
              icon: const Icon(Icons.store_mall_directory_rounded),
              label: const Text('Buat Toko'),
            ),
          ],
        ),
      ),
    );
  }

  // =======================
  //     PROFILE PICTURE
  // =======================
  Widget _buildProfilePicture() {
    final path = controller.storeProfilePicture.value;

    if (path == '') {
      return const CircleAvatar(
        radius: 35,
        child: Icon(Icons.storefront_rounded, size: 50),
      );
    }

    if (path.contains('/asset/foto_user/')) {
      return CircleAvatar(radius: 35, backgroundImage: NetworkImage(path));
    }

    return CircleAvatar(radius: 35, backgroundImage: FileImage(File(path)));
  }
}
