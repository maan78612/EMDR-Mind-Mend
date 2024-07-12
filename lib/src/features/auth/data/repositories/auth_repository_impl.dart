import 'dart:io';

import 'package:emdr_mindmend/src/core/constants/api_urls.dart';
import 'package:emdr_mindmend/src/core/services/network/api_data_source.dart';
import 'package:emdr_mindmend/src/features/auth/domain/models/user.dart';
import 'package:emdr_mindmend/src/features/auth/domain/repositories/auth_repository.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

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
  Future<void> googleLogin() async {
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

      debugPrint(googleAccount?.email);
      debugPrint(googleAccount?.id);
    } on Exception catch (e) {
      throw Exception(e.toString());
    }
  }
}
