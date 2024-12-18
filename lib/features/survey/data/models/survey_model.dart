import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

class SurveyModel extends ParseObject implements ParseCloneable {
  SurveyModel() : super('Survey');

  SurveyModel.clone() : this();

  @override
  SurveyModel clone(Map<String, dynamic> map) => SurveyModel.clone()..fromJson(map);

  String get title => get<String>('title') ?? '';
  set title(String value) => set<String>('title', value);

  String get description => get<String>('description') ?? '';
  set description(String value) => set<String>('description', value);

  List<String> get questions => get<List<String>>('questions') ?? [];
  set questions(List<String> value) => set<List<String>>('questions', value);
}