import 'package:barsel_ecommerce_flutter_application_alter/app/data/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passController = TextEditingController();

  final isObsecure = true.obs;
  final isLoading = false.obs;

  final _authServices = AuthService();

  void showPass() {
    isObsecure.value = !isObsecure.value;
  }

  Future<void> doLogin() async {
    if (formKey.currentState!.validate()) {
      try {
        isLoading.value = true;

        final response = await _authServices.login(
          emailController.text,
          passController.text,
        );

        print(response);

        if (response['status'] == true) {
          final Map<String, dynamic> user = response['data'];
          final prefs = await SharedPreferences.getInstance();

          prefs.setBool('login', true);
          prefs.setString('id_user', user['id_konsumen']);
          prefs.setString('username', user['username']);
          prefs.setString('email', user['email']);
          prefs.setString('phone_number', user['no_hp']);
          prefs.setString('sex', user['jenis_kelamin']);
          prefs.setString('regist_date', user['tanggal_daftar']);
          prefs.setString('fullname', user['nama_lengkap'] ?? '');
          prefs.setString('address', user['alamat_lengkap'] ?? '');
          prefs.setString('place_of_birth', user['tempat_lahir'] ?? '');
          prefs.setString('date_of_birth', user['tanggal_lahir'] ?? '');
          prefs.setString('subdistrict', user['kecamatan_id'] ?? '');
          prefs.setString('city', user['kota_id'] ?? '');
          prefs.setString('province', user['provinsi_id'] ?? '');
          prefs.setString('profile_picture', user['foto'] ?? '');

          if (prefs.getString('fullname') == null ||
              prefs.getString('address') == null ||
              prefs.getString('place_of_birth') == null ||
              prefs.getString('date_of_birth') == null ||
              prefs.getString('subdistrict') == '0' ||
              prefs.getString('city') == '0' ||
              prefs.getString('province') == '0') {
            Get.offAllNamed('/edit-profile');
          } else {
            Get.offAllNamed('/home');
          }
        } else {
          Get.snackbar(
            'Gagal Login',
            response['message'],
            backgroundColor: Colors.redAccent,
          );
        }
      } catch (e) {
        Get.snackbar(
          'Terjadi kesalahan',
          e.toString(),
          backgroundColor: Colors.redAccent,
        );
        // print('$e');
      } finally {
        isLoading.value = false;
      }
    }
  }
}
