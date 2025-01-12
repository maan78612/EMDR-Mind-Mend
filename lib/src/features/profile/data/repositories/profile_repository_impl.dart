import 'dart:io';

import 'package:emdr_mindmend/src/core/constants/api_urls.dart';
import 'package:emdr_mindmend/src/core/services/network/api_data_source.dart';
import 'package:emdr_mindmend/src/features/profile/domain/models/update_profile_response.dart';
import 'package:emdr_mindmend/src/features/profile/domain/repositories/profile_repository.dart';
import 'package:google_sign_in/google_sign_in.dart';

class ProfileRepositoryImpl implements ProfileRepository {


  @override
  Future<UpdateProfileResponseModel> editProfile(
      {required List<MapEntry<String, File>> files,
      required Map<String, dynamic> body}) async {
    try {
      final value = await NetworkApi.instance
          .put(url: ApiUrls.editProfile, body: body, files: files);

      return UpdateProfileResponseModel.fromJson(value);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> logout({required Map<String, dynamic> body}) async {
    try {
      await NetworkApi.instance.post(url: ApiUrls.logout, body: body);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<GoogleSignInAccount?> googleLogout() async {
    try {
      GoogleSignIn googleSignIn = GoogleSignIn(scopes: ['email']);

      final GoogleSignInAccount? googleAccount = await googleSignIn.signOut();

      return googleAccount;
    } on Exception catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<void> deleteUser({required String userId}) async {
    try {
      await NetworkApi.instance.delete(url: "${ApiUrls.deleteUser}$userId");
    } catch (e) {
      rethrow;
    }
  }
}
