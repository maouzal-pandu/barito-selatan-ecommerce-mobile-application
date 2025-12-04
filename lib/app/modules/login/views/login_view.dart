import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,

        // Background gradient
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFFFD54F), Color(0xFFFFA726)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),

        child: Obx(
          () => Center(
            child: controller.isLoading.value
                ? const CircularProgressIndicator(color: Colors.white)
                : SingleChildScrollView(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Selamat Datang",
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),

                        const SizedBox(height: 5),

                        Text(
                          "Silakan masuk ke akun Anda ",
                          style: TextStyle(fontSize: 15, color: Colors.white),
                        ),

                        const SizedBox(height: 40),

                        Card(
                          elevation: 8,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Form(
                              key: controller.formKey,
                              child: Column(
                                children: [
                                  // Email
                                  TextFormField(
                                    controller: controller.emailController,
                                    decoration: InputDecoration(
                                      label: const Text('Email'),
                                      prefixIcon: const Icon(
                                        Icons.email_rounded,
                                      ),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      filled: true,
                                      fillColor: Colors.grey[50],
                                    ),
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Email tidak boleh kosong';
                                      } else if (!RegExp(
                                        r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                                      ).hasMatch(value)) {
                                        return 'Format email tidak valid';
                                      }
                                      return null;
                                    },
                                  ),

                                  const SizedBox(height: 20),

                                  // Password
                                  Obx(
                                    () => TextFormField(
                                      controller: controller.passController,
                                      obscureText: controller.isObsecure.value,
                                      decoration: InputDecoration(
                                        label: const Text('Password'),
                                        prefixIcon: const Icon(
                                          Icons.lock_rounded,
                                        ),
                                        suffixIcon: IconButton(
                                          onPressed: controller.showPass,
                                          icon: Icon(
                                            controller.isObsecure.value
                                                ? Icons.visibility_rounded
                                                : Icons.visibility_off_rounded,
                                          ),
                                        ),
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(
                                            12,
                                          ),
                                        ),
                                        filled: true,
                                        fillColor: Colors.grey[50],
                                      ),
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'Password tidak boleh kosong';
                                        }
                                        return null;
                                      },
                                    ),
                                  ),

                                  const SizedBox(height: 15),

                                  // Forget Password
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: TextButton(
                                      onPressed: () =>
                                          Get.toNamed('/forget-pass'),
                                      child: const Text('Lupa password Anda?'),
                                    ),
                                  ),

                                  const SizedBox(height: 20),

                                  // Login Button
                                  SizedBox(
                                    width: double.infinity,
                                    height: 50,
                                    child: ElevatedButton(
                                      onPressed: controller.doLogin,
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.amber[700],
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            12,
                                          ),
                                        ),
                                        elevation: 3,
                                      ),
                                      child: const Text(
                                        "Login",
                                        style: TextStyle(
                                          color: Color(0xFFFFFFFF),
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),

                                  const SizedBox(height: 25),

                                  // Register
                                  TextButton(
                                    onPressed: () => Get.toNamed('/register'),
                                    child: const Text(
                                      "Tidak punya akun? Daftar di sini",
                                      style: TextStyle(fontSize: 15),
                                    ),
                                  ),
                                ],
                              ),
                            ),
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
