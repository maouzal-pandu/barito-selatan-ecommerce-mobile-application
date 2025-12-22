import 'dart:io';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.amber,

        // searchbar
        title: InkWell(
          onTap: () => Get.toNamed('/search-page'),
          child: SizedBox(
            width: double.infinity,
            height: 40,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(32)),
                color: Colors.white,
              ),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.search_rounded,
                      color: Colors.grey,
                      size: 18,
                    ),

                    const Text(
                      'Cari barang...',
                      style: TextStyle(color: Colors.grey, fontSize: 16),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),

        surfaceTintColor: Colors.transparent,
        shadowColor: Colors.transparent,

        // cart
        actions: [
          IconButton(
            onPressed: () =>
                Get.toNamed('/cart', arguments: controller.consumerId.value),
            icon: const Icon(Icons.shopping_bag_rounded),
          ),
        ],
      ),

      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            // profile picture
            Obx(
              () => DrawerHeader(
                padding: EdgeInsets.zero,
                child: Stack(
                  children: [
                    // bg image
                    Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(
                            'assets/images/drawer_header_bg.jpg',
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),

                    // gradient overlay
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent, // top: clear
                            const Color(0x99000000), // bottom: darker
                          ],
                        ),
                      ),
                    ),

                    // drawer header content
                    controller.isLogin.value
                        ?
                          // if user login
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Obx(
                                  () => controller.profilePicture.value.isEmpty
                                      ?
                                        // if user didn't have profile picture
                                        CircleAvatar(
                                          radius: 40,
                                          child: Icon(Icons.person, size: 65),
                                        )
                                      : controller.profilePicture.value
                                            .contains('/asset/foto_user/')
                                      ? ClipOval(
                                          child: CircleAvatar(
                                            radius: 40,

                                            backgroundColor:
                                                const Color.fromRGBO(
                                                  240,
                                                  240,
                                                  240,
                                                  1,
                                                ),
                                            child: Image.network(
                                              controller.profilePicture.value,
                                              fit: BoxFit.fill,
                                              errorBuilder:
                                                  (
                                                    context,
                                                    error,
                                                    stackTrace,
                                                  ) => Icon(
                                                    Icons.person_rounded,
                                                    size: 65,
                                                    color: Colors.amber[800],
                                                  ),
                                            ),
                                          ),
                                        )
                                      : ClipOval(
                                          child: CircleAvatar(
                                            radius: 40,
                                            backgroundColor:
                                                const Color.fromRGBO(
                                                  240,
                                                  240,
                                                  240,
                                                  1,
                                                ),
                                            child: Image.file(
                                              File(
                                                controller.profilePicture.value,
                                              ),
                                              fit: BoxFit.fill,
                                              errorBuilder:
                                                  (
                                                    context,
                                                    error,
                                                    stackTrace,
                                                  ) => Icon(
                                                    Icons.person_rounded,
                                                    size: 65,
                                                    color: Colors.amber[800],
                                                  ),
                                            ),
                                          ),
                                        ),
                                ),

                                SizedBox(height: 10),

                                // Username
                                Text(
                                  controller.username.value,
                                  style: TextStyle(
                                    color: Colors.amber,
                                    fontWeight: FontWeight.bold,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          )
                        :
                          // if user didn't login
                          const SizedBox.shrink(),
                  ],
                ),
              ),
            ),

            // account button
            ListTile(
              leading: const Icon(Icons.person_rounded),
              title: const Text('Akun'),
              onTap: () => Get.toNamed('/user-account'),
            ),

            // wishlist button
            ListTile(
              leading: const Icon(Icons.favorite_rounded),
              title: const Text('Wishlist'),
              onTap: () => Get.toNamed('/wishlist'),
            ),

            // cart button
            ListTile(
              leading: const Icon(Icons.shopping_bag_rounded),
              title: const Text('Keranjang'),
              onTap: () => Get.toNamed('/cart'),
            ),

            const SizedBox(
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Divider(color: Colors.grey, indent: 15, endIndent: 15),
              ),
            ),

            // store button
            ListTile(
              leading: const Icon(Icons.store_rounded),
              title: const Text('Toko'),
              onTap: () => Get.toNamed(
                '/my-store',
                arguments: controller.idReseller.value,
              ),
            ),

            const SizedBox(
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Divider(color: Colors.grey, indent: 15, endIndent: 15),
              ),
            ),

            // Belum bayar
            ListTile(
              leading: const Icon(Icons.wallet_rounded),
              title: const Text('Belum Bayar'),
              onTap: () => Get.toNamed(
                '/belum-bayar',
                arguments: controller.consumerId.value,
              ),
            ),

            // Dikirim
            ListTile(
              leading: const Icon(Icons.delivery_dining_rounded),
              title: const Text('Dikirim'),
              onTap: () => Get.toNamed(
                '/dikirim',
                arguments: controller.consumerId.value,
              ),
            ),

            // Beri penilaian
            // ListTile(
            //   leading: const Icon(Icons.stars_rounded),
            //   title: const Text('Beri Penilaian'),
            //   onTap: () =>
            //       Get.toNamed('/', arguments: controller.idReseller.value),
            // ),
            const SizedBox(
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Divider(color: Colors.grey, indent: 15, endIndent: 15),
              ),
            ),

            // settings button
            ListTile(
              leading: const Icon(Icons.settings_rounded),
              title: const Text('Pengaturan'),
              onTap: () => Get.toNamed('/settings'),
            ),

            // login/logout txt button
            Obx(
              () => controller.isLogin.value
                  ? ListTile(
                      leading: const Icon(Icons.logout, color: Colors.red),
                      title: const Text('Logout'),
                      onTap: () => controller.logout(),
                    )
                  : ListTile(
                      leading: const Icon(Icons.login, color: Colors.blue),
                      title: const Text('Login'),
                      onTap: () => Get.toNamed('/login'),
                    ),
            ),
          ],
        ),
      ),

      body: Obx(
        () => controller.isLoading.value
            ?
              // loading
              const Center(
                child: CircularProgressIndicator(color: Colors.amber),
              )
            :
              // products
              RefreshIndicator(
                onRefresh: () => controller.refreshProducts(),
                child: SingleChildScrollView(
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
                              parameters: {'tag': item['id_produk']},
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
      ),
    );
  }
}
