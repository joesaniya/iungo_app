import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:dio/io.dart' show IOHttpClientAdapter;
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

enum RequestType { get, post, put, delete }

class DioClient {
  final Dio _dio = Dio();

  DioClient() {
    _dio
      ..options.connectTimeout = const Duration(seconds: 20)
      ..options.receiveTimeout = const Duration(seconds: 90)
      ..options.responseType = ResponseType.json
      ..options.contentType = 'application/json'
      ..options.validateStatus = (status) {
        return status != null && status < 500;
      };

    // Critical: Configure HTTP client to bypass SSL certificate verification
    _dio.httpClientAdapter = IOHttpClientAdapter(
      createHttpClient: () {
        final client = HttpClient();
        client.badCertificateCallback =
            (X509Certificate cert, String host, int port) {
              log('Bypassing SSL certificate check for $host:$port');
              return true; // Allow all certificates
            };
        return client;
      },
    );

    if (kDebugMode) {
      _dio.interceptors.add(
        PrettyDioLogger(
          requestHeader: true,
          requestBody: true,
          responseBody: true,
          responseHeader: true,
          error: true,
          compact: true,
          maxWidth: 90,
        ),
      );
    }
  }

  Future<Response?> performCall({
    required RequestType requestType,
    required String url,
    String basicAuth = '',
    Map<String, dynamic>? queryParameters,
    dynamic data,
  }) async {
    log('URL: $url');
    log('Auth: $basicAuth');
    log('Data: $data');

    queryParameters = queryParameters ?? {};
    data = data ?? {};

    try {
      Response response;

      final options = Options(
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          if (basicAuth.isNotEmpty) 'authorization': basicAuth,
        },
      );

      switch (requestType) {
        case RequestType.get:
          response = await _dio.get(
            url,
            queryParameters: queryParameters,
            options: options,
          );
          break;

        case RequestType.post:
          response = await _dio.post(
            url,
            queryParameters: queryParameters,
            data: data,
            options: options,
          );
          break;

        case RequestType.put:
          response = await _dio.put(
            url,
            queryParameters: queryParameters,
            data: data,
            options: options,
          );
          break;

        case RequestType.delete:
          response = await _dio.delete(
            url,
            queryParameters: queryParameters,
            options: options,
          );
          break;
      }

      log('Response Status Code: ${response.statusCode}');
      log('Response Data: ${response.data}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        return response;
      } else {
        log('Error: Status code ${response.statusCode}');
        return response;
      }
    } on DioException catch (e) {
      log('DioException Type: ${e.type}');
      log('DioException Message: ${e.message}');
      log('DioException Error: ${e.error}');
      log('DioException Response: ${e.response}');

      if (e.response != null) {
        return e.response;
      }

      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout) {
        log('Timeout error');
      } else if (e.type == DioExceptionType.unknown) {
        if (e.error is HandshakeException) {
          log('SSL Handshake error - Certificate issue');
        } else if (e.error is SocketException) {
          log('Socket error - Network issue');
        } else {
          log('Unknown network error: ${e.error}');
        }
      }

      return null;
    } on PlatformException catch (err) {
      log("Platform exception: $err");
      return null;
    } catch (error) {
      log('General error: $error');
      return null;
    }
  }
}
