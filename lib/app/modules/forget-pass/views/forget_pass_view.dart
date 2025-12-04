import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/forget_pass_controller.dart';

class ForgetPassView extends GetView<ForgetPassController> {
  const ForgetPassView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Obx(
        () => Container(
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

          child: controller.isLoading.value
              ? Center(
                  child: const CircularProgressIndicator(color: Colors.white),
                )
              : Column(
                  children: [
                    const SizedBox(height: 40),

                    // Decorative Icon
                    Center(
                      child: Container(
                        padding: const EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          color: Colors.amber[100],
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.lock_reset_rounded,
                          size: 40,
                          color: Colors.amber[700],
                        ),
                      ),
                    ),

                    const SizedBox(height: 15),

                    // Title
                    const Text(
                      "Reset Password",
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),

                    const SizedBox(height: 20),

                    Expanded(
                      child: Container(
                        width: double.infinity,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(25),
                            topRight: Radius.circular(25),
                          ),
                        ),

                        child: SingleChildScrollView(
                          // agar tidak overflow ketika keyboard muncul
                          padding: EdgeInsets.only(
                            left: 25,
                            right: 25,
                            top: 25,
                            bottom:
                                MediaQuery.of(context).viewInsets.bottom + 30,
                          ),

                          child: Form(
                            key: controller.formKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Masukkan email Anda dan kami akan mengirimkan link untuk mereset password.",
                                  style: const TextStyle(fontSize: 15),
                                  textAlign: TextAlign.center,
                                ),

                                const SizedBox(height: 20),

                                const Text(
                                  "Email",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black87,
                                  ),
                                ),

                                const SizedBox(height: 8),

                                // Email TextField
                                TextFormField(
                                  controller: controller.emailController,
                                  decoration: InputDecoration(
                                    hintText: "contoh@email.com",
                                    prefixIcon: const Icon(Icons.email_rounded),
                                    filled: true,
                                    fillColor: Colors.grey[50],
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
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

                                const SizedBox(height: 40),

                                // Send reset email button
                                SizedBox(
                                  width: double.infinity,
                                  height: 50,
                                  child: ElevatedButton(
                                    onPressed: () =>
                                        controller.sendResetPassEmail(),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.amber[700],
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                    ),
                                    child: const Text(
                                      "Kirim Link Reset",
                                      style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),

                                const SizedBox(height: 20),

                                // Center(
                                //   child: TextButton(
                                //     onPressed: () => Get.back(),
                                //     child: const Text(
                                //       "Kembali ke Login",
                                //       style: TextStyle(color: Colors.black87),
                                //     ),
                                //   ),
                                // ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
