import 'package:auth_29119_app/app/routes/app_routes.dart';
import 'package:auth_29119_app/core/ui/ui_event.dart';
import 'package:auth_29119_app/features/auth/viewmodel/login_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _handleUiEffects(LoginViewModel viewModel) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;

      final message = viewModel.uiMessage;

      if (message != null) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(message.message)));
        viewModel.clearMessage();
      }

      switch (viewModel.authNavigationEvent) {
        case AuthNavigationEvent.goToLogin:
        case AuthNavigationEvent.none:
          break;

        case AuthNavigationEvent.goToSignUp:
          Navigator.pushNamed(context, AppRoutes.signup);
          viewModel.clearNavigation();

        case AuthNavigationEvent.goToHome:
          Navigator.pushReplacementNamed(context, AppRoutes.home);
          viewModel.clearNavigation();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<LoginViewModel>(
      builder: (context, viewModel, child) {
        _handleUiEffects(viewModel);
        return Scaffold(
          appBar: AppBar(
            title: const Text('Login'),
          ),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Center(
                child: ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: 420),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 24,
                      ),
                      TextField(
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          labelText: 'E-mail',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      TextField(
                        controller: _passwordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          labelText: 'Senha',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      SizedBox(
                        height: 24,
                      ),
                      ElevatedButton(
                        onPressed: viewModel.isLoading
                            ? null
                            : () => viewModel.login(
                                email: _emailController.text,
                                password: _passwordController.text,
                              ),
                        child: viewModel.isLoading
                            ? const SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                ),
                              )
                            : const Text("Entrar"),
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      TextButton(
                        onPressed: () => viewModel.goToSignup(),
                        child: Text("Primeiro acesso"),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
