import 'package:barsel_ecommerce_flutter_application_alter/app/data/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgetPassController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();

  final isLoading = false.obs;

  final _authServices = AuthService();

  Future<void> sendResetPassEmail() async {
    if (formKey.currentState!.validate()) {
      try {
        isLoading.value = true;

        final response = await _authServices.forgetPass(emailController.text);

        if (response['status'] == true) {
          Get.snackbar('Berhasil Mengirim Email', response['message']);
        } else if (response['status'] == false) {
          Get.snackbar(
            'Gagal Mengirim Email',
            response['message'],
            backgroundColor: Colors.redAccent,
          );
        }
      } catch (e) {
        Get.snackbar('Error', e.toString(), backgroundColor: Colors.redAccent);
      } finally {
        isLoading.value = false;
        emailController.clear();
      }
    }
  }
}
