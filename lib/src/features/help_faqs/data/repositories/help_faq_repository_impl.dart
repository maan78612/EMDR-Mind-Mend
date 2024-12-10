import 'dart:io';

import 'package:emdr_mindmend/src/core/constants/api_urls.dart';
import 'package:emdr_mindmend/src/core/services/network/api_data_source.dart';
import 'package:emdr_mindmend/src/features/help_faqs/domain/repositories/help_faq_repository.dart';

class HelpFaqRepositoryImpl implements HelpFaqRepository {
  @override
  Future<void> contactUs({required Map<String, dynamic> body}) async {
    try {
      await NetworkApi.instance.post(url: ApiUrls.contactUs, body: body);
    } catch (e) {
      rethrow;
    }
  }
}
