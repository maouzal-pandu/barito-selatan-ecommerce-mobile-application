import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/wishlist_controller.dart';

class WishlistView extends GetView<WishlistController> {
  const WishlistView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('WishlistView'), centerTitle: true),
      body: Obx(
        () => Center(
          child: controller.isLogin.value
              ? const Text('Logged')
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'images/login_first_vector.png',
                      width: 300,
                      height: 300,
                    ),

                    Text(
                      'Silahkan login atau daftar terlebih dahulu untuk menggunakan fitur ini',
                      style: TextStyle(fontSize: 20),
                      textAlign: TextAlign.center,
                    ),

                    const SizedBox(height: 30),

                    // login filled button
                    FilledButton(
                      onPressed: () => Get.toNamed('/login'),
                      child: const Text('Login'),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
