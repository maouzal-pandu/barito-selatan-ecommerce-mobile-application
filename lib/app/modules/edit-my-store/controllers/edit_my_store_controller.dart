import 'package:barsel_ecommerce_flutter_application_alter/app/data/services/store_service.dart';
import 'package:barsel_ecommerce_flutter_application_alter/app/modules/my-store/controllers/my_store_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditMyStoreController extends GetxController {
  final profilePicture = ''.obs;
  final isHaveStore = false.obs;
  final resellerId = ''.obs;
  final provinceId = '14'.obs;
  final cityId = '44'.obs;
  final subdistrictId = '641'.obs;
  final selectedSubdistrict = ''.obs;
  final formKey = GlobalKey<FormState>();
  final storeAddressController = TextEditingController();
  final storePhoneNumberController = TextEditingController();
  final bankNameController = TextEditingController();
  final bankNumberController = TextEditingController();
  final bankOwnerController = TextEditingController();
  final storeAboutController = TextEditingController();
  final storeNameController = TextEditingController();
  final isLoading = false.obs;
  final listSubdistricts = [].obs;
  final _storeServices = StoreService();
  final picker = ImagePicker();

  @override
  void onInit() {
    super.onInit();
    final args = Get.arguments;
    if (args != null && args is Map) {
      isHaveStore.value = args['is_have_store'];
      resellerId.value = args['reseller_id'];
      profilePicture.value = args['store_profile_picture'];
      storeNameController.text = args['store_name'];
      subdistrictId.value = args['subdistrict_id'];
      storeAddressController.text = args['store_address'];
      storePhoneNumberController.text = args['store_phone_number'];
      bankNameController.text = args['bank_name'];
      bankNumberController.text = args['bank_number'];
      bankOwnerController.text = args['bank_owner'];
      storeAboutController.text = args['store_about'];
    } else {
      isHaveStore.value = args;
    }
    // getStoreInfo();
  }

  Future<void> updateStoreProfile() async {
    if (formKey.currentState!.validate()) {
      final isUpdate = isHaveStore.value;
      if (isUpdate) {
        // update store
        try {
          // print('update store');
          print(isUpdate);
          isLoading.value = true;
          final response = await _storeServices.updateStore(
            resellerId.value,
            storeNameController.text,
            provinceId.value.toString(),
            cityId.value.toString(),
            subdistrictId.value.toString(),
            storeAddressController.text,
            storePhoneNumberController.text,
            bankNameController.text,
            bankNumberController.text,
            bankOwnerController.text,
            storeAboutController.text,
            profilePicture: profilePicture.value,
          );
          if (response['status'] == true) {
            final prefs = await SharedPreferences.getInstance();
            prefs.setString('store_name', storeNameController.text);
            prefs.setString('subdistrict_id', subdistrictId.value);
            prefs.setString('store_address', storeAddressController.text);
            prefs.setString(
              'store_phone_number',
              storePhoneNumberController.text,
            );
            prefs.setString('bank_name', bankNameController.text);
            prefs.setString('bank_number', bankNumberController.text);
            prefs.setString('bank_owner', bankOwnerController.text);
            prefs.setString('store_about', storeAboutController.text);
            prefs.setString('store_picture', profilePicture.value);
            Get.snackbar(
              'Sukses',
              'Profil telah diperbarui',
              backgroundColor: Colors.blue,
            );
            Get.find<MyStoreController>().getStoreInfo();
            Get.offNamedUntil(
              '/my-store',
              (route) => route.settings.name == '/my-store',
            ); // print('Success');
          } else {
            Get.snackbar(
              'Error',
              response['message'],
              backgroundColor: Colors.redAccent,
            ); // print('Failed');
          }
        } catch (e) {
          Get.snackbar(
            'Error',
            '$e',
            backgroundColor: Colors.redAccent,
          ); // print('$e');
        } finally {
          isLoading.value = false;
        }
      } else {
        // create store
        print('create store');
        print(isUpdate);

        final prefs = await SharedPreferences.getInstance();
        final userId = prefs.getString('id_user')!;
        try {
          isLoading.value = true;
          final response = await _storeServices.createStore(
            userId,
            storeNameController.text,
            provinceId.value,
            cityId.value,
            subdistrictId.value,
            storeAddressController.text,
            storePhoneNumberController.text,
            bankNameController.text,
            bankNumberController.text,
            bankOwnerController.text,
            storeAboutController.text,
            profilePicture: profilePicture.value,
          );
          if (response['status'] == true) {
            Get.offNamed('/my-store');
            Get.snackbar(
              'Sukses',
              'Berhasil membuat toko',
              backgroundColor: Colors.blue,
            ); // print('Success');
          } else {
            Get.snackbar(
              'Gagal',
              response['message'],
              backgroundColor: Colors.redAccent,
            ); // print('Failed');
          }
        } catch (e) {
          Get.snackbar('Gagal', '$e', backgroundColor: Colors.redAccent);
          print('$e');
        } finally {
          isLoading.value = false;
        } // Debug // print('create store'); // print(profilePicture.value); // print(storeNameController.text); // print(provinceId.value); // print(subdistrictId.value); // print(cityId.value); // print(storeAddressController.text); // print(storePhoneNumberController.text); // print(bankNameController.text); // print(bankNumberController.text); // print(bankOwnerController.text); // print(storeAboutController.text);
      }
    }
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
