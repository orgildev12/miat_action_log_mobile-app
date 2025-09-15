import 'package:action_log_app/application/use_cases/location_use_cases/fetch_location_groups_use_case.dart';
import 'package:action_log_app/data/data_sources/location/location_group_local_data.dart';
import 'package:action_log_app/domain/repositories/location_group_repository.dart';
import 'package:action_log_app/data/repositories/location_group_repository_impl.dart';
import 'package:action_log_app/data/data_sources/location/location_group_remote_data.dart';
import 'package:action_log_app/core/di/core_di.dart';
import 'package:action_log_app/core/di/features/location_di.dart';

// Location Group feature dependencies
class LocationGroupDI {
  static late final LocationGroupLocalDataSource _localDataSource;
  static late final LocationGroupRemoteDataSource _remoteDataSource;
  static late final LocationGroupRepository _repository;
  static late final FetchLocationGroupsUseCase _fetchLocationGroupsUseCase;

  static void setup() {
    // Data sources
    _localDataSource = LocationGroupLocalDataSource();
    _remoteDataSource = LocationGroupRemoteDataSource(
      connectivityChecker: CoreDI.connectivityChecker,
      apiClient: CoreDI.apiClient,
    );

    // Repository
    _repository = LocationGroupRepositoryImpl(
      local: _localDataSource,
      remote: _remoteDataSource,
    );

    // Use cases
    _fetchLocationGroupsUseCase = FetchLocationGroupsUseCase(
      locationGroupRepository: _repository,
      locationRepository: LocationDI.repository, // Add location repository
    );
  }

  // Getters for location group dependencies
  static LocationGroupLocalDataSource get localDataSource => _localDataSource;
  static LocationGroupRemoteDataSource get remoteDataSource => _remoteDataSource;
  static LocationGroupRepository get repository => _repository;
  static FetchLocationGroupsUseCase get fetchLocationGroupsUseCase => _fetchLocationGroupsUseCase;
}