import 'package:action_log_app/application/use_cases/location_use_cases/fetch_locations_use_case.dart';
import 'package:action_log_app/data/data_sources/location/location_local_data.dart';
import 'package:action_log_app/domain/repositories/location_repository.dart';
import 'package:action_log_app/data/repositories/location_repository_impl.dart';
import 'package:action_log_app/data/data_sources/location/location_remote_data.dart';
import 'package:action_log_app/core/di/core_di.dart';

class LocationDI {
  static late final LocationLocalDataSource _localDataSource;
  static late final LocationRemoteDataSource _remoteDataSource;
  static late final LocationRepository _repository;
  static late final FetchLocationsUseCase _fetchLocationsUseCase;
  
  // TODO: Create this use case when needed
  // static late final ClearLocationsCacheUseCase _clearLocationsCacheUseCase;

  static void setup() {
    // Data sources
    _localDataSource = LocationLocalDataSource();
    _remoteDataSource = LocationRemoteDataSource(
      connectivityChecker: CoreDI.connectivityChecker,
      apiClient: CoreDI.apiClient,
    );

    // Repository
    _repository = LocationRepositoryImpl(
      local: _localDataSource,
      remote: _remoteDataSource,
    );

    // Use cases
    _fetchLocationsUseCase = FetchLocationsUseCase(
      repository: _repository,
    );

    // TODO: Initialize this when use case is created
    // _clearLocationsCacheUseCase = ClearLocationsCacheUseCase(
    //   repository: _repository,
    // );
  }

  // Getters for dependencies
  static LocationLocalDataSource get localDataSource => _localDataSource;
  static LocationRemoteDataSource get remoteDataSource => _remoteDataSource;
  static LocationRepository get repository => _repository;
  static FetchLocationsUseCase get fetchLocationsUseCase => _fetchLocationsUseCase;
  
  // TODO: Uncomment this getter when use case is implemented
  // static ClearLocationsCacheUseCase get clearLocationsCacheUseCase => _clearLocationsCacheUseCase;
}