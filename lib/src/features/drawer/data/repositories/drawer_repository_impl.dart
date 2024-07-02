import 'dart:io';

import 'package:emdr_mindmend/src/core/constants/api_urls.dart';
import 'package:emdr_mindmend/src/core/constants/globals.dart';
import 'package:emdr_mindmend/src/core/services/network/api_data_source.dart';
import 'package:emdr_mindmend/src/features/drawer/domain/repositories/drawer_repository.dart';

class DrawerRepositoryImpl implements DrawerRepository {
  @override
  Future<void> contactUs({required Map<String, dynamic> body}) async {
    try {
      await NetworkApi.instance.post(url: ApiUrls.contactUs, body: body);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> editProfile(
      {required List<MapEntry<String, File>> files,
      required Map<String, dynamic> body}) async {
    try {
      await NetworkApi.instance.put(
          url: ApiUrls.editProfile,
          body: body,
          files: files,
          customHeader: {"Bearer": "${userData?.accessToken}"});
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
}
