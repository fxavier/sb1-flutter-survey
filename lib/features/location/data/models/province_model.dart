import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

class ProvinceModel extends ParseObject implements ParseCloneable {
  ProvinceModel() : super('Province');
  ProvinceModel.clone() : this();

  @override
  ProvinceModel clone(Map<String, dynamic> map) => ProvinceModel.clone()..fromJson(map);

  String get name => get<String>('name') ?? '';
  set name(String value) => set<String>('name', value);
}