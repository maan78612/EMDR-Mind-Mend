import 'dart:io';

abstract class DrawerRepository {
  Future<void> editProfile(
      {required List<MapEntry<String, File>> files,
      required Map<String, dynamic> body});

  Future<void> contactUs({required Map<String, dynamic> body});

  Future<void> logout({required Map<String, dynamic> body});
}
