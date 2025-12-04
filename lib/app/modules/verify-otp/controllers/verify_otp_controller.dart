import 'package:barsel_ecommerce_flutter_application_alter/app/data/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VerifyOtpController extends GetxController {
  final _authServices = AuthService();

  late String email;
  final otpController = TextEditingController();

  final isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    email = Get.arguments;
  }

  Future<void> verifyOTP() async {
    try {
      isLoading.value = true;

      final response = await _authServices.verifyOtp(email, otpController.text);

      if (response['status'] == true) {
        Get.snackbar(
          'Akun telah terverifikasi',
          'Silahkan login dengan akun anda',
        );
        Get.offNamedUntil('/login', ModalRoute.withName('/home'));
      } else {
        Get.snackbar(
          'Gagal Verifikasi Akun',
          response['message'],
          backgroundColor: Colors.redAccent,
        );
      }
    } catch (e) {
      Get.snackbar('Error', '$e', backgroundColor: Colors.redAccent);
    } finally {
      isLoading.value = false;
    }
  }
}
