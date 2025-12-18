import 'dart:convert';

import 'package:barsel_ecommerce_flutter_application_alter/app/data/services/item_service.dart';
import 'package:barsel_ecommerce_flutter_application_alter/app/models/option_item.dart';
import 'package:barsel_ecommerce_flutter_application_alter/app/models/product_variation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddProductController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final isEdit = false.obs;
  final idProduk = ''.obs;
  final dataProduk = <String, dynamic>{}.obs;
  // final gambarProduk = <String>[].obs;
  // final variasiProduk = <Map<String, dynamic>>[].obs;

  final isPreOrder = false.obs;

  final isLoading = false.obs;

  final selectedCategoryId = ''.obs;
  final productNameController = TextEditingController();
  final productWeightController = TextEditingController();
  final productStockController = TextEditingController();
  // final productModalController = TextEditingController();
  final productPriceController = TextEditingController();
  final productDiscountController = TextEditingController();
  final productSKUController = TextEditingController();
  final productMinOrderController = TextEditingController();
  final productDescriptionController = TextEditingController();
  final productEstimationController = TextEditingController();
  final productType = 'Fisik'.obs;
  final productUnitController = TextEditingController();

  final productCategories = <Map<String, dynamic>>[].obs;
  final productImages = <String>[].obs;
  final productVariations = <ProductVariation>[].obs;

  final _itemService = ItemsService();

  final picker = ImagePicker();

  @override
  void onInit() {
    super.onInit();
    fetchCategories();
    productVariations.add(ProductVariation());

    final args = Get.arguments;

    if (args is Map<String, dynamic> && args['edit'] == true) {
      isEdit.value = true;
      idProduk.value = args['id_produk'];
      loadSelectedProduct();
    }
  }

  Future<void> fetchCategories() async {
    try {
      final response = await _itemService.category();

      productCategories.assignAll(response);
    } catch (e) {
      Get.snackbar('Error', '$e', backgroundColor: Colors.red);
    }
  }

  void addVariation() {
    productVariations.add(ProductVariation());
  }

  void removeVariation(int index) async {
    final variation = productVariations[index];

    if (isEdit.value && variation.id != null) {
      await _itemService.deleteProductVariation(variation.id.toString());
    }

    variation.dispose();
    productVariations.removeAt(index);
  }

  /// Add a new option (input + price) to a specific variation
  void addOption(int variationIndex) {
    if (variationIndex < 0 || variationIndex >= productVariations.length) {
      return;
    }
    productVariations[variationIndex].options.add(OptionItem());
  }

  /// Remove option row inside a specific variation
  void removeOption(int variationIndex, int optionIndex) {
    if (variationIndex < 0 || variationIndex >= productVariations.length) {
      return;
    }
    final opts = productVariations[variationIndex].options;
    if (opts.length > 1) {
      opts[optionIndex].dispose();
      opts.removeAt(optionIndex);
    }
  }

  @override
  void onClose() {
    // dispose all controllers to avoid leaks
    for (final v in productVariations) {
      v.dispose();
    }
    // also dispose other controllers (productNameController etc.) if you have them
    super.onClose();
  }

  Future<void> addProduct() async {
    if (formKey.currentState!.validate()) {
      try {
        isLoading.value = true;

        final prefs = await SharedPreferences.getInstance();
        final resellerId = prefs.getString('reseller_id');

        final variationsJson = productVariations
            .map((v) => v.toJson())
            .toList();
        final encodedVariations = jsonEncode(variationsJson);

        final response = await _itemService.uploadProduct(
          categoryId: selectedCategoryId.value,
          productName: productNameController.text,
          weight: productWeightController.text,
          minOrder: productMinOrderController.text,
          price: productPriceController.text,
          stock: productStockController.text,
          sku: productSKUController.text,
          description: productDescriptionController.text,
          estimation: productEstimationController.text,
          isPreorder: isPreOrder.value ? "1" : "0",
          variations: encodedVariations,
          images: productImages,
          resellerId: resellerId!,
          productType: productType.value,
          productUnit: productUnitController.text,
        );

        if (response['status'] == true) {
          Get.back();
          Get.snackbar(
            'Berhasil',
            'Berhasil menambahkan produk.',
            backgroundColor: Colors.blue,
          );
        } else {
          Get.snackbar(
            'Gagal Menambahkan Produk',
            response['message'],
            backgroundColor: Colors.red,
          );
        }
      } catch (e) {
        Get.snackbar('Error', '$e', backgroundColor: Colors.red);
      } finally {
        isLoading.value = false;
      }
    }
  }

  Future<void> pictureFromGallery() async {
    final image = await picker.pickImage(source: ImageSource.gallery);
    productImages.add(image!.path);
  }

  Future<void> takePicture() async {
    final image = await picker.pickImage(source: ImageSource.camera);
    productImages.add(image!.path);
  }

  // Fetch selected product for edit feature
  Future<void> loadSelectedProduct() async {
    try {
      isLoading.value = true;

      final response = await _itemService.fetchSelectedStoreProduct(
        idProduk.value,
      );

      final data = response['data'];

      print(data);

      if (response['status'] == true) {
        productNameController.text = data['nama_produk'] ?? '';
        productWeightController.text = data['berat'] ?? '';
        productPriceController.text = data['harga_konsumen'] ?? '';
        productUnitController.text = data['satuan'] ?? '';
        productDescriptionController.text = data['tentang_produk'] ?? '';
        productImages.assignAll(List<String>.from(data['gambar']));
        selectedCategoryId.value = data['id_kategori_produk'] ?? '';
        productMinOrderController.text = data['minimum'] ?? '';
        productType.value = data['jenis_produk'] ?? '';
        productSKUController.text = data['sku'] ?? '';

        productVariations.clear();

        if (data['variasi'] != null && data['variasi'] is List) {
          for (final v in data['variasi']) {
            productVariations.add(ProductVariation.fromJson(v));
          }
        }

        if (productVariations.isEmpty) {
          productVariations.add(ProductVariation());
        }

        print(productVariations.toJson());

        if (data['pre_order'] != null) {
          isPreOrder.value = true;
          productEstimationController.text = data['pre_order'];
        }
      } else {
        Get.snackbar(
          'Gagal mengambil produk',
          response['message'],
          backgroundColor: Colors.red,
        );
      }
    } catch (e) {
      Get.snackbar('Error', '$e', backgroundColor: Colors.red);
    } finally {
      isLoading.value = false;
    }
  }

  // Update selected product
  Future<void> updateSelectedProduct() async {
    try {
      final variationsJson = jsonEncode(
        productVariations.map((v) => v.toJson()).toList(),
      );

      final response = await _itemService.editStoreProduct(
        idProduk: idProduk.value,
        productName: productNameController.text,
        productPrice: productPriceController.text,
        productWeight: productWeightController.text,
        productMinOrder: productMinOrderController.text,
        productSku: productSKUController.text,
        productDescription: productDescriptionController.text,
        productUnit: productUnitController.text,
        productType: productType.value,
        idKategoriProduk: selectedCategoryId.value,
        variationsJson: variationsJson,
        imagePaths: productImages,
      );

      if (response['status'] == true) {
        Get.back();
        Get.snackbar(
          'Berhasil',
          'Berhasil menambahkan produk',
          backgroundColor: Colors.blue,
        );
      } else {
        Get.snackbar(
          'Gagal mengambil produk',
          response['message'],
          backgroundColor: Colors.red,
        );
      }
    } catch (e) {
      Get.snackbar('Error', '$e', backgroundColor: Colors.red);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> deleteSelectedImage(String imageUrl, int index) async {
    try {
      // Ambil nama file saja dari URL
      final filename = Uri.parse(imageUrl).pathSegments.last;

      final response = await _itemService.deleteImageProduct(
        idProduk.value,
        filename,
      );

      if (response['status'] == true) {
        productImages.removeAt(index);
      } else {
        Get.snackbar(
          'Gagal',
          response['message'] ?? 'Gagal menghapus gambar',
          backgroundColor: Colors.red,
        );
      }
    } catch (e) {
      Get.snackbar('Error', e.toString(), backgroundColor: Colors.red);
    }
  }
}
