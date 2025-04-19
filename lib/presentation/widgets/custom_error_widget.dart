import 'package:flutter/material.dart';
import 'package:flutter_api_with_dio/core/constants/app_constant.dart';
import 'package:flutter_api_with_dio/core/theme/app_text_styles.dart';

class CustomErrorWidget extends StatelessWidget {
  final String errorMessage;
  final VoidCallback onRetry;

  const CustomErrorWidget({
    super.key,
    required this.errorMessage,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Column(
        children: [
          Text(errorMessage, style: AppTextStyles.errorText),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: onRetry,
            child: const Text(AppConstants.errorPrefix),
          ),
        ],
      ),
    );
  }
}
