import 'package:dio/dio.dart';
import 'package:flutter_api_with_dio/core/network/api_client.dart';
import 'package:flutter_api_with_dio/core/network/api_constant.dart';
import 'package:flutter_api_with_dio/features/users/model/user_mode.dart';

class UserApi {
  Future<List<User>> fetchUsers(int page) async {
    try {
      final response = await DioClient.instance.get(
        ApiConstants.getUsers,
        queryParameters: {"page": page},
      );
      final List data = response.data['data'];
      return data.map((userJson) => User.fromJson(userJson)).toList();
    } on DioException catch (e) {
      throw Exception("Failed to load users: ${e.message}");
    }
  }
}
