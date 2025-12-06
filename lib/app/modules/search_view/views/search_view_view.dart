import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/search_view_controller.dart';

class SearchViewView extends GetView<SearchViewController> {
  const SearchViewView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SearchViewView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'SearchViewView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
