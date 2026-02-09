import 'dart:developer';

import 'package:iungo_application/Data-Provider/dio-client.dart';

class AuthApiService {
  final DioClient _dioClient = DioClient();
  static const String baseUrl = 'https://iungo.citgroupltd.com/API';

  Future<Map<String, dynamic>?> login({
    required String username,
    required String password,
    required String deviceId,
    required String deviceName,
    required String deviceModal,
  }) async {
    try {
      log('Starting login request...');

      final response = await _dioClient.performCall(
        requestType: RequestType.post,
        url: '$baseUrl/auth.php',
        data: {
          'username': username,
          'password': password,
          'device_id': deviceId,
          'device_name': deviceName,
          'device_modal': deviceModal,
        },
      );

      if (response == null) {
        log('Response is null - network error');
        return null;
      }

      log('Response received: ${response.data}');
      log('Response status code: ${response.statusCode}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        if (response.data is Map<String, dynamic>) {
          return response.data as Map<String, dynamic>;
        }
      }

      return null;
    } catch (e) {
      log('Login error: $e');
      return null;
    }
  }
}

/*class AuthApiService {
  final DioClient _dioClient = DioClient();
  static const String baseUrl = 'https://iungo.citgroupltd.com/API';

  Future<Map<String, dynamic>?> login({
    required String username,
    required String password,
    required String deviceId,
    required String deviceName,
    required String deviceModal,
  }) async {
    try {
      final response = await _dioClient.performCall(
        requestType: RequestType.post,
        url: '$baseUrl/auth.php',
        data: {
          'username': username,
          'password': password,
          'device_id': deviceId,
          'device_name': deviceName,
          'device_modal': deviceModal,
        },
      );

      if (response != null && response.statusCode == 200) {
        log('Login successful: ${response.data}');
        return response.data;
      }
      return null;
    } catch (e) {
      log('Login error: $e');
      return null;
    }
  }
}*/
