import 'package:dio/dio.dart';
import 'package:flutter_api_with_dio/core/network/api_constant.dart';

class DioClient {
  static final Dio _dio = Dio(BaseOptions(
    baseUrl: ApiConstants.baseUrl,
    connectTimeout: const Duration(seconds: 5),
    receiveTimeout: const Duration(seconds: 5),
    headers: {'Content-Type': 'application/json'},
  ))
    ..interceptors.add(LogInterceptor(responseBody: true));

  static Dio get instance => _dio;
}
