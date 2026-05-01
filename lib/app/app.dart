import 'package:auth_29119_app/features/auth/data/repository/auth_repository.dart';
import 'package:auth_29119_app/features/auth/data/repository/auth_repository_impl.dart';
import 'package:auth_29119_app/features/auth/data/service/auth_service.dart';
import 'package:auth_29119_app/features/auth/viewmodel/login_viewmodel.dart';
import 'package:auth_29119_app/features/auth/viewmodel/signup_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../features/auth/data/service/fake_auth_service.dart';
import '../features/home/view/home_page.dart';
import '../features/auth/view/login_page.dart';
import '../features/auth/view/signup_page.dart';
import 'routes/app_routes.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AuthService>(
          create: (_) => FakeAuthService(),
        ),
        Provider<AuthRepository>(
          create: (context) => AuthRepositoryImpl(
            context.read<AuthService>(),
          ),
        ),
        ChangeNotifierProvider<LoginViewModel>(
          create: (context) => LoginViewModel(context.read<AuthRepository>()),
        ),
        ChangeNotifierProvider<SignupViewModel>(
          create: (context) => SignupViewModel(context.read<AuthRepository>()),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Auth 29119 App',
        initialRoute: AppRoutes.login,
        routes: {
          AppRoutes.login: (_) => const LoginPage(),
          AppRoutes.signup: (_) => const SignUpPage(),
          AppRoutes.home: (_) => const HomePage(),
        },
      ),
    );
  }
}
