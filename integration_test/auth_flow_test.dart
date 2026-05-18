import 'package:auth_29119_app/app/app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Fluxo de autenticação - Testes de Integração', () {
    testWidgets(
      'TC09 — Cadastro, login e navegação para Home',
      (WidgetTester tester) async {
        //ARRANGE
        await tester.pumpWidget(const MyApp());
        await tester.pumpAndSettle();

        //Verificar se iniciou na tela de Login
        expect(
          find.text('Login'),
          findsOneWidget,
        );
        expect(
          find.text('Entrar'),
          findsOneWidget,
        );

        //Vai para a tela de cadastro
        await tester.tap(find.text('Primeiro acesso'));
        await tester.pumpAndSettle();

        expect(find.text('Cadastro'), findsOneWidget);
        expect(find.text('Criar Conta'), findsOneWidget);

        //Preencher os campos do cadastro
        await tester.enterText(
          find.widgetWithText(TextField, 'Nome'),
          'Fulano',
        );
        await tester.enterText(
          find.widgetWithText(TextField, 'E-mail'),
          'Fulano@exemplo.com',
        );
        await tester.enterText(
          find.widgetWithText(TextField, 'Senha'),
          '123456ABC',
        );

        //Executar o cadastro
        await tester.tap(find.text('Cadastrar'));
        await tester.pumpAndSettle();

        //Verificar se cadastro -> login
        expect(
          find.text('Login'),
          findsOneWidget,
        );

        //Efetuar o Login
        await tester.enterText(
          find.widgetWithText(TextField, 'E-mail'),
          'Fulano@exemplo.com',
        );
        await tester.enterText(
          find.widgetWithText(TextField, 'Senha'),
          '123456ABC',
        );

        //Executar o login
        await tester.tap(find.text('Entrar'));
        await tester.pumpAndSettle();

        //Verificar se navegou para HOME
        expect(find.text('Home'), findsOneWidget);
        expect(find.text('Bem-vindo à HOME'), findsOneWidget);
      },
    );
  });
}
