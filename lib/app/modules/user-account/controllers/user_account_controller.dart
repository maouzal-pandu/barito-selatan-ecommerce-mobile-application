import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserAccountController extends GetxController {
  final isLogin = false.obs;

  final username = ''.obs;
  final email = ''.obs;
  final phoneNumber = ''.obs;
  final sex = ''.obs;
  final registDate = ''.obs;
  final fullname = ''.obs;
  final address = ''.obs;
  final placeBirth = ''.obs;
  final dateBirth = ''.obs;
  final subdistrictId = ''.obs;
  final subdistrictName = ''.obs;
  // final city = ''.obs;
  // final province = ''.obs;
  final profilePicture = ''.obs;

  @override
  void onInit() {
    super.onInit();
    checkLogin();
  }

  void checkLogin() async {
    final prefs = await SharedPreferences.getInstance();

    isLogin.value = prefs.getBool('login') ?? false;

    if (isLogin.value == true) {
      username.value = prefs.getString('username') ?? '';
      email.value = prefs.getString('email') ?? '';
      phoneNumber.value = prefs.getString('phone_number') ?? '';
      sex.value = prefs.getString('sex') ?? '';
      registDate.value = prefs.getString('regist_date') ?? '';
      fullname.value = prefs.getString('fullname') ?? '';
      address.value = prefs.getString('address') ?? '';
      placeBirth.value = prefs.getString('place_of_birth') ?? '';
      dateBirth.value = prefs.getString('date_of_birth') ?? '';
      subdistrictId.value = prefs.getString('subdistrict') ?? '';
      // city.value = prefs.getString('city') ?? '';
      // province.value = prefs.getString('province') ?? '';
      profilePicture.value = prefs.getString('profile_picture') ?? '';

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
}
