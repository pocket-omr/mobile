import 'package:flutter/material.dart';
import 'features/auth/screens/splash_screen.dart';
import 'core/theme/app_colors.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'QuiZor UI',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: AppColors.primaryBlue,
      ),
      home: const SplashScreen(),
    );
  }
}
