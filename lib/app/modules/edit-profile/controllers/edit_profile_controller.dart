import 'package:barsel_ecommerce_flutter_application_alter/app/data/services/user_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditProfileController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final fullnameController = TextEditingController();
  final addressController = TextEditingController();
  final birthPlaceController = TextEditingController();
  final birthDateController = TextEditingController();
  // final selectedSubdistrict = ''.obs;
  final subdistrictId = ''.obs;
  final cityId = '44'.obs;
  final provinceId = '14'.obs;
  final profilePicture = ''.obs;

  final idUser = ''.obs;

  final isLoading = false.obs;

  final _userServices = UserService();
  final picker = ImagePicker();

  @override
  void onInit() {
    super.onInit();
    getIdUser();

    final args = Get.arguments;

    if (args != null && args is Map) {
      fullnameController.text = args['fullname'];
      addressController.text = args['address'];
      birthPlaceController.text = args['birth_place'];
      birthDateController.text = args['birth_date'];
      subdistrictId.value = args['subdistrictId'];
      profilePicture.value = args['profile_picture'];
    }
  }

  Future<void> updateProfile() async {
    if (formKey.currentState!.validate()) {
      try {
        final response = await _userServices.updateProfileUser(
          idUser.value,
          fullnameController.text,
          addressController.text,
          birthPlaceController.text,
          birthDateController.text,
          provinceId.value,
          cityId.value,
          subdistrictId.value,
          profilePicture: profilePicture.value,
        );

        if (response['status'] == true) {
          final prefs = await SharedPreferences.getInstance();

          prefs.setString('fullname', fullnameController.text);
          prefs.setString('address', addressController.text);
          prefs.setString('place_of_birth', birthPlaceController.text);
          prefs.setString('date_of_birth', birthDateController.text);
          prefs.setString('subdistrict', subdistrictId.value);
          prefs.setString('profile_picture', profilePicture.value);

          // switch (selectedSubdistrict.value) {
          //   case '641':
          //     prefs.setString('subdistrict', 'Dusun Hilir');

          //     break;
          //   case '642':
          //     prefs.setString('subdistrict', 'Dusun Selatan');

          //     break;
          //   case '643':
          //     prefs.setString('subdistrict', 'Dusun Utara');

          //     break;
          //   case '644':
          //     prefs.setString('subdistrict', 'Gunung Bintang Awai');

          //     break;
          //   case '645':
          //     prefs.setString('subdistrict', 'Jenamas');

          //     break;
          //   case '646':
          //     prefs.setString('subdistrict', 'Karau Kulau');

          //     break;
          //   default:
          // }

          // Get.back();
          Get.offAllNamed('/home');

          // print('Success');
        } else {
          Get.snackbar(
            'Gagal Memperbarui Profile',
            response['message'],
            backgroundColor: Colors.red,
          );
        }

        // debug print for each column
        // print(fullnameController.text);
        // print(addressController.text);
        // print(birthPlaceController.text);
        // print(birthDateController.text);
        // print(selectedProvince.value);
        // print(selectedCity.value);
        // print(selectedSubdistrict.value);
      } catch (e) {
        Get.snackbar('Error', '$e', backgroundColor: Colors.red);
      } finally {}

      // print(fullnameController.text);
      // print(addressController.text);
      // print(birthPlaceController.text);
      // print(birthDateController.text);
      // print(selectedProvince.value);
      // print(selectedCity.value);
      // print(selectedSubdistrict.value);
    }
  }

  Future<void> getIdUser() async {
    final prefs = await SharedPreferences.getInstance();

    idUser.value = prefs.getString('id_user')!;
  }

  Future<void> pictureFromGallery() async {
    final image = await picker.pickImage(source: ImageSource.gallery);
    profilePicture.value = image!.path;
  }

  Future<void> takePicture() async {
    final image = await picker.pickImage(source: ImageSource.camera);
    profilePicture.value = image!.path;
  }
}
