import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';
import 'package:survey_app/features/location/data/models/province_model.dart';

class DistrictModel extends ParseObject implements ParseCloneable {
  DistrictModel() : super('District');
  DistrictModel.clone() : this();

  @override
  DistrictModel clone(Map<String, dynamic> map) => DistrictModel.clone()..fromJson(map);

  String get name => get<String>('name') ?? '';
  set name(String value) => set<String>('name', value);

  ProvinceModel? get province => get<ProvinceModel>('province');
  set province(ProvinceModel? value) => set<ProvinceModel>('province', value);
}