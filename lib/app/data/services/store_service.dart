import 'dart:convert';

import 'package:http/http.dart' as http;

class StoreService {
  // server address
  // final url = 'http://202.157.177.43/umkm_barsel_main/store';

  // local address
  final url = 'http://192.168.1.3/umkm_barsel/store';

  Future<Map<String, dynamic>> createStore(
    String userId,
    String storeName,
    String provinceId,
    String cityId,
    String subdistrictId,
    String storeAddress,
    String storePhoneNumber,
    String bankName,
    String bankNumber,
    String bankOwner,
    String storeAbout, {
    String? profilePicture,
  }) async {
    try {
      final request = http.MultipartRequest(
        'POST',
        Uri.parse('$url/createStore'),
      );

      request.fields['id_user'] = userId;
      request.fields['store_name'] = storeName;
      request.fields['province_id'] = provinceId;
      request.fields['city_id'] = cityId;
      request.fields['subdistrict_id'] = subdistrictId;
      request.fields['address'] = storeAddress;
      request.fields['phone_number'] = storePhoneNumber;
      request.fields['bank_name'] = bankName;
      request.fields['bank_number'] = bankNumber;
      request.fields['bank_owner'] = bankOwner;
      request.fields['store_about'] = storeAbout;

      if (profilePicture != null && profilePicture.isNotEmpty) {
        request.files.add(
          await http.MultipartFile.fromPath('image', profilePicture),
        );
      }

      final response = await request.send();
      final responseBody = await response.stream.bytesToString();
      final decodedJson = jsonDecode(responseBody);

      if (decodedJson['status'] == true) {
        return {
          'status': true,
          'message': decodedJson['message'],
          'id_reseller': decodedJson['id_reseller'],
        };
      } else {
        return {'status': true, 'message': decodedJson['message']};
      }
    } catch (e) {
      throw Exception('Error from store service class | Error : $e');
    }
  }

  Future<Map<String, dynamic>> updateStore(
    String resellerId,
    String storeName,
    String provinceId,
    String cityId,
    String subdistrictId,
    String storeAddress,
    String storePhoneNumber,
    String bankName,
    String bankNumber,
    String bankOwner,
    String storeAbout, {
    String? profilePicture,
  }) async {
    try {
      final request = http.MultipartRequest(
        'POST',
        Uri.parse('$url/updateStore'),
      );

      request.fields['id_reseller'] = resellerId;
      request.fields['store_name'] = storeName;
      request.fields['province_id'] = provinceId;
      request.fields['city_id'] = cityId;
      request.fields['subdistrict_id'] = subdistrictId;
      request.fields['address'] = storeAddress;
      request.fields['phone_number'] = storePhoneNumber;
      request.fields['bank_name'] = bankName;
      request.fields['bank_number'] = bankNumber;
      request.fields['bank_owner'] = bankOwner;
      request.fields['store_about'] = storeAbout;

      if (profilePicture != null &&
          profilePicture.isNotEmpty &&
          !profilePicture.contains('/asset/foto_user/')) {
        request.files.add(
          await http.MultipartFile.fromPath('image', profilePicture),
        );
      }

      final response = await request.send();
      final responseBody = await response.stream.bytesToString();
      final decodedJson = jsonDecode(responseBody);

      if (decodedJson['status'] == true) {
        return {'status': true, 'message': decodedJson['message']};
      } else {
        return {'status': true, 'message': decodedJson['message']};
      }
    } catch (e) {
      throw Exception('Error from store service class | Error : $e');
    }
  }

  Future<Map<String, dynamic>> fetchStore(String resellerId) async {
    try {
      final response = await http.get(Uri.parse('$url/store?s=$resellerId'));

      final decodedJson = jsonDecode(response.body);

      if (decodedJson['status'] == true) {
        return {'status': true, 'data': decodedJson['data']};
      } else {
        return {'status': false, 'message': decodedJson['message']};
      }
    } catch (e) {
      throw Exception('Error from store service class | Error : $e');
    }
  }
}
