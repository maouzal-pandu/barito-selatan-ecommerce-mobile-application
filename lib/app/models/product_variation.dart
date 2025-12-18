import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'option_item.dart';

class ProductVariation {
  int? id; // 🔥 ID variasi (penting untuk delete API)

  final TextEditingController name = TextEditingController();
  final RxList<OptionItem> options = <OptionItem>[].obs;

  ProductVariation({this.id});

  factory ProductVariation.fromJson(Map<String, dynamic> json) {
    final variation = ProductVariation(
      id: json['id'] != null ? int.tryParse(json['id'].toString()) : null,
    );

    variation.name.text = json['nama'] ?? '';

    variation.options.clear();

    final List opsi = json['opsi'] ?? [];
    final dynamic hargaRaw = json['harga'];

    for (int i = 0; i < opsi.length; i++) {
      final option = OptionItem();
      option.name.text = opsi[i].toString();

      // 🔥 HANDLE LIST / MAP (AMAN)
      if (hargaRaw is List) {
        option.price.text = (i < hargaRaw.length)
            ? hargaRaw[i].toString()
            : '0';
      } else if (hargaRaw is Map) {
        option.price.text = hargaRaw[(i + 1).toString()]?.toString() ?? '0';
      } else {
        option.price.text = '0';
      }

      variation.options.add(option);
    }

    // fallback minimal 1 option
    if (variation.options.isEmpty) {
      variation.options.add(OptionItem());
    }

    return variation;
  }

  /// 🔥 JSON UNTUK ADD / UPDATE PRODUK
  /// (ID tidak dikirim, biar backend aman)
  Map<String, dynamic> toJson() {
    return {
      "id": id, // 🔥 WAJIB DIKIRIM SAAT EDIT
      "variation_name": name.text.trim(),
      "variation_values": options.map((o) => o.name.text.trim()).toList(),
      "variation_prices": options.map((o) => o.price.text.trim()).toList(),
    };
  }

  void dispose() {
    name.dispose();
    for (final o in options) {
      o.dispose();
    }
  }
}
