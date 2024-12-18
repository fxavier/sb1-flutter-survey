import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';
import 'package:survey_app/features/location/data/models/health_facility_model.dart';

class SectorModel extends ParseObject implements ParseCloneable {
  SectorModel() : super('Sector');
  SectorModel.clone() : this();

  @override
  SectorModel clone(Map<String, dynamic> map) => SectorModel.clone()..fromJson(map);

  String get name => get<String>('name') ?? '';
  set name(String value) => set<String>('name', value);

  HealthFacilityModel? get healthFacility => get<HealthFacilityModel>('healthFacility');
  set healthFacility(HealthFacilityModel? value) => set<HealthFacilityModel>('healthFacility', value);
}