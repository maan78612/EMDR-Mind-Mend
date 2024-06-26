import 'package:emdr_mindmend/src/features/on_boarding/domain/models/on_boarding.dart';

abstract class OnBoardingRepository {
  List<OnBoardingModel> populateData();
}
