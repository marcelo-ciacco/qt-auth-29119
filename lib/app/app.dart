import 'package:flutter/material.dart';

import '../features/home/view/home_page.dart';
import '../features/auth/view/login_page.dart';
import '../features/auth/view/signup_page.dart';
import 'routes/app_routes.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Auth 29119 App',
      initialRoute: AppRoutes.login,
      routes: {
        AppRoutes.login: (_) => const LoginPage(),
        AppRoutes.signup: (_) => const SignUpPage(),
        AppRoutes.home: (_) => const HomePage(),
      },
    );
  }
}
