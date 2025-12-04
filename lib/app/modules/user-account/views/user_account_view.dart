import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/user_account_controller.dart';

class UserAccountView extends GetView<UserAccountController> {
  const UserAccountView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async => controller.checkLogin(),
        child: Container(
          // 🌈 Background Gradient
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

          child: Obx(
            () => Center(
              child: controller.isLogin.value
                  ? SingleChildScrollView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const SizedBox(height: 60),

                            // --- Profile Picture ---
                            Center(
                              child: controller.profilePicture.value == ''
                                  ? const CircleAvatar(
                                      radius: 60,
                                      child: Icon(
                                        Icons.person_rounded,
                                        size: 50,
                                      ),
                                    )
                                  : ClipOval(
                                      child: CircleAvatar(
                                        radius: 60,
                                        backgroundColor: Colors.grey.shade200,
                                        child:
                                            controller.profilePicture.value
                                                .contains('/asset/foto_user/')
                                            ? Image.network(
                                                controller.profilePicture.value,
                                                fit: BoxFit.cover,
                                              )
                                            : Image.file(
                                                File(
                                                  controller
                                                      .profilePicture
                                                      .value,
                                                ),
                                                fit: BoxFit.cover,
                                              ),
                                      ),
                                    ),
                            ),

                            const SizedBox(height: 16),

                            // Username
                            Text(
                              controller.username.value,
                              style: const TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            Text(
                              controller.email.value,
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey.shade600,
                              ),
                            ),

                            const SizedBox(height: 20),

                            // --- Edit Button ---
                            Align(
                              alignment: Alignment.centerRight,
                              child: ElevatedButton.icon(
                                style: ElevatedButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 20,
                                    vertical: 12,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                onPressed: () => Get.toNamed(
                                  '/edit-profile',
                                  arguments: {
                                    'fullname': controller.fullname.value,
                                    'address': controller.address.value,
                                    'birth_place': controller.placeBirth.value,
                                    'birth_date': controller.dateBirth.value,
                                    'subdistrictId':
                                        controller.subdistrictId.value,
                                    'profile_picture':
                                        controller.profilePicture.value,
                                  },
                                ),
                                icon: const Icon(Icons.edit_rounded),
                                label: const Text("Edit Profil"),
                              ),
                            ),

                            const SizedBox(height: 15),

                            // --- Profile Card ---
                            SizedBox(
                              width: double.infinity,
                              child: Card(
                                elevation: 3,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(20),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      profileItem(
                                        "Nomor Telepon",
                                        controller.phoneNumber.value,
                                      ),
                                      profileItem(
                                        "Jenis Kelamin",
                                        controller.sex.value,
                                      ),
                                      profileItem(
                                        "Tanggal Registrasi",
                                        controller.registDate.value,
                                      ),
                                      profileItem(
                                        "Nama Lengkap",
                                        controller.fullname.value,
                                      ),
                                      profileItem(
                                        "Alamat",
                                        controller.address.value,
                                      ),
                                      profileItem(
                                        "Tempat Lahir",
                                        controller.placeBirth.value,
                                      ),
                                      profileItem(
                                        "Tanggal Lahir",
                                        controller.dateBirth.value,
                                      ),
                                      profileItem(
                                        "Kecamatan",
                                        controller.subdistrictName.value,
                                      ),
                                      profileItem("Kota", "Barito Selatan"),
                                      profileItem(
                                        "Provinsi",
                                        "Kalimantan Tengah",
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),

                            const SizedBox(height: 30),
                          ],
                        ),
                      ),
                    )
                  : Column(
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
                              Colors.amber[600],
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

Widget profileItem(String title, String value) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 12),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
      ],
    ),
  );
}
