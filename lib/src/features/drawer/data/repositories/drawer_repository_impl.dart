import 'dart:io';

import 'package:emdr_mindmend/src/core/services/network/api_data_source.dart';
import 'package:emdr_mindmend/src/features/drawer/domain/repositories/drawer_repository.dart';

class DrawerRepositoryImpl implements DrawerRepository {
  @override
  Future<void> contactUs({required Map<String, dynamic> body}) async {
    try {
      var value = await NetworkApi.instance.post(url: "", body: body);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> editProfile(
      {required List<MapEntry<String, File>> files,
      required Map<String, dynamic> body}) async {
    try {
      var value =
          await NetworkApi.instance.patch(url: "", body: body, files: files);
    } catch (e) {
      rethrow;
    }
  }
}
