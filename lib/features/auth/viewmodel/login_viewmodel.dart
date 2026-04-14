import 'package:auth_29119_app/core/ui/ui_event.dart';
import 'package:auth_29119_app/core/ui/ui_message.dart';
import 'package:auth_29119_app/features/auth/data/repository/auth_repository.dart';
import 'package:flutter/foundation.dart';

class LoginViewModel extends ChangeNotifier {
  final AuthRepository repository;

  LoginViewModel(this.repository);

  bool _isLoading = false;
  UiMessage? _uiMessage;
  AuthNavigationEvent _authNavigationEvent = AuthNavigationEvent.none;

  bool get isLoading => _isLoading;
  UiMessage? get uiMessage => _uiMessage;
  AuthNavigationEvent get authNavigationEvent => _authNavigationEvent;

  Future<void> login({required String email, required String password}) async {
    if (email.trim().isEmpty || password.trim().isEmpty) {
      _uiMessage = UiMessage("Preencha email e senha.");
      notifyListeners();
      return;
    }

    _setLoading(true);

    try {
      await repository.login(email: email.trim(), password: password.trim());
      _authNavigationEvent = AuthNavigationEvent.goToHome;
    } catch (e) {
      _uiMessage = UiMessage(_extractMessage(e));
    } finally {
      _setLoading(false);
    }
  }

  void goToSignup() {
    _authNavigationEvent = AuthNavigationEvent.goToSignUp;
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

  String _extractMessage(Object e) {
    final text = e.toString();
    if (text.startsWith("Exception: ")) {
      return text.replaceFirst("Exception: ", '');
    }
    return 'Ocorreu um erro ao realizar login';
  }
}
