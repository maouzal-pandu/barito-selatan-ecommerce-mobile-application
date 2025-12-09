import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartController extends GetxController {
  final isLogin = false.obs;

  @override
  void onInit() {
    super.onInit();
    checkLogin();
  }

  void checkLogin() async {
    final prefs = await SharedPreferences.getInstance();

    isLogin.value = prefs.getBool('login') ?? false;
  }
}
