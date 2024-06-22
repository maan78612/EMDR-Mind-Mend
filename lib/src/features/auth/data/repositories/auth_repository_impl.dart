import 'package:emdr_mindmend/src/core/services/network/api_data_source.dart';
import 'package:emdr_mindmend/src/features/auth/domain/models/user.dart';
import 'package:emdr_mindmend/src/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  @override
  Future<User> login(
      {required String username, required String password}) async {
    try {
      var value = await NetworkApi.instance.get(url: "");
      return User.fromJson(value);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> register(User user) async {
    // Implement register logic using _remoteDataSource or _localDataSource
  }

  @override
  Future<User> getUser() {
    // TODO: implement getUser
    throw UnimplementedError();
  }

  @override
  Future<void> logout() {
    // TODO: implement logout
    throw UnimplementedError();
  }

// ...
}
