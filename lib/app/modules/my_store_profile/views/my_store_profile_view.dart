import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/my_store_profile_controller.dart';

class MyStoreProfileView extends GetView<MyStoreProfileController> {
  const MyStoreProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        actionsPadding: EdgeInsets.symmetric(horizontal: 8),
        actions: [
          FilledButton.icon(
            onPressed: () => Get.toNamed(
              '/edit-my-store',
              arguments: {
                'is_have_store': controller.haveStore.value,
                'reseller_id': controller.resellerId.value,
                'store_profile_picture': controller.storeProfilePicture.value,
                'store_name': controller.storeName.value,
                'subdistrict_id': controller.subdistrictId.value,
                'store_address': controller.storeAddress.value,
                'store_phone_number': controller.storePhoneNumber.value,
                'bank_name': controller.bankName.value,
                'bank_number': controller.bankNumber.value,
                'bank_owner': controller.bankOwner.value,
                'store_about': controller.storeAbout.value,
              },
            ),
            label: const Text('Edit Profile'),
            icon: const Icon(Icons.edit_rounded),
            style: ButtonStyle(
              shape: WidgetStatePropertyAll(
                RoundedRectangleBorder(
                  borderRadius: BorderRadiusGeometry.all(Radius.circular(8)),
                ),
              ),
            ),
          ),
        ],
      ),

      body: Obx(
        () => SingleChildScrollView(
          // padding: const EdgeInsets.all(8),
          child: _storeProfile(context),
        ),
      ),
    );
  }

  Widget _storeProfile(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          const SizedBox(height: 30),

          _buildProfilePicture(),

          const SizedBox(height: 15),

          Text(controller.haveStore.value.toString()),

          Text(
            controller.storeName.value,
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 5),

          Text(
            "Terdaftar pada: ${controller.registDate.value}",
            style: const TextStyle(color: Colors.grey),
          ),

          const SizedBox(height: 20),
          const Divider(),

          _infoTile(
            Icons.location_on_rounded,
            "Alamat",
            controller.storeAddress.value,
          ),
          _infoTile(
            Icons.pin_drop_rounded,
            "Kecamatan",
            controller.subdistrictName.value,
          ),
          _infoTile(Icons.pin_drop_rounded, "Kabupaten", "Barito Selatan"),
          _infoTile(Icons.pin_drop_rounded, "Provinsi", "Kalimantan Tengah"),
          _infoTile(
            Icons.phone_rounded,
            "No. Telepon",
            controller.storePhoneNumber.value,
          ),
          _infoTile(
            Icons.account_balance_rounded,
            "Bank",
            controller.bankName.value,
          ),
          _infoTile(
            Icons.numbers_rounded,
            "No. Rekening",
            controller.bankNumber.value,
          ),
          _infoTile(
            Icons.person_rounded,
            "Pemilik Rekening",
            controller.bankOwner.value,
          ),
          _infoTile(
            Icons.store_rounded,
            "Tentang Toko",
            controller.storeAbout.value,
          ),

          const SizedBox(height: 20),

          // Tombol Edit Store
          // SizedBox(
          //   width: double.infinity,
          //   child: ElevatedButton.icon(
          //     onPressed: () {
          //       Get.toNamed('/edit-my-store', arguments: {});
          //     },
          //     icon: const Icon(Icons.edit),
          //     label: const Text("Edit Store"),
          //     style: ElevatedButton.styleFrom(
          //       padding: const EdgeInsets.symmetric(vertical: 14),
          //       shape: RoundedRectangleBorder(
          //         borderRadius: BorderRadius.circular(12),
          //       ),
          //       backgroundColor: Colors.amber,
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }

  // Foto Profil Toko
  Widget _buildProfilePicture() {
    final path = controller.storeProfilePicture.value;

    if (path.isEmpty) {
      return const CircleAvatar(
        radius: 50,
        child: Icon(Icons.storefront_rounded, size: 50),
      );
    }

    if (path.contains('/asset/foto_user/')) {
      return CircleAvatar(radius: 50, backgroundImage: NetworkImage(path));
    }

    return CircleAvatar(radius: 50, backgroundImage: FileImage(File(path)));
  }

  // Item Informasi
  Widget _infoTile(IconData icon, String title, String value) {
    return ListTile(
      leading: Icon(icon, color: Colors.amber),
      title: Text(title),
      subtitle: Text(
        value.isEmpty ? "-" : value,
        style: const TextStyle(fontSize: 16),
      ),
      contentPadding: const EdgeInsets.symmetric(vertical: 6),
    );
  }
}
