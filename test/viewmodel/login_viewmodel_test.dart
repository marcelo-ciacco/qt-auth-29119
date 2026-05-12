import 'package:auth_29119_app/core/ui/ui_event.dart';
import 'package:auth_29119_app/features/auth/data/repository/auth_repository_impl.dart';
import 'package:auth_29119_app/features/auth/data/service/fake_auth_service.dart';
import 'package:auth_29119_app/features/auth/model/user_model.dart';
import 'package:auth_29119_app/features/auth/viewmodel/login_viewmodel.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late FakeAuthService service;
  late AuthRepositoryImpl repository;
  late LoginViewModel viewModel;

  setUp(() {
    service = FakeAuthService();
    repository = AuthRepositoryImpl(service);
    viewModel = LoginViewModel(repository);
  });

  group('LoginViewModel - Testes de Unidade', () {
    test('TC06 — Login válido & TC09 — Navegação para Home', () async {
      //ARRANGE
      repository.signUp(
        UserModel(
          name: "Marcelo",
          email: "marcelo@email.com",
          password: "123456",
        ),
      );

      //ACT
      await viewModel.login(
        email: "marcelo@email.com",
        password: "123456",
      );

      //ASSERT
      expect(
        viewModel.authNavigationEvent,
        AuthNavigationEvent.goToHome,
      );

      expect(
        viewModel.uiMessage?.message,
        isNull,
      );
    });

    test('TC07 — Login com campos vazios', () async {
      //ACT
      await viewModel.login(
        email: "",
        password: "",
      );

      //ASSERT
      expect(
        viewModel.uiMessage?.message,
        'Preencha email e senha.',
      );

      expect(
        viewModel.authNavigationEvent,
        AuthNavigationEvent.none,
      );
    });

    test('TC08 — Login inválido', () async {
      //ARRANGE
      await repository.signUp(
        UserModel(
          name: "Marcelo",
          email: "marcelo@email.com",
          password: "123456",
        ),
      );

      //ACT
      await viewModel.login(
        email: "marcelo@email.com",
        password: "senhaerrada",
      );

      //ASSERT
      expect(
        viewModel.uiMessage?.message,
        "E-mail ou senha invalidos",
      );

      expect(
        viewModel.authNavigationEvent,
        AuthNavigationEvent.none,
      );
    });
  });
}
