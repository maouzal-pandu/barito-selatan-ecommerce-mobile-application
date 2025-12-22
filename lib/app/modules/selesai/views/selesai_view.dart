import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/selesai_controller.dart';

class SelesaiView extends GetView<SelesaiController> {
  const SelesaiView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SelesaiView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'SelesaiView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
