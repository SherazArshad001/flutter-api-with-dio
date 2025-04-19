import 'package:dio/dio.dart';
import 'package:flutter_api_with_dio/core/exception/network_exception.dart';
import '../models/user_model.dart';

class UserApi {
  final Dio _dio = Dio();

  Future<List<User>> fetchUsers(int page) async {
    try {
      final response = await _dio.get('https://reqres.in/api/users?page=$page');
      final List data = response.data['data'];
      return data.map((e) => User.fromJson(e)).toList();
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout) {
        throw NetworkException("Connection timeout");
      } else if (e.type == DioExceptionType.receiveTimeout) {
        throw NetworkException("Receive timeout");
      } else if (e.type == DioExceptionType.badResponse) {
        throw NetworkException("Server error: ${e.response?.statusCode}");
      } else {
        throw NetworkException("Something went wrong: ${e.message}");
      }
    } catch (e) {
      throw NetworkException("Unexpected error: $e");
    }
  }
}
