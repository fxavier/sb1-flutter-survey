import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';
import 'package:survey_app/features/location/data/models/province_model.dart';
import 'package:survey_app/features/location/data/models/district_model.dart';
import 'package:survey_app/features/location/data/models/health_facility_model.dart';
import 'package:survey_app/features/location/data/models/sector_model.dart';
import 'package:survey_app/features/location/data/models/area_model.dart';
import 'package:survey_app/features/location/data/models/indicator_model.dart';

class LocationRepository {
  Future<List<ProvinceModel>> getProvinces() async {
    final query = QueryBuilder<ProvinceModel>(ProvinceModel())
      ..orderByAscending('name');
    final response = await query.query();
    return response.results?.cast<ProvinceModel>() ?? [];
  }

  Future<List<DistrictModel>> getDistrictsByProvince(ProvinceModel province) async {
    final query = QueryBuilder<DistrictModel>(DistrictModel())
      ..whereEqualTo('province', province)
      ..orderByAscending('name');
    final response = await query.query();
    return response.results?.cast<DistrictModel>() ?? [];
  }

  Future<List<HealthFacilityModel>> getHealthFacilitiesByDistrict(DistrictModel district) async {
    final query = QueryBuilder<HealthFacilityModel>(HealthFacilityModel())
      ..whereEqualTo('district', district)
      ..orderByAscending('name');
    final response = await query.query();
    return response.results?.cast<HealthFacilityModel>() ?? [];
  }

  Future<List<SectorModel>> getSectorsByHealthFacility(HealthFacilityModel healthFacility) async {
    final query = QueryBuilder<SectorModel>(SectorModel())
      ..whereEqualTo('healthFacility', healthFacility)
      ..orderByAscending('name');
    final response = await query.query();
    return response.results?.cast<SectorModel>() ?? [];
  }

  Future<List<AreaModel>> getAreasBySector(SectorModel sector) async {
    final query = QueryBuilder<AreaModel>(AreaModel())
      ..whereEqualTo('sector', sector)
      ..orderByAscending('name');
    final response = await query.query();
    return response.results?.cast<AreaModel>() ?? [];
  }

  Future<List<IndicatorModel>> getIndicatorsByArea(AreaModel area) async {
    final query = QueryBuilder<IndicatorModel>(IndicatorModel())
      ..whereEqualTo('area', area)
      ..orderByAscending('name');
    final response = await query.query();
    return response.results?.cast<IndicatorModel>() ?? [];
  }
}