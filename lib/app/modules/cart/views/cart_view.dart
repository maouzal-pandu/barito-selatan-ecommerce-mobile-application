import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/cart_controller.dart';

class CartView extends GetView<CartController> {
  const CartView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => Center(
          child: controller.isLogin.value
              ? const Text('Logged')
              : Container(
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
