import 'package:auth_29119_app/features/auth/viewmodel/signup_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../app/routes/app_routes.dart';
import '../../../core/ui/ui_event.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _handleUiEffects(SignupViewModel viewModel) {
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
        case AuthNavigationEvent.goToSignUp:
        case AuthNavigationEvent.none:
          break;

        case AuthNavigationEvent.goToLogin:
          Navigator.pushReplacementNamed(context, AppRoutes.login);
          viewModel.clearNavigation();

        case AuthNavigationEvent.goToHome:
          Navigator.pushReplacementNamed(context, AppRoutes.home);
          viewModel.clearNavigation();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<SignupViewModel>(
      builder: (context, viewModel, child) {
        _handleUiEffects(viewModel);
        return Scaffold(
          appBar: AppBar(
            title: const Text('Cadastro'),
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
                      const Text(
                        'Criar Conta',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      TextField(
                        controller: _nameController,
                        keyboardType: TextInputType.name,
                        decoration: InputDecoration(
                          labelText: 'Nome',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      SizedBox(
                        height: 16,
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
                            : () => viewModel.signUp(
                                name: _nameController.text,
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
                            : const Text("Cadastrar"),
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      TextButton(
                        onPressed: () => viewModel.goToLogin(),
                        child: Text("Voltar para login"),
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
