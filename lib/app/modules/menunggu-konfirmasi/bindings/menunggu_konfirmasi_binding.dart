import 'package:get/get.dart';

import '../controllers/menunggu_konfirmasi_controller.dart';

class MenungguKonfirmasiBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MenungguKonfirmasiController>(
      () => MenungguKonfirmasiController(),
    );
  }
}
