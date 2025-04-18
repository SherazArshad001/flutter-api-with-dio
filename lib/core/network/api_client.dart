import 'package:dio/dio.dart';
import 'package:flutter_api_with_dio/core/network/dio_interceptor.dart';

class DioClient {
  static final Dio _dio = Dio()
    ..interceptors.add(AppInterceptors());

  static Dio get instance => _dio;
}
