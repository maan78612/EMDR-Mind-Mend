import 'dart:io';

import 'package:emdr_mindmend/src/features/profile/domain/models/update_profile_response.dart';
import 'package:google_sign_in/google_sign_in.dart';

abstract class ProfileRepository {
  Future<UpdateProfileResponseModel> editProfile(
      {required List<MapEntry<String, File>> files,
      required Map<String, dynamic> body});



  Future<void> logout({required Map<String, dynamic> body});
  Future<void> deleteUser({required String userId});
  Future<GoogleSignInAccount?> googleLogout();
}
