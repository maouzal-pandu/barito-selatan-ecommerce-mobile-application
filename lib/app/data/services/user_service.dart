import 'dart:convert';

import 'package:http/http.dart' as http;

class UserService {
  // server address
  final url = 'http://202.157.177.43/umkm_barsel_main/user';

  // local address
  // final url = 'http://192.168.1.2/umkm_barsel/user';

  Future<Map<String, dynamic>> updateProfileUser(
    String id,
    String fullname,
    String address,
    String birthPlace,
    String birthDate,
    String provinceId,
    String cityId,
    String subdistrictId, {
    String? profilePicture,
  }) async {
    try {
      final request = http.MultipartRequest(
        'POST',
        Uri.parse('$url/updateUserProfile'),
      );

      request.fields['id_user'] = id;
      request.fields['fullname'] = fullname;
      request.fields['address'] = address;
      request.fields['birth_place'] = birthPlace;
      request.fields['birth_date'] = birthDate;
      request.fields['id_subdistrict'] = subdistrictId;
      request.fields['id_city'] = cityId;
      request.fields['id_province'] = provinceId;

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
        return {'status': true};
      } else {
        return {'status': false, 'message': decodedJson['message']};
      }
    } catch (e) {
      throw Exception('Error from user services | Error $e');
    }
  }

  Future<Map<String, dynamic>> getUserStore(String idUser) async {
    try {
      final response = await http.post(
        Uri.parse('$url/getUserStore'),
        body: {'id_konsumen': idUser},
      );

      final decodedJson = jsonDecode(response.body);

      if (decodedJson['status'] == true && decodedJson['have_store'] == true) {
        return {
          'status': true,
          'data': decodedJson['data'],
          'have_store': true,
        };
      } else if (decodedJson['status'] == true &&
          decodedJson['have_store'] == false) {
        return {
          'status': true,
          'message': decodedJson['message'],
          'have_store': false,
        };
      } else {
        return {'status': false, 'message': decodedJson['message']};
      }
    } catch (e) {
      throw Exception('Error from user service class | Error : $e');
    }
  }

  Future<Map<String, dynamic>> fetchUserWishlistItems(
    String consumerId, {
    int? page,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$url/fetchUserWishlist?page=$page'),
        body: {'consumer_id': consumerId},
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
        return {'status': false, 'message': decodedJson['message']};
      }
    } catch (e) {
      throw Exception('$e');
    }
  }
}
