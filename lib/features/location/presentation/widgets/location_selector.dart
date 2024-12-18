import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:survey_app/features/location/presentation/bloc/location_bloc.dart';
import 'package:survey_app/features/location/data/models/province_model.dart';
import 'package:survey_app/features/location/data/models/district_model.dart';
import 'package:survey_app/features/location/data/models/health_facility_model.dart';
import 'package:survey_app/features/location/data/models/sector_model.dart';
import 'package:survey_app/features/location/data/models/area_model.dart';
import 'package:survey_app/features/location/data/models/indicator_model.dart';

class LocationSelector extends StatelessWidget {
  const LocationSelector({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocationBloc, LocationState>(
      builder: (context, state) {
        if (state.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state.error != null) {
          return Center(child: Text('Error: ${state.error}'));
        }

        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildDropdown<ProvinceModel>(
                items: state.provinces,
                value: state.selectedProvince,
                label: 'Province',
                getLabel: (province) => province.name,
                onChanged: (province) {
                  if (province != null) {
                    context.read<LocationBloc>().add(ProvinceSelected(province));
                  }
                },
              ),
              if (state.districts.isNotEmpty) ...[
                const SizedBox(height: 16),
                _buildDropdown<DistrictModel>(
                  items: state.districts,
                  value: state.selectedDistrict,
                  label: 'District',
                  getLabel: (district) => district.name,
                  onChanged: (district) {
                    if (district != null) {
                      context.read<LocationBloc>().add(DistrictSelected(district));
                    }
                  },
                ),
              ],
              if (state.healthFacilities.isNotEmpty) ...[
                const SizedBox(height: 16),
                _buildDropdown<HealthFacilityModel>(
                  items: state.healthFacilities,
                  value: state.selectedHealthFacility,
                  label: 'Health Facility',
                  getLabel: (hf) => hf.name,
                  onChanged: (hf) {
                    if (hf != null) {
                      context.read<LocationBloc>().add(HealthFacilitySelected(hf));
                    }
                  },
                ),
              ],
              if (state.sectors.isNotEmpty) ...[
                const SizedBox(height: 16),
                _buildDropdown<SectorModel>(
                  items: state.sectors,
                  value: state.selectedSector,
                  label: 'Sector',
                  getLabel: (sector) => sector.name,
                  onChanged: (sector) {
                    if (sector != null) {
                      context.read<LocationBloc>().add(SectorSelected(sector));
                    }
                  },
                ),
              ],
              if (state.areas.isNotEmpty) ...[
                const SizedBox(height: 16),
                _buildDropdown<AreaModel>(
                  items: state.areas,
                  value: state.selectedArea,
                  label: 'Area',
                  getLabel: (area) => area.name,
                  onChanged: (area) {
                    if (area != null) {
                      context.read<LocationBloc>().add(AreaSelected(area));
                    }
                  },
                ),
              ],
              if (state.indicators.isNotEmpty) ...[
                const SizedBox(height: 16),
                _buildDropdown<IndicatorModel>(
                  items: state.indicators,
                  value: state.selectedIndicator,
                  label: 'Indicator',
                  getLabel: (indicator) => indicator.name,
                  onChanged: (indicator) {
                    // Handle indicator selection
                  },
                ),
              ],
            ],
          ),
        );
      },
    );
  }

  Widget _buildDropdown<T>({
    required List<T> items,
    required T? value,
    required String label,
    required String Function(T) getLabel,
    required void Function(T?) onChanged,
  }) {
    return DropdownButtonFormField<T>(
      value: value,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
      ),
      items: items.map((item) {
        return DropdownMenuItem<T>(
          value: item,
          child: Text(getLabel(item)),
        );
      }).toList(),
      onChanged: onChanged,
    );
  }
}