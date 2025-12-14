import 'package:flutter/material.dart';

class OptionItem {
  final TextEditingController name = TextEditingController();
  final TextEditingController price = TextEditingController();

  void dispose() {
    name.dispose();
    price.dispose();
  }

  Map<String, dynamic> toJson() {
    return {"value": name.text, "price": price.text};
  }
}
