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
        title: const Text('Beranda'),
        surfaceTintColor: Colors.transparent,
        shadowColor: Colors.transparent,
        actions: [
          IconButton(
            onPressed: () => Get.toNamed('/search-view'),
            icon: const Icon(Icons.search_rounded),
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
                        ? Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Obx(
                                  () => controller.profilePicture.value.isEmpty
                                      ? CircleAvatar(
                                          radius: 40,
                                          child: Icon(Icons.person, size: 60),
                                        )
                                      : controller.profilePicture.value
                                            .contains('/asset/foto_user/')
                                      ? ClipOval(
                                          child: CircleAvatar(
                                            radius: 40,
                                            child: Image.network(
                                              controller.profilePicture.value,
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                        )
                                      : ClipOval(
                                          child: CircleAvatar(
                                            radius: 40,
                                            child: Image.file(
                                              File(
                                                controller.profilePicture.value,
                                              ),
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                        ),
                                ),

                                SizedBox(height: 10),

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
                        : const SizedBox.shrink(),
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
            // ListTile(
            //   leading: const Icon(Icons.shopping_basket_rounded),
            //   title: const Text('Keranjang'),
            //   onTap: () => Get.toNamed('/cart'),
            // ),
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
                                Container(
                                  child: Padding(
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
