import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/cart_controller.dart';

class CartView extends GetView<CartController> {
  const CartView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('CartView'), centerTitle: true),
      body: Center(
        child: Column(
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
    );
  }
}
