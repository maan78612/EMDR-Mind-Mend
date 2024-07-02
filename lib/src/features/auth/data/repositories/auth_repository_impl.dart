import 'package:emdr_mindmend/src/core/constants/api_urls.dart';
import 'package:emdr_mindmend/src/core/services/network/api_data_source.dart';
import 'package:emdr_mindmend/src/features/auth/domain/models/user.dart';
import 'package:emdr_mindmend/src/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  @override
  Future<User> login({required Map<String, dynamic> body}) async {
    try {
      final value =
          await NetworkApi.instance.post(url: ApiUrls.login, body: body);
      return User.fromJson(value);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> register({required Map<String, dynamic> body}) async {
    try {
      await NetworkApi.instance.post(url: ApiUrls.signup, body: body);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> forgetPassword({required Map<String, dynamic> body}) async {
    try {
      var value =
          await NetworkApi.instance.put(url: ApiUrls.forgetPass, body: body);
    } catch (e) {
      rethrow;
    }
  }
}
