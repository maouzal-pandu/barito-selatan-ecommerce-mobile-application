import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/upload_bukti_pembayaran_controller.dart';

class UploadBuktiPembayaranView
    extends GetView<UploadBuktiPembayaranController> {
  const UploadBuktiPembayaranView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('UploadBuktiPembayaranView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'UploadBuktiPembayaranView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
