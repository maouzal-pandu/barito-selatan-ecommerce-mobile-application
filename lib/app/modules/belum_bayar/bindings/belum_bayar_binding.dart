import 'package:get/get.dart';

import '../controllers/belum_bayar_controller.dart';

class BelumBayarBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BelumBayarController>(
      () => BelumBayarController(),
    );
  }
}
