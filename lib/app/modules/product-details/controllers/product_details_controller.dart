import 'package:barsel_ecommerce_flutter_application_alter/app/data/services/item_service.dart';
import 'package:barsel_ecommerce_flutter_application_alter/app/data/services/store_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class ProductDetailsController extends GetxController {
  final productId = ''.obs;
  final resellerId = ''.obs;

  // ===== PRODUK =====
  final productImages = [].obs;
  final data = <String, dynamic>{}.obs;
  final reviews = <Map<String, dynamic>>[].obs;
  final jumlahPesan = 1.obs;

  // variasi: {Ukuran: [{value, harga}], Warna: [...]}
  final productVariations = <String, List<Map<String, dynamic>>>{}.obs;

  // variasi terpilih: {Ukuran: {value, harga}}
  final selectedVariation = <String, Map<String, dynamic>>{}.obs;

  final imageController = PageController();
  final currentImageIndex = 0.obs;

  // final jumlahProduk = 1.obs;

  // ===== TOKO =====
  final storeProfilePicture = ''.obs;
  final storeData = <String, dynamic>{}.obs;

  final relatedProducts = <Map<String, dynamic>>[].obs;

  final isInWishlist = false.obs;

  // ===== LOADING =====
  final isLoadingProduct = false.obs;
  final isLoadingMoreProducts = false.obs;
  final isLoadingReviews = false.obs;
  final isLoadingStore = false.obs;
  final isLoadingRelatedProducts = false.obs;

  final totalProductPage = 0.obs;
  final currentProductPage = 0.obs;

  final _itemsService = ItemsService();
  final _storeService = StoreService();

  final scrollController = ScrollController();

  // ================= INIT =================
  @override
  void onInit() {
    super.onInit();

    final args = Get.arguments;
    productId.value = args['id_product'];
    resellerId.value = args['id_reseller'];

    _initializeData();

    scrollController.addListener(() {
      if (scrollController.position.pixels >=
              scrollController.position.maxScrollExtent - 25 &&
          !isLoadingMoreProducts.value &&
          currentProductPage.value < totalProductPage.value) {
        loadMoreRelatedProducts();
      }
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  Future<void> _initializeData() async {
    await loadProduct();
    loadRelatedProducts();
    loadReviews();
    loadStore();
    checkWishlist();
  }

  // ================= PRODUK =================
  Future<void> loadProduct() async {
    try {
      isLoadingProduct.value = true;

      final response = await _itemsService.product(productId.value);

      data.assignAll(response['data']);
      productImages.assignAll(response['data']['gambar']);

      final Map<String, dynamic> variasi = response['data']['variasi'];

      if (variasi.isNotEmpty) {
        productVariations.value = variasi.map(
          (key, value) => MapEntry(key, List<Map<String, dynamic>>.from(value)),
        );
      }
    } catch (e) {
      Get.snackbar('Error', e.toString(), backgroundColor: Colors.red);
    } finally {
      isLoadingProduct.value = false;
    }
  }

  // ================= VARIASI =================
  void selectVariation(String namaVariasi, Map<String, dynamic> opsi) {
    selectedVariation[namaVariasi] = opsi;
    selectedVariation.refresh();
  }

  bool get semuaVariasiDipilih {
    return selectedVariation.length == productVariations.length;
  }

  // ================= HARGA =================
  int get hargaProdukUtama {
    return int.tryParse(data['harga_konsumen']?.toString() ?? '0') ?? 0;
  }

  int get totalHargaVariasi {
    int total = 0;
    for (final v in selectedVariation.values) {
      total += int.tryParse(v['harga']?.toString() ?? '0') ?? 0;
    }
    return total;
  }

  int get totalHargaProduk {
    return (hargaProdukUtama + totalHargaVariasi) * jumlahPesan.value;
  }

  // ================= REVIEWS =================
  Future<void> loadReviews() async {
    try {
      isLoadingReviews.value = true;
      final response = await _itemsService.fetchReview(productId.value);
      if (response['data'] != null) {
        reviews.assignAll(response['data']);
      }
    } finally {
      isLoadingReviews.value = false;
    }
  }

  // ================= TOKO =================
  Future<void> loadStore() async {
    try {
      isLoadingStore.value = true;
      final response = await _storeService.fetchStore(resellerId.value);
      storeData.assignAll(response['data']);
      storeProfilePicture.value = storeData['foto'] ?? '';
    } finally {
      isLoadingStore.value = false;
    }
  }

  // ================= RELATED =================
  Future<void> loadRelatedProducts() async {
    try {
      isLoadingRelatedProducts.value = true;
      currentProductPage.value = 1;

      final response = await _itemsService.categoryProducts(
        data['nama_kategori'],
        page: currentProductPage.value,
      );

      totalProductPage.value = response['total_pages'];
      relatedProducts.assignAll(response['data']);
    } finally {
      isLoadingRelatedProducts.value = false;
    }
  }

  Future<void> loadMoreRelatedProducts() async {
    try {
      isLoadingMoreProducts.value = true;
      currentProductPage.value++;

      final response = await _itemsService.categoryProducts(
        data['nama_kategori'],
        page: currentProductPage.value,
      );

      relatedProducts.addAll(response['data']);
    } finally {
      isLoadingMoreProducts.value = false;
    }
  }

  // ================= WISHLIST =================
  Future<void> addRemoveProductWishlist() async {
    final prefs = await SharedPreferences.getInstance();
    final isLogin = prefs.getBool('login') ?? false;

    if (!isLogin) return;

    final consumerId = prefs.getString('id_user')!;
    final response = await _itemsService.addRemoveProductWishlist(
      productId.value,
      consumerId,
    );

    if (response['status']) {
      isInWishlist.toggle();
    }
  }

  Future<void> checkWishlist() async {
    final prefs = await SharedPreferences.getInstance();
    final isLogin = prefs.getBool('login') ?? false;

    if (!isLogin) return;

    final consumerId = prefs.getString('id_user')!;
    final response = await _itemsService.productWishlistCheck(
      productId.value,
      consumerId,
    );

    isInWishlist.value = response['status'] == true;
  }

  // ================= CART =================
  Future<void> addToCart() async {
    final prefs = await SharedPreferences.getInstance();
    final isLogin = prefs.getBool('login') ?? false;

    if (!isLogin) {
      Get.snackbar('Login', 'Silakan login terlebih dahulu');
      return;
    }

    if (!semuaVariasiDipilih) {
      Get.snackbar(
        'Perhatian',
        'Silakan pilih semua variasi terlebih dahulu',
        backgroundColor: Colors.orange,
      );
      return;
    }

    final idKonsumen = prefs.getString('id_user')!;

    try {
      final response = await _itemsService.addProductToCart(
        idKonsumen,
        productId.value,
        jumlahPesan.value.toString(),
        totalHargaProduk.toString(),
        keteranganOrder: keteranganVariasi,
        satuan: data['satuan'],
      );

      if (response['status'] == true) {
        Get.back();
        Get.snackbar(
          'Berhasil',
          'Berhasil memasukan produk ke keranjang anda',
          backgroundColor: Colors.blue,
        );
      } else {
        Get.snackbar('Gagal', response['message'], backgroundColor: Colors.red);
      }
    } catch (e) {
      Get.snackbar('Error', '$e', backgroundColor: Colors.red);
    }
  }

  // ================= WHATSAPP =================
  Future<void> openWhatsApp() async {
    final message = Uri.encodeComponent(
      'Permisi saya tertarik dengan produk ${data['nama_produk']}',
    );
    final url = Uri.parse(
      'https://wa.me/${storeData['no_telpon']}?text=$message',
    );

    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    }
  }

  String get keteranganVariasi {
    if (selectedVariation.isNotEmpty) {
      return '${selectedVariation.values.map((v) => v['value'].toString().toLowerCase()).join(';')};';
    }
    return '';
  }
}
