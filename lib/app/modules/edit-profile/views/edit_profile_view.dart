import 'dart:io';

import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/edit_profile_controller.dart';

class EditProfileView extends GetView<EditProfileController> {
  const EditProfileView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Center(
        child: Obx(
          () => controller.isLoading.value
              ? CircularProgressIndicator()
              : SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Form(
                      key: controller.formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(height: 60),

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
                                          padding: const EdgeInsets.only(
                                            top: 8.0,
                                          ),
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
                                          leading: const Icon(
                                            Icons.camera_rounded,
                                          ),
                                          title: const Text('Kamera'),
                                          onTap: () => controller.takePicture(),
                                        ),

                                        ListTile(
                                          leading: const Icon(
                                            Icons.photo_rounded,
                                          ),
                                          title: const Text('Galeri'),
                                          onTap: () =>
                                              controller.pictureFromGallery(),
                                        ),
                                      ],
                                    );
                                  },
                                ),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(360),
                                ),
                                child: Stack(
                                  children: [
                                    // profile picture
                                    Obx(
                                      () => CircleAvatar(
                                        radius: 75,
                                        backgroundColor: Colors.grey[300],
                                        child:
                                            controller.profilePicture.value ==
                                                ''
                                            ? const Icon(Icons.person_rounded)
                                            : controller.profilePicture.value
                                                  .contains('/asset/foto_user/')
                                            ? ClipOval(
                                                child: CircleAvatar(
                                                  radius: 75,
                                                  child: Image.network(
                                                    controller
                                                        .profilePicture
                                                        .value,
                                                  ),
                                                ),
                                              )
                                            : CircleAvatar(
                                                radius: 75,
                                                child: Image.file(
                                                  File(
                                                    controller
                                                        .profilePicture
                                                        .value,
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

                          const Text(
                            'Foto tidak boleh lebih dari 2MB',
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.grey),
                          ),

                          const SizedBox(height: 35),

                          // fullname text field
                          TextFormField(
                            controller: controller.fullnameController,
                            decoration: InputDecoration(
                              label: const Text('Nama lengkap'),
                              // hintText: 'contoh@email.com',
                              helperText: 'Masukan nama lengkap anda!',
                              prefixIcon: const Icon(Icons.person_rounded),
                              border: OutlineInputBorder(),
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always,
                            ),
                            validator: (value) {
                              if (value!.isEmpty || value == '') {
                                return 'Nama lengkap tidak boleh kosong';
                              }

                              return null;
                            },
                          ),

                          const SizedBox(height: 25),

                          // address text field
                          TextFormField(
                            controller: controller.addressController,
                            maxLines: 3,
                            decoration: InputDecoration(
                              label: const Text('Alamat lengkap'),
                              // hintText: 'contoh@email.com',
                              // prefixIcon: const Icon(Icons.home_rounded),
                              border: OutlineInputBorder(),
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always,
                            ),
                            validator: (value) {
                              if (value!.isEmpty || value == '') {
                                return 'Alamat lengkap tidak boleh kosong';
                              }

                              return null;
                            },
                          ),

                          const SizedBox(height: 25),

                          // place of birth text field
                          TextFormField(
                            controller: controller.birthPlaceController,
                            decoration: InputDecoration(
                              label: const Text('Tempat lahir'),
                              // hintText: 'contoh@email.com',
                              // prefixIcon: const Icon(Icons.home),
                              border: OutlineInputBorder(),
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always,
                            ),
                            validator: (value) {
                              if (value!.isEmpty || value == '') {
                                return 'Tempat lahir tidak boleh kosong';
                              }

                              return null;
                            },
                          ),

                          const SizedBox(height: 25),

                          // date of birth text field
                          TextFormField(
                            controller: controller.birthDateController,
                            decoration: InputDecoration(
                              label: const Text('Tanggal lahir'),
                              // hintText: 'contoh@email.com',
                              prefixIcon: const Icon(
                                Icons.calendar_month_rounded,
                              ),
                              border: OutlineInputBorder(),
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always,
                            ),
                            readOnly: true,
                            onTap: () async {
                              final DateTime? pickedDate = await showDatePicker(
                                context: context,
                                firstDate: DateTime(1945),
                                lastDate: DateTime.now(),
                                initialDate: DateTime.now(),
                              );

                              if (pickedDate != null) {
                                final formattedDate =
                                    '${pickedDate.year.toString()}-${pickedDate.month.toString().padLeft(2, '0')}-${pickedDate.day.toString().padLeft(2, '0')}';

                                controller.birthDateController.text =
                                    formattedDate;
                              }
                            },
                            validator: (value) {
                              if (value!.isEmpty || value == '') {
                                return 'Tanggal lahir tidak boleh kosong';
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
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always,
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
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always,
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
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always,
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

                          const SizedBox(height: 30),

                          // register txt button
                          Align(
                            alignment: AlignmentGeometry.centerRight,
                            child: FilledButton(
                              style: ButtonStyle(
                                shape: WidgetStatePropertyAll(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadiusGeometry.all(
                                      Radius.circular(8),
                                    ),
                                  ),
                                ),
                              ),
                              onPressed: () => controller.updateProfile(),
                              child: const Text('Update Profile'),
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
