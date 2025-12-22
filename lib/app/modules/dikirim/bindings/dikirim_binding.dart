import 'package:get/get.dart';

import '../controllers/dikirim_controller.dart';

class DikirimBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DikirimController>(
      () => DikirimController(),
    );
  }
}
