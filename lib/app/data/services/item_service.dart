import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

class ItemsService {
  final url = 'http://192.168.1.2/umkm_barsel/product';

  Future<List<Map<String, dynamic>>> category() async {
    try {
      final response = await http.get(Uri.parse("$url/category"));

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);

        return data.map((e) => Map<String, dynamic>.from(e)).toList();
      } else {
        throw Exception(
          "Failed to load categories. Status code : ${response.statusCode}",
        );
      }
    } catch (e) {
      throw Exception("Error category : $e");
    }
  }

  Future<Map<String, dynamic>> fetchProducts({int page = 1}) async {
    try {
      final response = await http
          .get(Uri.parse("$url/products?page=$page"))
          .timeout(Duration(seconds: 10));

      final data = jsonDecode(response.body);

      if (data['status'] == true) {
        return {
          "status": true,
          "page": data["page"],
          "limit": data["limit"],
          "total_data": data["total_data"],
          "total_page": data["total_pages"],
          "data": List<Map<String, dynamic>>.from(data["data"]),
        };
      } else {
        return {"status": false, 'message': 'Failed to fetch products.'};
      }
    } on TimeoutException {
      return {'status': 'false'};
    } catch (e) {
      throw Exception("Error products : $e");
    }
  }

  Future<Map<String, dynamic>> categoryProducts(
    String category, {
    int page = 1,
    String? sort,
  }) async {
    try {
      final encodedCategory = Uri.encodeComponent(category);

      final response = await http.get(
        Uri.parse(
          '$url/searchBasedCategory?category=$encodedCategory&page=$page&limit=8&sort=$sort',
        ),
      );

      final data = jsonDecode(response.body);

      if (data['status'] == false) {
        return ({'status': false, 'message': data['message']});
      }

      final List<Map<String, dynamic>> products =
          List<Map<String, dynamic>>.from(data['data']);

      return {
        'status': true,
        'total': data['total'],
        'total_pages': data['total_pages'],
        'data': products,
      };
    } catch (e) {
      throw Exception('Something is wrong :( | error : $e)');
    }
  }

  Future<Map<String, dynamic>> product(String productId) async {
    try {
      final response = await http.get(
        Uri.parse('$url/product?product_id=$productId'),
      );

      final data = jsonDecode(response.body);

      if (data['status'] == true) {
        return {'status': true, 'data': data['data']};
      }

      return {'status': false};
    } catch (e) {
      throw Exception('Something wrong when load product :( | error : $e)');
    }
  }

  Future<Map<String, dynamic>> fetchReview(String productId) async {
    try {
      final response = await http.get(
        Uri.parse('$url/fetchReviews?id=$productId'),
      );

      final data = jsonDecode(response.body);

      if (data['status'] == true) {
        return {
          'status': true,
          'data': List<Map<String, dynamic>>.from(data['data']),
        };
      }

      return {'status': false};
    } catch (e) {
      throw Exception('Failed to fetch reviews : $e');
    }
  }

  Future<Map<String, dynamic>> addRemoveProductWishlist(
    String productId,
    String consumerId,
  ) async {
    try {
      final response = await http.post(
        Uri.parse('$url/addRemoveWishlist'),
        body: {'product_id': productId, 'consumer_id': consumerId},
      );

      final decodedJson = jsonDecode(response.body);

      if (decodedJson['status'] == true) {
        return {'status': true, 'message': decodedJson['message']};
      } else {
        return {'status': false, 'message': decodedJson['message']};
      }
    } catch (e) {
      throw Exception('Error from ItemService class | error : $e');
    }
  }

  Future<Map<String, dynamic>> productWishlistCheck(
    String productId,
    String consumerId,
  ) async {
    try {
      final response = await http.post(
        Uri.parse('$url/productWishlistCheck'),
        body: {'consumer_id': consumerId, 'product_id': productId},
      );

      final decodedJson = jsonDecode(response.body);

      if (decodedJson['status'] == true) {
        return {'status': true};
      } else {
        return {'status': false};
      }
    } catch (e) {
      throw Exception('Error from ItemService class | error : $e');
    }
  }

  Future<Map<String, dynamic>> storeProduct(
    String resellerId, {
    int? page,
  }) async {
    try {
      final response = await http.get(
        Uri.parse('$url/storeProducts?i=$resellerId&page=$page'),
      );

      final decodedJson = jsonDecode(response.body);

      if (decodedJson['status'] == true) {
        return {
          'status': true,
          'message': decodedJson['message'],
          'data': decodedJson['data'],
          'total_pages': decodedJson['total_pages'],
        };
      } else {
        return {'status': false, 'message': decodedJson['message']};
      }
    } catch (e) {
      throw Exception('Error from item_service class | Error : $e');
    }
  }

  // fetch all categorys product of a store
  Future<Map<String, dynamic>> storeProductCategory(String resellerId) async {
    try {
      final response = await http.get(
        Uri.parse('$url/productCategoryStore?reseller_id=$resellerId'),
      );

      final decodedJson = jsonDecode(response.body);

      if (decodedJson['status'] == true) {
        return {
          'status': true,
          'message': decodedJson['messege'],
          'data': decodedJson['data'],
        };
      } else {
        return {'status': false};
      }
    } catch (e) {
      throw Exception('Error from Store Service class | Error : $e');
    }
  }

  // fetch specific products from a store based category
  Future<Map<String, dynamic>> storeProductsCategory(
    String resellerId,
    String categoryId, {
    String? page,
  }) async {
    try {
      final response = await http.get(
        Uri.parse(
          '$url/productsCategoryStore?reseller_id=$resellerId&category_id=$categoryId&page=$page',
        ),
      );

      final decodedJson = jsonDecode(response.body);

      if (decodedJson['status'] == true) {
        return {
          'status': true,
          'message': decodedJson['message'],
          'total_pages': decodedJson['total_pages'],
          'data': decodedJson['data'],
        };
      } else {
        return {'status': false};
      }
    } catch (e) {
      throw Exception('Error from item service class | Error : $e');
    }
  }

  Future<Map<String, dynamic>> uploadProduct({
    required String categoryId,
    required String productName,
    required String weight,
    required String minOrder,
    required String price,
    required String stock,
    required String sku,
    required String description,
    required String estimation,
    required String isPreorder,
    required String variations,
    required List images,
    required String resellerId,
    required String productType,
    required String productUnit,
  }) async {
    try {
      final req = http.MultipartRequest("POST", Uri.parse('$url/addProduct'));

      req.fields["category_id"] = categoryId;
      req.fields["product_name"] = productName;
      req.fields["product_weight"] = weight;
      req.fields["product_min_order"] = minOrder;
      req.fields["product_price"] = price;
      req.fields["product_stock"] = stock;
      req.fields["product_sku"] = sku;
      req.fields["product_description"] = description;
      req.fields["product_pre_order_estimation"] = estimation;
      req.fields["product_type"] = productType;
      req.fields["reseller_id"] = resellerId;
      req.fields["variations"] = variations;
      req.fields["product_unit"] = productUnit;

      for (int i = 0; i < images.length; i++) {
        req.files.add(
          await http.MultipartFile.fromPath("image${i + 1}", images[i]),
        );
      }

      final res = await req.send();
      final responseBody = await res.stream.bytesToString();
      final decodedJson = jsonDecode(responseBody);

      if (decodedJson['status'] == true) {
        return {'status': true, 'message': decodedJson['message']};
      } else {
        return {'status': false, 'message': decodedJson['message']};
      }
    } catch (e) {
      throw Exception('Error : $e');
    }
  }

  // Search product use keyword
  Future<Map<String, dynamic>> searchProducts({
    String? keyword,
    int page = 1,
    String? sort,
    int? categoryId,
  }) async {
    try {
      final response = await http.get(
        Uri.parse(
          '$url/searchProducts?q=$keyword&page=$page&c_id=$categoryId&sort=$sort',
        ),
      );

      final decodedJson = jsonDecode(response.body);

      if (decodedJson['status'] == true) {
        return {
          'status': true,
          'data': decodedJson['data'],
          'total_pages': decodedJson['total_pages'],
        };
      } else {
        return {'status': false};
      }
    } catch (e) {
      throw Exception('Error : $e');
    }
  }

  Future<Map<String, dynamic>> deleteProduct(String idProduct) async {
    try {
      final response = await http.post(
        Uri.parse('$url/deleteProduct'),
        body: {'id_product': idProduct},
      );

      final decodedJson = jsonDecode(response.body);

      if (decodedJson['status'] == true) {
        return {'status': true, 'message': decodedJson['message']};
      } else {
        return {'status': false, 'message': decodedJson['message']};
      }
    } catch (e) {
      throw Exception('Error from ItemService class | Error : $e');
    }
  }

  Future<Map<String, dynamic>> fetchSelectedStoreProduct(
    String idProduk,
  ) async {
    try {
      final response = await http.get(
        Uri.parse('$url/storeProduct?id_produk=$idProduk'),
      );

      final decodedJson = jsonDecode(response.body);

      if (decodedJson['status'] == true) {
        return {'status': true, 'data': decodedJson['data']};
      } else {
        return {'status': false, 'message': decodedJson['message']};
      }
    } catch (e) {
      throw Exception('Error from ItemService class | Error : $e');
    }
  }

  Future<Map<String, dynamic>> deleteImageProduct(
    String idProduk,
    String filename,
  ) async {
    try {
      final response = await http.post(
        Uri.parse('$url/deleteProductImage'),
        body: {'id_produk': idProduk, 'filename': filename},
      );

      final decodedJson = jsonDecode(response.body);

      if (decodedJson['status'] == true) {
        return {'status': true};
      } else {
        return {'status': false};
      }
    } catch (e) {
      throw Exception('Error from ItemService class | Error : $e');
    }
  }

  Future<Map<String, dynamic>> deleteProductVariation(String idVariasi) async {
    try {
      final response = await http.post(
        Uri.parse('$url/deleteProductVariation'),
        body: {'id_variasi': idVariasi},
      );

      final decodedJson = jsonDecode(response.body);

      if (decodedJson['status'] == true) {
        return {'status': true};
      } else {
        return {'status': false, 'message': decodedJson['message']};
      }
    } catch (e) {
      throw Exception('Error from ItemService class | Error : $e');
    }
  }

  Future<Map<String, dynamic>> editStoreProduct({
    required String idProduk,
    required String productName,
    required String productPrice,
    required String productWeight,
    required String productMinOrder,
    required String productSku,
    required String productDescription,
    required String productUnit,
    required String productType,
    required String idKategoriProduk,
    String? productPreOrderEstimation,
    required String variationsJson,
    required List<String> imagePaths,
  }) async {
    try {
      final uri = Uri.parse('$url/editProduct');
      final request = http.MultipartRequest('POST', uri);

      // ================= REQUIRED FIELDS =================
      request.fields['id_product'] = idProduk;
      request.fields['product_name'] = productName;
      request.fields['product_price'] = productPrice;
      request.fields['product_weight'] = productWeight;
      request.fields['product_min_order'] = productMinOrder;
      request.fields['product_sku'] = productSku;
      request.fields['product_description'] = productDescription;
      request.fields['product_unit'] = productUnit;
      request.fields['product_type'] = productType;
      request.fields['id_kategori_produk'] = idKategoriProduk;

      // ================= OPTIONAL =================
      if (productPreOrderEstimation != null &&
          productPreOrderEstimation.isNotEmpty) {
        request.fields['product_pre_order_estimation'] =
            productPreOrderEstimation;
      }

      // ================= VARIATIONS (JSON STRING) =================
      request.fields['variations'] = variationsJson;

      // ================= IMAGES =================
      for (int i = 0; i < imagePaths.length; i++) {
        final path = imagePaths[i];

        // ❌ SKIP IMAGE LAMA
        if (path.startsWith('http') || path.contains('/asset/foto_produk/')) {
          continue;
        }

        request.files.add(
          await http.MultipartFile.fromPath('image${i + 1}', path),
        );
      }

      // ================= SEND =================
      final response = await request.send();
      final responseBody = await response.stream.bytesToString();
      final decoded = jsonDecode(responseBody);

      return decoded;
    } catch (e) {
      throw Exception('Edit product failed: $e');
    }
  }

  // Read or fetch cart products of a user
  Future<Map<String, dynamic>> fetchCartProducts(String idKonsumen) async {
    try {
      final response = await http.post(
        Uri.parse('$url/fetchUserCartProducts'),
        body: {'id_konsumen': idKonsumen},
      );

      final decodedJson = jsonDecode(response.body);

      return decodedJson;
    } catch (e) {
      throw Exception('error : $e');
    }
  }

  Future<Map<String, dynamic>> deleteCartProduct(
    String idPenjualanDetail,
  ) async {
    try {
      final response = await http.post(
        Uri.parse('$url/deleteProductCart'),
        body: {'id_penjualan_detail': idPenjualanDetail},
      );

      final decodedJson = jsonDecode(response.body);

      return decodedJson;
    } catch (e) {
      throw Exception('Error : $e');
    }
  }

  Future<Map<String, dynamic>> addProductToCart(
    String idKonsumen,
    String idProduk,
    String jumlah,
    String hargaJual, {
    String? keteranganOrder,
    String? satuan,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$url/addToCart'),
        body: {
          'id_produk': idProduk,
          'id_konsumen': idKonsumen,
          'satuan': satuan,
          'keterangan_order': keteranganOrder,
          'jumlah': jumlah,
          'harga_jual': hargaJual,
        },
      );

      final json = jsonDecode(response.body);

      return json;
    } catch (e) {
      throw Exception('error : $e');
    }
  }
}
