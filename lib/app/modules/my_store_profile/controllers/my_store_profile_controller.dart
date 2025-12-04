import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyStoreProfileController extends GetxController {
  final haveStore = false.obs;
  final resellerId = ''.obs;
  final storeName = ''.obs;
  final subdistrictId = ''.obs;
  final subdistrictName = ''.obs;
  final storeAddress = ''.obs;
  final storePhoneNumber = ''.obs;
  final storeAbout = ''.obs;
  final storeProfilePicture = ''.obs;
  final bankName = ''.obs;
  final bankNumber = ''.obs;
  final bankOwner = ''.obs;
  final registDate = ''.obs;
  @override
  void onInit() {
    super.onInit();
    getStoreProfile();
  }

  void getStoreProfile() async {
    final prefs = await SharedPreferences.getInstance();
    haveStore.value = prefs.getBool('is_have_store')!;
    resellerId.value = prefs.getString('reseller_id')!;
    storeName.value = prefs.getString('store_name')!;
    subdistrictId.value = prefs.getString('subdistrict_id')!;
    storeAddress.value = prefs.getString('store_address')!;
    storePhoneNumber.value = prefs.getString('store_phone_number')!;
    bankName.value = prefs.getString('bank_name')!;
    bankNumber.value = prefs.getString('bank_number')!;
    bankOwner.value = prefs.getString('bank_owner')!;
    storeAbout.value = prefs.getString('store_about')!;
    storeProfilePicture.value = prefs.getString('store_picture')!;
    registDate.value = prefs.getString('regist_date')!;
    switch (subdistrictId.value) {
      case '641':
        subdistrictName.value = "Dusun Hilir";
        break;
      case '642':
        subdistrictName.value = "Dusun Selatan";
        break;
      case '643':
        subdistrictName.value = "Dusun Utara";
        break;
      case '644':
        subdistrictName.value = "Gunung Bintang Awai";
        break;
      case '645':
        subdistrictName.value = "Jenamas";
        break;
      case '646':
        subdistrictName.value = "Karau Kuala";
        break;
      default:
        subdistrictName.value = "Karau Kuala";
        break;
    }
  }
}
