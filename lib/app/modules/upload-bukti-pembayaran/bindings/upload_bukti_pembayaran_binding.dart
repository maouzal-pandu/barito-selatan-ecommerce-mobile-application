import 'package:get/get.dart';

import '../controllers/upload_bukti_pembayaran_controller.dart';

class UploadBuktiPembayaranBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UploadBuktiPembayaranController>(
      () => UploadBuktiPembayaranController(),
    );
  }
}
