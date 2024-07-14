import 'dart:io';

import 'package:emdr_mindmend/src/core/constants/api_urls.dart';
import 'package:emdr_mindmend/src/core/services/network/api_data_source.dart';
import 'package:emdr_mindmend/src/features/auth/domain/models/user.dart';
import 'package:emdr_mindmend/src/features/auth/domain/repositories/auth_repository.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class AuthRepositoryImpl implements AuthRepository {
  @override
  Future<UserModel> login({required Map<String, dynamic> body}) async {
    try {
      final value =
          await NetworkApi.instance.post(url: ApiUrls.login, body: body);
      return UserModel.fromJson(value["data"]);
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
      await NetworkApi.instance.post(url: ApiUrls.forgetPass, body: body);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<GoogleSignInAccount?> googleLogin() async {
    try {
      GoogleSignIn googleSignIn = GoogleSignIn(scopes: ['email']);

      if (Platform.isAndroid) {
        googleSignIn = GoogleSignIn(
          scopes: ['email'],
        );
      }

      if (Platform.isIOS) {
        googleSignIn = GoogleSignIn(
            clientId:
                "84018247753-5jln8121r7g8up0mnsm9tobumsh2lv5r.apps.googleusercontent.com",
            scopes: ['email']);
      }

      final GoogleSignInAccount? googleAccount = await googleSignIn.signIn();

      return googleAccount;
    } on Exception catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<AuthorizationCredentialAppleID> appleLogin() async {
    try {
      final credential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
      );

      return credential;
    } on SignInWithAppleAuthorizationException catch (e) {
      throw Exception(e.message);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<UserModel> appleSocialLogin(
      {required Map<String, dynamic> body}) async {
    try {
      final value =
          await NetworkApi.instance.post(url: ApiUrls.appleLogin, body: body);
      return UserModel.fromJson(value["data"]);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<UserModel> googleSocialLogin(
      {required Map<String, dynamic> body}) async {
    try {
      final value =
          await NetworkApi.instance.post(url: ApiUrls.googleLogin, body: body);
      return UserModel.fromJson(value["data"]);
    } catch (e) {
      rethrow;
    }
  }
}
