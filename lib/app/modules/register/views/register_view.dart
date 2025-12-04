import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/register_controller.dart';

class RegisterView extends GetView<RegisterController> {
  const RegisterView({super.key});

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
          () => controller.isLoading.value
              ? Center(child: CircularProgressIndicator(color: Colors.white))
              : LayoutBuilder(
                  builder: (context, constraints) {
                    return SingleChildScrollView(
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          minHeight: constraints.maxHeight,
                          minWidth: constraints.maxWidth,
                        ),
                        child: IntrinsicHeight(
                          child: Column(
                            children: [
                              const SizedBox(height: 60),

                              const Text(
                                "Buat Akun Baru",
                                style: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),

                              const SizedBox(height: 5),

                              const Text(
                                "Silakan isi data berikut untuk mendaftar",
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.white,
                                ),
                              ),

                              const SizedBox(height: 35),

                              Expanded(
                                child: Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: Colors.grey[100],
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(25),
                                      topRight: Radius.circular(25),
                                    ),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(20.0),
                                    child: Form(
                                      key: controller.formKey,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          // Email
                                          TextFormField(
                                            controller:
                                                controller.emailController,
                                            decoration: InputDecoration(
                                              label: const Text('Email'),
                                              prefixIcon: const Icon(
                                                Icons.email_rounded,
                                              ),
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(12),
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

                                          // Username
                                          TextFormField(
                                            controller:
                                                controller.usernameController,
                                            decoration: InputDecoration(
                                              label: const Text('Username'),
                                              prefixIcon: const Icon(
                                                Icons.person_rounded,
                                              ),
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                              ),
                                              filled: true,
                                              fillColor: Colors.grey[50],
                                            ),
                                            validator: (value) {
                                              if (value!.isEmpty) {
                                                return 'Username tidak boleh kosong';
                                              } else if (value.contains(' ')) {
                                                return 'Username tidak boleh ada spasi';
                                              }
                                              return null;
                                            },
                                          ),

                                          const SizedBox(height: 20),

                                          // Phone number
                                          TextFormField(
                                            controller: controller
                                                .phoneNumberController,
                                            keyboardType: TextInputType.phone,
                                            decoration: InputDecoration(
                                              label: const Text(
                                                'Nomor Telepon',
                                              ),
                                              prefixIcon: const Icon(
                                                Icons.phone_rounded,
                                              ),
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                              ),
                                              filled: true,
                                              fillColor: Colors.grey[50],
                                            ),
                                            validator: (value) {
                                              if (value!.isEmpty) {
                                                return 'Nomor telepon tidak boleh kosong';
                                              } else if (!RegExp(
                                                r'^08[1-9][0-9]{7,10}$',
                                              ).hasMatch(value)) {
                                                return 'Nomor telepon tidak valid';
                                              }
                                              return null;
                                            },
                                          ),

                                          const SizedBox(height: 20),

                                          // Sex dropdown
                                          DropdownButtonFormField<String>(
                                            initialValue:
                                                controller
                                                    .sexController
                                                    .text
                                                    .isEmpty
                                                ? null
                                                : controller.sexController.text,
                                            decoration: InputDecoration(
                                              label: const Text(
                                                'Jenis Kelamin',
                                              ),
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                              ),
                                              filled: true,
                                              fillColor: Colors.grey[50],
                                            ),
                                            items: const [
                                              DropdownMenuItem(
                                                value: 'Laki-laki',
                                                child: Text('Pria'),
                                              ),
                                              DropdownMenuItem(
                                                value: 'Perempuan',
                                                child: Text('Wanita'),
                                              ),
                                            ],
                                            onChanged: (value) {
                                              controller.sexController.text =
                                                  value!;
                                            },
                                            validator: (value) {
                                              if (value == null ||
                                                  value.isEmpty) {
                                                return 'Jenis kelamin tidak boleh kosong';
                                              }
                                              return null;
                                            },
                                          ),

                                          const SizedBox(height: 20),

                                          // Password
                                          Obx(
                                            () => TextFormField(
                                              controller:
                                                  controller.passController,
                                              obscureText:
                                                  controller.isObsecure.value,
                                              decoration: InputDecoration(
                                                label: const Text('Password'),
                                                prefixIcon: const Icon(
                                                  Icons.lock_rounded,
                                                ),
                                                suffixIcon: IconButton(
                                                  onPressed:
                                                      controller.showPass,
                                                  icon: Icon(
                                                    controller.isObsecure.value
                                                        ? Icons
                                                              .visibility_rounded
                                                        : Icons
                                                              .visibility_off_rounded,
                                                  ),
                                                ),
                                                border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                ),
                                                filled: true,
                                                fillColor: Colors.grey[50],
                                              ),
                                              validator: (value) {
                                                if (value!.isEmpty) {
                                                  return 'Password tidak boleh kosong';
                                                } else if (value.contains(
                                                  ' ',
                                                )) {
                                                  return 'Password tidak boleh ada spasi';
                                                }
                                                return null;
                                              },
                                            ),
                                          ),

                                          const SizedBox(height: 20),

                                          // Retype password
                                          TextFormField(
                                            controller:
                                                controller.rePassController,
                                            obscureText: true,
                                            decoration: InputDecoration(
                                              label: const Text(
                                                'Ulangi Password',
                                              ),
                                              prefixIcon: const Icon(
                                                Icons.lock_reset_rounded,
                                              ),
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                              ),
                                              filled: true,
                                              fillColor: Colors.grey[50],
                                            ),
                                            validator: (value) {
                                              if (value!.isEmpty) {
                                                return 'Retype password tidak boleh kosong';
                                              } else if (value !=
                                                  controller
                                                      .passController
                                                      .text) {
                                                return 'Password tidak cocok';
                                              }
                                              return null;
                                            },
                                          ),

                                          // const SizedBox(height: 30),
                                          const Spacer(),

                                          // Register button
                                          SizedBox(
                                            width: double.infinity,
                                            height: 50,
                                            child: ElevatedButton(
                                              onPressed: controller.regist,
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor:
                                                    Colors.amber[700],
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                ),
                                              ),
                                              child: const Text(
                                                "Daftar Akun",
                                                style: TextStyle(
                                                  fontSize: 17,
                                                  fontWeight: FontWeight.bold,
                                                  color: Color(0xFFFFFFFF),
                                                ),
                                              ),
                                            ),
                                          ),

                                          //  Back to login
                                          // Center(
                                          //   child: TextButton(
                                          //     onPressed: () => Get.back(),
                                          //     child: const Text(
                                          //       "Sudah punya akun? Login",
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
                  },
                ),
        ),
      ),
    );
  }
}
