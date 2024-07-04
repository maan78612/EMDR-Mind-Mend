import 'dart:io';

import 'package:emdr_mindmend/src/features/drawer/domain/models/update_profile_response.dart';

abstract class DrawerRepository {
  Future<UpdateProfileResponseModel> editProfile(
      {required List<MapEntry<String, File>> files,
      required Map<String, dynamic> body});

  Future<void> contactUs({required Map<String, dynamic> body});

  Future<void> logout({required Map<String, dynamic> body});
}
