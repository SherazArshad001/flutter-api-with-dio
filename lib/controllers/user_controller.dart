import 'package:flutter/material.dart';
import 'package:flutter_api_with_dio/core/exception/network_exception.dart';
import '../data/models/user_model.dart';
import '../data/remote/user_api.dart';

class UserController extends ChangeNotifier {
  final UserApi userApi = UserApi();

  List<User> users = [];
  bool isLoading = false;
  bool hasMore = true;
  int currentPage = 1;

  bool hasError = false;
  String errorMessage = "";

  final ScrollController scrollController = ScrollController();

  UserController() {
    fetchUsers();
    scrollController.addListener(_scrollListener);
  }

  void _scrollListener() {
    if (scrollController.position.pixels >=
            scrollController.position.maxScrollExtent - 200 &&
        !isLoading &&
        hasMore) {
      fetchUsers();
    }
  }

  Future<void> fetchUsers() async {
    isLoading = true;
    hasError = false;
    notifyListeners();

    try {
      final newUsers = await userApi.fetchUsers(currentPage);
      if (newUsers.isEmpty) {
        hasMore = false;
      } else {
        currentPage++;
        users.addAll(newUsers);
      }
    } catch (e) {
      hasError = true;
      errorMessage = e is NetworkException ? e.message : "Unknown error";
    }

    isLoading = false;
    notifyListeners();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }
}
