import 'dart:convert';

import 'package:http/http.dart' as http;

class AuthService {
  // server address
  // final url = 'http://202.157.177.43/umkm_barsel_main/mobauth';

  // local address
  final url = 'http://192.168.1.2/umkm_barsel/mobauth';

  Future<Map<String, dynamic>> login(String email, String pass) async {
    try {
      final response = await http.post(
        Uri.parse('$url/login'),
        body: {'email': email, 'password': pass},
      );

      final json = jsonDecode(response.body);

      if (json['status'] == true) {
        return {'status': true, 'data': json['data']};
      } else if (json['status'] == false) {
        return {'status': false, 'message': json['message']};
      } else {
        return {'status': false};
      }
    } catch (e) {
      throw Exception('Error from service class | Error : $e');
    }
  }

  Future<Map<String, dynamic>> forgetPass(String email) async {
    try {
      final response = await http.post(
        Uri.parse('$url/forgetPassword'),
        body: {'email': email},
      );

      final decoded = jsonDecode(response.body);

      if (decoded['status'] == true) {
        return {'status': true, 'message': decoded['message']};
      } else if (decoded['status'] == false) {
        return {'status': false, 'message': decoded['message']};
      } else {
        return {'status': false};
      }
    } catch (e) {
      throw Exception('Error from services class | Error : $e');
    }
  }

  Future<Map<String, dynamic>> register(
    String email,
    String username,
    String phoneNumber,
    String pass,
    String sex,
  ) async {
    try {
      final response = await http.post(
        Uri.parse('$url/register'),
        body: {
          'email': email,
          'username': username,
          'no_hp': phoneNumber,
          'password': pass,
          'jenis_kelamin': sex,
        },
      );

      final json = jsonDecode(response.body);

      if (json['status'] == true) {
        return {'status': true};
      } else if (json['status'] == false) {
        return {'status': false, 'message': json['message']};
      } else {
        return {'status': false};
      }
    } catch (e) {
      throw Exception('Error from services class | Error : $e');
    }
  }

  Future<Map<String, dynamic>> verifyOtp(String email, String otp) async {
    try {
      final response = await http.post(
        Uri.parse('$url/verify_otp'),
        body: {'email': email, 'otp': otp},
      );

      final jsonDecoded = jsonDecode(response.body);

      if (jsonDecoded['status'] == true) {
        return {'status': true, 'message': jsonDecoded['message']};
      } else {
        return {'status': false, 'message': jsonDecoded['message']};
      }
    } catch (e) {
      throw Exception('Error from auth service class | error : $e');
    }
  }
}
