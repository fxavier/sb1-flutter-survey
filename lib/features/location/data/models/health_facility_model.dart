import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';
import 'package:survey_app/features/location/data/models/district_model.dart';

class HealthFacilityModel extends ParseObject implements ParseCloneable {
  HealthFacilityModel() : super('HealthFacility');
  HealthFacilityModel.clone() : this();

  @override
  HealthFacilityModel clone(Map<String, dynamic> map) => HealthFacilityModel.clone()..fromJson(map);

  String get name => get<String>('name') ?? '';
  set name(String value) => set<String>('name', value);

  DistrictModel? get district => get<DistrictModel>('district');
  set district(DistrictModel? value) => set<DistrictModel>('district', value);
}