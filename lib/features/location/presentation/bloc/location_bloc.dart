import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:survey_app/features/location/data/models/province_model.dart';
import 'package:survey_app/features/location/data/models/district_model.dart';
import 'package:survey_app/features/location/data/models/health_facility_model.dart';
import 'package:survey_app/features/location/data/models/sector_model.dart';
import 'package:survey_app/features/location/data/models/area_model.dart';
import 'package:survey_app/features/location/data/models/indicator_model.dart';
import 'package:survey_app/features/location/data/repositories/location_repository.dart';

// Events
abstract class LocationEvent extends Equatable {
  const LocationEvent();

  @override
  List<Object?> get props => [];
}

class LoadProvinces extends LocationEvent {}

class ProvinceSelected extends LocationEvent {
  final ProvinceModel province;
  const ProvinceSelected(this.province);

  @override
  List<Object> get props => [province];
}

class DistrictSelected extends LocationEvent {
  final DistrictModel district;
  const DistrictSelected(this.district);

  @override
  List<Object> get props => [district];
}

class HealthFacilitySelected extends LocationEvent {
  final HealthFacilityModel healthFacility;
  const HealthFacilitySelected(this.healthFacility);

  @override
  List<Object> get props => [healthFacility];
}

class SectorSelected extends LocationEvent {
  final SectorModel sector;
  const SectorSelected(this.sector);

  @override
  List<Object> get props => [sector];
}

class AreaSelected extends LocationEvent {
  final AreaModel area;
  const AreaSelected(this.area);

  @override
  List<Object> get props => [area];
}

// State
class LocationState extends Equatable {
  final List<ProvinceModel> provinces;
  final List<DistrictModel> districts;
  final List<HealthFacilityModel> healthFacilities;
  final List<SectorModel> sectors;
  final List<AreaModel> areas;
  final List<IndicatorModel> indicators;
  
  final ProvinceModel? selectedProvince;
  final DistrictModel? selectedDistrict;
  final HealthFacilityModel? selectedHealthFacility;
  final SectorModel? selectedSector;
  final AreaModel? selectedArea;
  final IndicatorModel? selectedIndicator;
  
  final bool isLoading;
  final String? error;

  const LocationState({
    this.provinces = const [],
    this.districts = const [],
    this.healthFacilities = const [],
    this.sectors = const [],
    this.areas = const [],
    this.indicators = const [],
    this.selectedProvince,
    this.selectedDistrict,
    this.selectedHealthFacility,
    this.selectedSector,
    this.selectedArea,
    this.selectedIndicator,
    this.isLoading = false,
    this.error,
  });

  LocationState copyWith({
    List<ProvinceModel>? provinces,
    List<DistrictModel>? districts,
    List<HealthFacilityModel>? healthFacilities,
    List<SectorModel>? sectors,
    List<AreaModel>? areas,
    List<IndicatorModel>? indicators,
    ProvinceModel? selectedProvince,
    DistrictModel? selectedDistrict,
    HealthFacilityModel? selectedHealthFacility,
    SectorModel? selectedSector,
    AreaModel? selectedArea,
    IndicatorModel? selectedIndicator,
    bool? isLoading,
    String? error,
  }) {
    return LocationState(
      provinces: provinces ?? this.provinces,
      districts: districts ?? this.districts,
      healthFacilities: healthFacilities ?? this.healthFacilities,
      sectors: sectors ?? this.sectors,
      areas: areas ?? this.areas,
      indicators: indicators ?? this.indicators,
      selectedProvince: selectedProvince ?? this.selectedProvince,
      selectedDistrict: selectedDistrict ?? this.selectedDistrict,
      selectedHealthFacility: selectedHealthFacility ?? this.selectedHealthFacility,
      selectedSector: selectedSector ?? this.selectedSector,
      selectedArea: selectedArea ?? this.selectedArea,
      selectedIndicator: selectedIndicator ?? this.selectedIndicator,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }

  @override
  List<Object?> get props => [
    provinces,
    districts,
    healthFacilities,
    sectors,
    areas,
    indicators,
    selectedProvince,
    selectedDistrict,
    selectedHealthFacility,
    selectedSector,
    selectedArea,
    selectedIndicator,
    isLoading,
    error,
  ];
}

class LocationBloc extends Bloc<LocationEvent, LocationState> {
  final LocationRepository _repository;

  LocationBloc({required LocationRepository repository})
      : _repository = repository,
        super(const LocationState()) {
    on<LoadProvinces>(_onLoadProvinces);
    on<ProvinceSelected>(_onProvinceSelected);
    on<DistrictSelected>(_onDistrictSelected);
    on<HealthFacilitySelected>(_onHealthFacilitySelected);
    on<SectorSelected>(_onSectorSelected);
    on<AreaSelected>(_onAreaSelected);
  }

  Future<void> _onLoadProvinces(LoadProvinces event, Emitter<LocationState> emit) async {
    emit(state.copyWith(isLoading: true));
    try {
      final provinces = await _repository.getProvinces();
      emit(state.copyWith(
        provinces: provinces,
        isLoading: false,
        districts: [],
        healthFacilities: [],
        sectors: [],
        areas: [],
        indicators: [],
        selectedProvince: null,
        selectedDistrict: null,
        selectedHealthFacility: null,
        selectedSector: null,
        selectedArea: null,
        selectedIndicator: null,
      ));
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: e.toString()));
    }
  }

  Future<void> _onProvinceSelected(ProvinceSelected event, Emitter<LocationState> emit) async {
    emit(state.copyWith(isLoading: true));
    try {
      final districts = await _repository.getDistrictsByProvince(event.province);
      emit(state.copyWith(
        selectedProvince: event.province,
        districts: districts,
        healthFacilities: [],
        sectors: [],
        areas: [],
        indicators: [],
        selectedDistrict: null,
        selectedHealthFacility: null,
        selectedSector: null,
        selectedArea: null,
        selectedIndicator: null,
        isLoading: false,
      ));
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: e.toString()));
    }
  }

  Future<void> _onDistrictSelected(DistrictSelected event, Emitter<LocationState> emit) async {
    emit(state.copyWith(isLoading: true));
    try {
      final healthFacilities = await _repository.getHealthFacilitiesByDistrict(event.district);
      emit(state.copyWith(
        selectedDistrict: event.district,
        healthFacilities: healthFacilities,
        sectors: [],
        areas: [],
        indicators: [],
        selectedHealthFacility: null,
        selectedSector: null,
        selectedArea: null,
        selectedIndicator: null,
        isLoading: false,
      ));
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: e.toString()));
    }
  }

  Future<void> _onHealthFacilitySelected(HealthFacilitySelected event, Emitter<LocationState> emit) async {
    emit(state.copyWith(isLoading: true));
    try {
      final sectors = await _repository.getSectorsByHealthFacility(event.healthFacility);
      emit(state.copyWith(
        selectedHealthFacility: event.healthFacility,
        sectors: sectors,
        areas: [],
        indicators: [],
        selectedSector: null,
        selectedArea: null,
        selectedIndicator: null,
        isLoading: false,
      ));
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: e.toString()));
    }
  }

  Future<void> _onSectorSelected(SectorSelected event, Emitter<LocationState> emit) async {
    emit(state.copyWith(isLoading: true));
    try {
      final areas = await _repository.getAreasBySector(event.sector);
      emit(state.copyWith(
        selectedSector: event.sector,
        areas: areas,
        indicators: [],
        selectedArea: null,
        selectedIndicator: null,
        isLoading: false,
      ));
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: e.toString()));
    }
  }

  Future<void> _onAreaSelected(AreaSelected event, Emitter<LocationState> emit) async {
    emit(state.copyWith(isLoading: true));
    try {
      final indicators = await _repository.getIndicatorsByArea(event.area);
      emit(state.copyWith(
        selectedArea: event.area,
        indicators: indicators,
        selectedIndicator: null,
        isLoading: false,
      ));
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: e.toString()));
    }
  }
}