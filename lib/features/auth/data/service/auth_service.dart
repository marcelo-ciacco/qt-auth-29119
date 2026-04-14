import 'package:auth_29119_app/features/auth/model/user_model.dart';

abstract interface class AuthService {
  Future<void> signup(UserModel user);
  Future<UserModel> login({
    required String email,
    required String password,
  });
}
