abstract class HomeRepository {
  Future<void> sendScore({required Map<String, dynamic> body});
  Future<void> getScore();
}
