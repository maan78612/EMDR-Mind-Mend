import 'package:emdr_mindmend/src/features/auth/domain/models/user.dart';

abstract class AuthRepository {
  Future<User> login({required String username, required String password});
  Future<void> register(User user);
  Future<void> logout();
  Future<User> getUser();
}