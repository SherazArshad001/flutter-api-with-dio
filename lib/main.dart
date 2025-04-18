import 'package:flutter/material.dart';
import 'features/users/view/user_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Dio API',
      theme: ThemeData(primarySwatch: Colors.deepPurple),
      home: const UserPage(),
    );
  }
}
