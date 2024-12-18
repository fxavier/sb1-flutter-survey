import 'package:survey_app/features/survey/data/models/survey_model.dart';

class SurveyRepository {
  Future<List<SurveyModel>> getSurveys() async {
    final queryBuilder = QueryBuilder<SurveyModel>(SurveyModel())
      ..orderByDescending('createdAt');

    final response = await queryBuilder.query();
    if (response.success && response.results != null) {
      return response.results!.cast<SurveyModel>();
    }
    return [];
  }

  Future<bool> createSurvey(String title, String description, List<String> questions) async {
    final survey = SurveyModel()
      ..title = title
      ..description = description
      ..questions = questions;

    final response = await survey.save();
    return response.success;
  }
}