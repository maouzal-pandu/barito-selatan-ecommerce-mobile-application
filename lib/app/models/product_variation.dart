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

  Map<String, dynamic> toJson() {
    return {
      "variation_name": name.text.trim(),
      "variation_values": options.map((o) => o.name.text.trim()).toList(),
      "variation_prices": options.map((o) => o.price.text.trim()).toList(),
    };
  }
}
