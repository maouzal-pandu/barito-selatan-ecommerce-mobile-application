import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'option_item.dart';

class ProductVariation {
  final TextEditingController name = TextEditingController();
  final RxList<OptionItem> options = <OptionItem>[].obs;

  ProductVariation() {
    options.add(OptionItem());
  }

  void dispose() {
    name.dispose();
    for (final o in options) {
      o.dispose();
    }
  }
}
