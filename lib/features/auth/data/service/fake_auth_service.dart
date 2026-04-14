import 'package:auth_29119_app/features/auth/data/service/auth_service.dart';
import 'package:auth_29119_app/features/auth/model/user_model.dart';

class FakeAuthService implements AuthService {
  final List<UserModel> _users = [];

  @override
  Future<UserModel> login({
    required String email,
    required String password,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));

    try {
      final user = _users.firstWhere(
        (u) => u.email == email && u.password == password,
      );
      return user;
    } catch (_) {
      throw Exception('E-mail ou senha invalidos');
    }
  }

  @override
  Future<void> signup(UserModel user) async {
    await Future.delayed(const Duration(milliseconds: 500));

    final alreadyExists = _users.any((u) => u.email == user.email);

    if (alreadyExists) {
      throw Exception('E-mail já cadastrado');
    }

    _users.add(user);
  }
}
