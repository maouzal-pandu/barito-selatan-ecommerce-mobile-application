import 'dart:io';

import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/edit_my_store_controller.dart';

class EditMyStoreView extends GetView<EditMyStoreController> {
  const EditMyStoreView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('EditMyStoreView'), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Center(
          child: Obx(
            () => SingleChildScrollView(
              child: Form(
                key: controller.formKey,
                child: Column(
                  children: [
                    const SizedBox(height: 25),

                    // store photo profil
                    Align(
                      alignment: Alignment.center,
                      child: ClipOval(
                        child: InkWell(
                          onTap: () => showModalBottomSheet(
                            context: context,
                            builder: (context) {
                              return Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 8.0),
                                    child: const Text(
                                      'Pilih sumber foto',
                                      style: TextStyle(fontSize: 20),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: double.infinity,
                                    child: Divider(),
                                  ),

                                  const SizedBox(height: 25),

                                  ListTile(
                                    leading: const Icon(Icons.camera_rounded),
                                    title: const Text('Kamera'),
                                    onTap: () => controller.takePicture(),
                                  ),

                                  ListTile(
                                    leading: const Icon(Icons.photo_rounded),
                                    title: const Text('Galeri'),
                                    onTap: () =>
                                        controller.pictureFromGallery(),
                                  ),
                                ],
                              );
                            },
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(360)),
                          child: Stack(
                            children: [
                              // profile picture
                              Obx(
                                () => CircleAvatar(
                                  radius: 75,
                                  backgroundColor: Colors.grey[300],
                                  child: controller.profilePicture.value == ''
                                      ? const Icon(Icons.person_rounded)
                                      : controller.profilePicture.value
                                            .contains('/asset/foto_user/')
                                      ? ClipOval(
                                          child: CircleAvatar(
                                            radius: 75,
                                            child: Image.network(
                                              controller.profilePicture.value,
                                            ),
                                          ),
                                        )
                                      : CircleAvatar(
                                          radius: 75,
                                          child: Image.file(
                                            File(
                                              controller.profilePicture.value,
                                            ),
                                          ),
                                        ),
                                ),
                              ),

                              Positioned(
                                bottom: 0,
                                left: 0,
                                right: 0,
                                child: Container(
                                  height: 45,
                                  color: Color(0x99000000),
                                  child: const Center(
                                    child: Icon(
                                      Icons.camera_alt,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 30),

                    // Store name
                    TextFormField(
                      controller: controller.storeNameController,
                      decoration: InputDecoration(
                        label: const Text('Nama toko'),
                        // hintText: 'contoh@email.com',
                        helperText: 'Masukan nama toko anda!',
                        prefixIcon: const Icon(Icons.store_rounded),
                        border: OutlineInputBorder(),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                      ),
                      validator: (value) {
                        if (value!.isEmpty || value == '') {
                          return 'Nama toko tidak boleh kosong';
                        }

                        return null;
                      },
                    ),

                    const SizedBox(height: 25),

                    // dropdown province
                    DropdownButtonFormField(
                      initialValue: controller.provinceId.value,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        label: const Text('Provinsi'),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                      ),
                      items: [
                        DropdownMenuItem(
                          value: "14",
                          child: const Text('Kalimantan Tengah'),
                        ),
                      ],
                      onChanged: (value) =>
                          controller.provinceId.value = value!,
                      validator: (value) {
                        if (value == null) {
                          return 'Pilih provinsi terlebih dahulu';
                        }
                        return null;
                      },
                    ),

                    const SizedBox(height: 25),

                    // dropdown city / kabupaten
                    DropdownButtonFormField(
                      initialValue: controller.cityId.value,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        label: const Text('Kabupaten'),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                      ),
                      items: [
                        DropdownMenuItem(
                          value: "44",
                          child: const Text('Barito Selatan'),
                        ),
                      ],
                      onChanged: (value) {
                        controller.cityId.value = value!;
                      },
                      validator: (value) {
                        if (value == null) {
                          return 'Pilih kecamatan terlebih dahulu';
                        }
                        return null;
                      },
                    ),

                    const SizedBox(height: 25),

                    // dropdown city / kabupaten
                    DropdownButtonFormField(
                      initialValue: controller.cityId.value,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        label: const Text('Kabupaten'),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                      ),
                      items: [
                        DropdownMenuItem(
                          value: "44",
                          child: const Text('Barito Selatan'),
                        ),
                      ],
                      onChanged: (value) {
                        controller.cityId.value = value!;
                      },
                      validator: (value) {
                        if (value == null) {
                          return 'Pilih kecamatan terlebih dahulu';
                        }
                        return null;
                      },
                    ),

                    const SizedBox(height: 25),

                    // dropdown subdistrict
                    DropdownButtonFormField(
                      initialValue: controller.subdistrictId.value,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        label: const Text('Kecamatana'),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                      ),
                      items: [
                        DropdownMenuItem(
                          value: "641",
                          child: const Text('Dusun Hilir'),
                        ),
                        DropdownMenuItem(
                          value: "642",
                          child: const Text('Dusun Selatan'),
                        ),
                        DropdownMenuItem(
                          value: "643",
                          child: const Text('Dusun Utara'),
                        ),
                        DropdownMenuItem(
                          value: "644",
                          child: const Text('Gunung Bintang Awai'),
                        ),
                        DropdownMenuItem(
                          value: "645",
                          child: const Text('Jenamas'),
                        ),
                        DropdownMenuItem(
                          value: "646",
                          child: const Text('Karau Kuala'),
                        ),
                      ],
                      onChanged: (value) {
                        controller.subdistrictId.value = value!;
                      },
                      validator: (value) {
                        if (value == null) {
                          return 'Pilih kecamatan terlebih dahulu';
                        }
                        return null;
                      },
                    ),

                    const SizedBox(height: 25),

                    // Store address
                    TextFormField(
                      controller: controller.storeAddressController,
                      decoration: InputDecoration(
                        label: const Text('Alamat toko'),
                        // hintText: 'contoh@email.com',
                        helperText: 'Masukan alamat lengkap toko anda!',
                        // prefixIcon: const Icon(Icons.pin),
                        border: OutlineInputBorder(),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                      ),
                      maxLines: 3,
                      validator: (value) {
                        if (value!.isEmpty || value == '') {
                          return 'Alamat toko tidak boleh kosong';
                        }

                        return null;
                      },
                    ),

                    const SizedBox(height: 25),

                    // Store contact
                    TextFormField(
                      controller: controller.storePhoneNumberController,
                      decoration: InputDecoration(
                        label: const Text('Nomer telepon toko'),
                        hintText: '0877XXXXXXXX',
                        // helperText: 'Masukan nama toko anda!',
                        prefixIcon: const Icon(Icons.phone_rounded),
                        border: OutlineInputBorder(),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                      ),
                      validator: (value) {
                        if (value!.isEmpty || value == '') {
                          return 'Nomer telepon toko tidak boleh kosong';
                        } else if (!RegExp(
                          r'^08[1-9][0-9]{7,10}$',
                        ).hasMatch(value)) {
                          return 'Nomer telepon tidak valid';
                        }

                        return null;
                      },
                    ),

                    const SizedBox(height: 25),

                    // Bank name
                    TextFormField(
                      controller: controller.bankNameController,
                      decoration: InputDecoration(
                        label: const Text('Nama Bank'),
                        // hintText: 'contoh@email.com',
                        helperText:
                            'Masukan nama bank yang digunakan untuk proses pembayran!',
                        prefixIcon: const Icon(Icons.account_balance_rounded),
                        border: OutlineInputBorder(),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                      ),
                      validator: (value) {
                        if (value!.isEmpty || value == '') {
                          return 'Nama bank tidak boleh kosong';
                        }

                        return null;
                      },
                    ),

                    const SizedBox(height: 25),

                    // Bank number
                    TextFormField(
                      controller: controller.bankNumberController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        label: const Text('Nomer rekening bank'),
                        // hintText: 'contoh@email.com',
                        helperText: 'Masukan nama rekening anda!',
                        prefixIcon: const Icon(Icons.credit_card_rounded),
                        border: OutlineInputBorder(),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                      ),
                      validator: (value) {
                        if (value!.isEmpty || value == '') {
                          return 'Nomer rekening tidak boleh kosong';
                        } else if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
                          return 'Nomer rekening tidak valid';
                        }

                        return null;
                      },
                    ),

                    const SizedBox(height: 25),

                    // Bank owner
                    TextFormField(
                      controller: controller.bankOwnerController,
                      decoration: InputDecoration(
                        label: const Text('Nama penerima bank'),
                        // hintText: 'contoh@email.com',
                        helperText: 'Masukan nama pemilik bank',
                        prefixIcon: const Icon(Icons.person_rounded),
                        border: OutlineInputBorder(),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                      ),
                      validator: (value) {
                        if (value!.isEmpty || value == '') {
                          return 'Nama penerima bank tidak boleh kosong';
                        }

                        return null;
                      },
                    ),

                    const SizedBox(height: 25),

                    // Store about
                    TextFormField(
                      controller: controller.storeAboutController,
                      decoration: InputDecoration(
                        label: const Text('Tentang toko'),
                        // hintText: 'contoh@email.com',
                        helperText: 'Deskripsikan toko anda',
                        // prefixIcon: const Icon(Icons.pin),
                        border: OutlineInputBorder(),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                      ),
                      maxLines: 3,
                    ),

                    const SizedBox(height: 30),

                    // update button
                    Align(
                      alignment: Alignment.centerRight,
                      child: FilledButton(
                        style: ButtonStyle(
                          shape: WidgetStatePropertyAll(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadiusGeometry.circular(8),
                            ),
                          ),
                        ),
                        onPressed: () => controller.updateStoreProfile(),
                        child: const Text('Update'),
                      ),
                    ),

                    const SizedBox(height: 30),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
