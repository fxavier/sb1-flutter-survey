import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';
import 'package:survey_app/features/location/data/models/area_model.dart';

class IndicatorModel extends ParseObject implements ParseCloneable {
  IndicatorModel() : super('Indicator');
  IndicatorModel.clone() : this();

  @override
  IndicatorModel clone(Map<String, dynamic> map) => IndicatorModel.clone()..fromJson(map);

  String get name => get<String>('name') ?? '';
  set name(String value) => set<String>('name', value);

  AreaModel? get area => get<AreaModel>('area');
  set area(AreaModel? value) => set<AreaModel>('area', value);
}