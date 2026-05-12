import 'package:auth_29119_app/core/ui/ui_event.dart';
import 'package:auth_29119_app/features/auth/data/repository/auth_repository_impl.dart';
import 'package:auth_29119_app/features/auth/data/service/fake_auth_service.dart';
import 'package:auth_29119_app/features/auth/viewmodel/signup_viewmodel.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late FakeAuthService service;
  late AuthRepositoryImpl repository;
  late SignupViewModel viewModel;

  setUp(() {
    service = FakeAuthService();
    repository = AuthRepositoryImpl(service);
    viewModel = SignupViewModel(repository);
  });

  group('SignupViewModel - Testes de unidade', () {
    test('TC01 — Cadastro com dados válidos', () async {
      //ACT
      await viewModel.signUp(
        name: "Marcelo",
        email: "marcelo@email.com",
        password: "123456",
      );

      //ASSERT
      expect(
        viewModel.uiMessage?.message,
        'Cadastro Realizado com sucesso',
      );

      expect(
        viewModel.authNavigationEvent,
        AuthNavigationEvent.goToLogin,
      );
    });

    test('TC02 — Cadastro com campos vazios', () async {
      //ACT
      await viewModel.signUp(
        name: "",
        email: "",
        password: "",
      );

      //ASSERT
      expect(
        viewModel.uiMessage?.message,
        'Preencha todos os campos.',
      );

      expect(
        viewModel.authNavigationEvent,
        AuthNavigationEvent.none,
      );
    });

    test('TC03 — Cadastro com e-mail inválido', () async {
      //ACT
      await viewModel.signUp(
        name: "Marcelo",
        email: "marceloemail.com",
        password: "123456",
      );

      //ASSERT
      expect(
        viewModel.uiMessage?.message,
        'Informe um email valido',
      );

      expect(
        viewModel.authNavigationEvent,
        AuthNavigationEvent.none,
      );
    });

    test('TC04 — Cadastro duplicado', () async {
      //ARRANGE
      await viewModel.signUp(
        name: "Marcelo",
        email: "marcelo@email.com",
        password: "123456",
      );

      viewModel.clearMessage();
      viewModel.clearNavigation();

      //ACT
      await viewModel.signUp(
        name: "Ciacco",
        email: "marcelo@email.com",
        password: "123457",
      );

      //ASSERT
      expect(
        viewModel.uiMessage?.message,
        'E-mail já cadastrado',
      );

      expect(
        viewModel.authNavigationEvent,
        AuthNavigationEvent.none,
      );
    });

    test('TC05 — Retorno ao login após cadastro', () async {
      //ACT
      await viewModel.signUp(
        name: "Ciacco",
        email: "marcelo@email.com",
        password: "123457",
      );

      //ASSERT
      expect(
        viewModel.authNavigationEvent,
        AuthNavigationEvent.goToLogin,
      );
    });
  });
}
