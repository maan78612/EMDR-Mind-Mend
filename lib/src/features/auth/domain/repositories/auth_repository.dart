import 'package:emdr_mindmend/src/features/auth/domain/models/user.dart';

abstract class AuthRepository {
  Future<UserModel> login({required Map<String, dynamic> body});
  Future<void> register({required Map<String, dynamic> body});
  Future<void> forgetPassword({required Map<String, dynamic> body});

}