import 'package:barsel_ecommerce_flutter_application_alter/app/data/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final usernameController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final passController = TextEditingController();
  final rePassController = TextEditingController();
  final sexController = TextEditingController();
  final isObsecure = true.obs;

  final _authServices = AuthService();

  final isLoading = false.obs;

  void showPass() {
    isObsecure.value = !isObsecure.value;
  }

  Future<void> regist() async {
    if (formKey.currentState!.validate()) {
      try {
        isLoading.value = true;

        final response = await _authServices.register(
          emailController.text,
          usernameController.text,
          phoneNumberController.text,
          passController.text,
          sexController.text,
        );

        if (response['status'] == true) {
          Get.toNamed('/verify-otp', arguments: emailController.text);
        } else if (response['status'] == false) {
          Get.snackbar(
            'Gagal Registrasi',
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
}
