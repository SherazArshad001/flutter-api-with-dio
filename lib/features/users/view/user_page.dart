import 'package:flutter/material.dart';
import 'package:flutter_api_with_dio/features/users/model/user_mode.dart';
import '../data/user_api.dart';

class UserPage extends StatefulWidget {
  const UserPage({super.key});

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  final UserApi userApi = UserApi();
  final ScrollController _scrollController = ScrollController();

  List<User> users = [];
  bool isLoading = false;
  bool hasMore = true;
  int currentPage = 1;

  bool hasError = false;
  String errorMessage = "";

  @override
  void initState() {
    super.initState();
    fetchUsers();
    _scrollController.addListener(_scrollListener);
  }

  void _scrollListener() {
    if (_scrollController.position.pixels >=
            _scrollController.position.maxScrollExtent - 200 &&
        !isLoading &&
        hasMore) {
      fetchUsers();
    }
  }

  Future<void> fetchUsers() async {
    setState(() {
      isLoading = true;
      hasError = false;
    });

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
      errorMessage = e.toString();
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Paginated Users")),
      body: ListView.builder(
        controller: _scrollController,
        itemCount: users.length + 1,
        itemBuilder: (context, index) {
          if (index < users.length) {
            final user = users[index];
            return ListTile(
              leading: CircleAvatar(backgroundImage: NetworkImage(user.avatar)),
              title: Text("${user.firstName} ${user.lastName}"),
              subtitle: Text(user.email),
            );
          } else if (hasError) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Column(
                children: [
                  Text(
                    "Error: $errorMessage",
                    style: const TextStyle(color: Colors.red),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: fetchUsers,
                    child: const Text("Retry"),
                  ),
                ],
              ),
            );
          } else if (isLoading) {
            return const Padding(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: Center(child: CircularProgressIndicator()),
            );
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}
