import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

class ItemsService {
  // server address
  // final url = "http://202.157.177.43/umkm_barsel_main/product";

  // local address
  final url = 'http://192.168.1.81/umkm_barsel/product';

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
  }) async {
    try {
      final encodedCategory = Uri.encodeComponent(category);

      final response = await http.get(
        Uri.parse(
          '$url/searchBasedCategory?category=$encodedCategory&page=$page&limit=8',
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
}
