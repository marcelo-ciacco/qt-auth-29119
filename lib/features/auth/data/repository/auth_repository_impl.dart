import 'package:auth_29119_app/features/auth/data/repository/auth_repository.dart';
import 'package:auth_29119_app/features/auth/data/service/auth_service.dart';
import 'package:auth_29119_app/features/auth/model/user_model.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthService service;

  AuthRepositoryImpl(this.service);

  @override
  Future<UserModel> login({required String email, required String password}) {
    return service.login(
      email: email,
      password: password,
    );
  }

  @override
  Future<void> signUp(UserModel user) {
    return service.signup(user);
  }
}
