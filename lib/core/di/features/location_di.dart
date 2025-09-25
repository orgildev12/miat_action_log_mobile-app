import 'package:action_log_app/application/use_cases/location_use_cases/fetch_locations_use_case.dart';
import 'package:action_log_app/application/use_cases/location_use_cases/clear_location_cache.dart';
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
  static ClearLocationCacheUseCase? _clearLocationCacheUseCase;


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

    _clearLocationCacheUseCase = ClearLocationCacheUseCase(
      locationRepository: _repository
    );
    // ClearLocationCacheUseCase will be initialized after LocationGroupDI is available
  }

  // Initialize ClearLocationCacheUseCase with LocationGroupRepository
  static void initializeClearCache(LocationRepository locationRepository) {
    _clearLocationCacheUseCase = ClearLocationCacheUseCase(
      locationRepository: _repository,
    );
  }

  // Getters for dependencies
  static LocationLocalDataSource get localDataSource => _localDataSource;
  static LocationRemoteDataSource get remoteDataSource => _remoteDataSource;
  static LocationRepository get repository => _repository;
  static FetchLocationsUseCase get fetchLocationsUseCase => _fetchLocationsUseCase;
  static ClearLocationCacheUseCase get clearLocationCacheUseCase => _clearLocationCacheUseCase!;
}