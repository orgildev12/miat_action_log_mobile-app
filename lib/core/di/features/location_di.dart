import 'package:action_log_app/application/use_cases/fetch_locations_use_case.dart';
import 'package:action_log_app/domain/repositories/location_repository.dart';
import 'package:action_log_app/data/reposities/location_repository_impl.dart';
import 'package:action_log_app/data/data_sources/location_local_data.dart';
import 'package:action_log_app/data/data_sources/location_remote_data.dart';
import 'package:action_log_app/core/di/core_di.dart';

class LocationDI {
  static late final LocationLocalDataSource _localDataSource;
  static late final LocationRemoteDataSource _remoteDataSource;
  static late final LocationRepository _repository;
  static late final FetchLocationsUseCase _fetchLocationsUseCase;

  static void setup() {
    _localDataSource = LocationLocalDataSource();
    _remoteDataSource = LocationRemoteDataSource(
      connectivityChecker: CoreDI.connectivityChecker,
      apiClient: CoreDI.apiClient
    );

    _repository = LocationRepositoryImpl(
      local: _localDataSource,
      remote: _remoteDataSource
    );

    _fetchLocationsUseCase = FetchLocationsUseCase(
      repository: _repository
    );

    _clearLocationsCacheUseCase = ClearLocationsCacheUseCase(
      repository: _repository
    );
  }

  static LocationLocalDataSource get localDataSource => _localDataSource;
  static LocationRemoteDataSource get remoteDataSource => _remoteDataSource;
  static LocationRepository get repository => _repository;
  static FetchLocationsUseCase get fetchLocationUseCase => _fetchLocationsUseCase;
  static ClearLocationsCacheUseCase get clearLocationsCacheUseCase => _clearLocationsCacheUseCase;

}