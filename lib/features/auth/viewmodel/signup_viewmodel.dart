import 'package:auth_29119_app/features/auth/data/repository/auth_repository.dart';
import 'package:auth_29119_app/features/auth/model/user_model.dart';
import 'package:flutter/foundation.dart';

import '../../../core/ui/ui_event.dart';
import '../../../core/ui/ui_message.dart';

class SignupViewModel extends ChangeNotifier {
  final AuthRepository repository;

  SignupViewModel(this.repository);

  bool _isLoading = false;
  UiMessage? _uiMessage;
  AuthNavigationEvent _authNavigationEvent = AuthNavigationEvent.none;

  bool get isLoading => _isLoading;
  UiMessage? get uiMessage => _uiMessage;
  AuthNavigationEvent get authNavigationEvent => _authNavigationEvent;

  Future<void> signUp({
    required String name,
    required String email,
    required String password,
  }) async {
    if (name.trim().isEmpty ||
        email.trim().isEmpty ||
        password.trim().isEmpty) {
      _uiMessage = UiMessage("Preencha todos os campos.");
      notifyListeners();
      return;
    }

    if (!_isValidEmail(email)) {
      _uiMessage = UiMessage("Informe um email valido");
      notifyListeners();
      return;
    }

    _setLoading(true);

    try {
      final user = UserModel(
        name: name.trim(),
        email: email.trim(),
        password: password.trim(),
      );
      await repository.signUp(user);

      _uiMessage = UiMessage("Cadastro Realizado com sucesso");
      _authNavigationEvent = AuthNavigationEvent.goToLogin;
      notifyListeners();
    } catch (e) {
      _uiMessage = UiMessage(_extractMessage(e));
      notifyListeners();
    } finally {
      _setLoading(false);
    }
  }

  void goToLogin() {
    _authNavigationEvent = AuthNavigationEvent.goToLogin;
    notifyListeners();
  }

  void clearMessage() {
    _uiMessage = null;
  }

  void clearNavigation() {
    _authNavigationEvent = AuthNavigationEvent.none;
  }

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  bool _isValidEmail(String email) {
    return email.contains('@') && email.contains('.');
  }

  String _extractMessage(Object e) {
    final text = e.toString();
    if (text.startsWith("Exception: ")) {
      return text.replaceFirst("Exception: ", '');
    }
    return 'Ocorreu um erro ao realizar cadastro';
  }
}
