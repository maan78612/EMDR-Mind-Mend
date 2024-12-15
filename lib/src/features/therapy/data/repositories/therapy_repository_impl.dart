import 'package:emdr_mindmend/src/core/constants/api_urls.dart';
import 'package:emdr_mindmend/src/core/services/network/api_data_source.dart';
import 'package:emdr_mindmend/src/features/therapy/domain/repositories/therapy_repository.dart';

class TherapyRepositoryImpl implements TherapyRepository {
  @override
  Future<int> getScore() async {
    final response = await NetworkApi.instance.get(url: ApiUrls.getScore);

    try {
      // Ensure the response has the required data
      final data = response['data'];

      if (data != null && data is List) {
        // Initialize a variable to hold the sum of all differences
        int totalDifference = 0;

        // Iterate over each record in the list
        for (var record in data) {
          // Ensure the necessary keys are present in each record
          final revaluationOne = record['revaluation_one'];
          final revaluationTwo = record['revaluation_two'];

          // Check if the values exist and are parseable to integers
          if (revaluationOne != null && revaluationTwo != null) {
            final before = _parseToInt(revaluationOne);
            final after = _parseToInt(revaluationTwo);

            // Calculate the difference for the current record
            totalDifference += (after - before);
          } else {
            throw ("Missing 'revaluation one' or 'revaluation two' in record");
          }
        }

        // Return or use the total difference
        return totalDifference;
      } else {
        throw "No valid 'data' found in the response";
      }
    } catch (e) {
      rethrow; // Return a default value or handle as needed
    }
  }

  int _parseToInt(dynamic value) {
    if (value is int) {
      return value; // Already an integer
    } else if (value is String) {
      return int.tryParse(value) ??
          0; // Convert string to int, default to 0 if parsing fails
    } else {
      return 0; // Return 0 for unsupported types
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
