import 'package:flutter/material.dart';
import 'package:flutter_api_with_dio/controllers/user_controller.dart';
import 'package:provider/provider.dart';

class UserPage extends StatelessWidget {
  const UserPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => UserController(),
      child: Scaffold(
        appBar: AppBar(title: const Text("Paginated Users")),
        body: Consumer<UserController>(
          builder: (context, controller, _) {
            return ListView.builder(
              controller: controller.scrollController,
              itemCount: controller.users.length + 1,
              itemBuilder: (context, index) {
                if (index < controller.users.length) {
                  final user = controller.users[index];
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(user.avatar),
                    ),
                    title: Text("${user.firstName} ${user.lastName}"),
                    subtitle: Text(user.email),
                  );
                } else if (controller.hasError) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: Column(
                      children: [
                        Text(
                          "Error: ${controller.errorMessage}",
                          style: const TextStyle(color: Colors.red),
                        ),
                        const SizedBox(height: 10),
                        ElevatedButton(
                          onPressed: controller.fetchUsers,
                          child: const Text("Retry"),
                        ),
                      ],
                    ),
                  );
                } else if (controller.isLoading) {
                  return const Padding(
                    padding: EdgeInsets.symmetric(vertical: 20),
                    child: Center(child: CircularProgressIndicator()),
                  );
                } else {
                  return const SizedBox.shrink();
                }
              },
            );
          },
        ),
      ),
    );
  }
}
