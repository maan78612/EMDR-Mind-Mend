

abstract class TherapyRepository {
  Future<int> getScore();
  Future<void> sendScore({required Map<String, dynamic> body});

}
