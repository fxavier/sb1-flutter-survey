import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';
import 'package:survey_app/features/location/data/models/sector_model.dart';

class AreaModel extends ParseObject implements ParseCloneable {
  AreaModel() : super('Area');
  AreaModel.clone() : this();

  @override
  AreaModel clone(Map<String, dynamic> map) => AreaModel.clone()..fromJson(map);

  String get name => get<String>('name') ?? '';
  set name(String value) => set<String>('name', value);

  SectorModel? get sector => get<SectorModel>('sector');
  set sector(SectorModel? value) => set<SectorModel>('sector', value);
}