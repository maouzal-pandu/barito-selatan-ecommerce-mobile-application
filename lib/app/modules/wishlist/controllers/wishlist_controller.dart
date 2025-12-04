import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WishlistController extends GetxController {
  final isLogin = false.obs;

  @override
  void onInit() {
    super.onInit();
    loginCheck();
  }

  void loginCheck() async {
    final prefs = await SharedPreferences.getInstance();

    isLogin.value = prefs.getBool('login')!;
  }
}
