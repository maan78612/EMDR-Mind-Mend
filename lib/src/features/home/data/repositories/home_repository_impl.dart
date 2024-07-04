import 'package:emdr_mindmend/src/core/constants/api_urls.dart';
import 'package:emdr_mindmend/src/core/services/network/api_data_source.dart';
import 'package:emdr_mindmend/src/features/home/domain/repositories/home_repository.dart';

class HomeRepositoryImpl implements HomeRepository {
  @override
  Future<void> getScore() async {
    try {
      await NetworkApi.instance.get(url: ApiUrls.getScore);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> sendScore({required Map<String, dynamic> body}) async {
    try {
      await NetworkApi.instance.post(url: ApiUrls.saveScore, body: body);
    } catch (e) {
      rethrow;
    }
  }
}
