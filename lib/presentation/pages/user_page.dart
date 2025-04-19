import 'package:flutter/material.dart';
import 'package:flutter_api_with_dio/controllers/user_controller.dart';
import 'package:flutter_api_with_dio/core/constants/app_constant.dart';
import 'package:flutter_api_with_dio/core/theme/app_text_styles.dart';
import 'package:flutter_api_with_dio/presentation/widgets/custom_error_widget.dart';
import 'package:provider/provider.dart';

class UserPage extends StatelessWidget {
  const UserPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => UserController(),
      child: Scaffold(
        appBar: AppBar(title: const Text(AppConstants.appBarTitle)),
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
                    title: Text(
                      "${user.firstName} ${user.lastName}",
                      style: AppTextStyles.userName,
                    ),
                    subtitle: Text(user.email, style: AppTextStyles.userEmail),
                  );
                } else if (controller.hasError) {
                  return CustomErrorWidget(
                    errorMessage:
                        "${AppConstants.errorPrefix}${controller.errorMessage}",
                    onRetry: controller.fetchUsers,
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
