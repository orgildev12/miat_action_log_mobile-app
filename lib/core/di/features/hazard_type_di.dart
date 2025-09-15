import 'package:action_log_app/application/use_cases/hazard_type_use_cases/fetch_hazard_types_use_case.dart';
import 'package:action_log_app/application/use_cases/hazard_type_use_cases/clear_hazard_type_cache_use_case.dart';
import 'package:action_log_app/core/di/core_di.dart';
import 'package:action_log_app/data/data_sources/hazard_type/hazard_type_local_data.dart';
import 'package:action_log_app/data/data_sources/hazard_type/hazard_type_remote_data.dart';
import 'package:action_log_app/domain/repositories/hazard_type_repository.dart';
import 'package:action_log_app/data/repositories/hazard_type_repository_impl.dart';

class HazardTypeDI {
  static late final HazardTypeLocalDataSource _localDataSource;
  static late final HazardTypeRemoteDataSource _remoteDataSource;
  static late final HazardTypeRepository _repository;
  static late final FetchHazardTypesUseCase _fetchHazardTypesUseCase;
  static late final ClearHazardTypeCacheUseCase _clearHazardTypeCacheUseCase;

  static void setup() {
    // Data sources
    _localDataSource = HazardTypeLocalDataSource();
    _remoteDataSource = HazardTypeRemoteDataSource(
      connectivityChecker: CoreDI.connectivityChecker,  // Fixed: parameter name
      apiClient: CoreDI.apiClient,                      // Fixed: access method
    );

    // Repository
    _repository = HazardTypeRepositoryImpl(
      local: _localDataSource,
      remote: _remoteDataSource,
    );

    // Use cases
    _fetchHazardTypesUseCase = FetchHazardTypesUseCase(
      repository: _repository,
    );

    _clearHazardTypeCacheUseCase = ClearHazardTypeCacheUseCase(
      repository: _repository,
    );
  }

  // Getters for dependencies
  static HazardTypeLocalDataSource get localDataSource => _localDataSource;
  static HazardTypeRemoteDataSource get remoteDataSource => _remoteDataSource;
  static HazardTypeRepository get repository => _repository;
  static FetchHazardTypesUseCase get fetchHazardTypesUseCase => _fetchHazardTypesUseCase;
  static ClearHazardTypeCacheUseCase get clearHazardTypeCacheUseCase => _clearHazardTypeCacheUseCase;
}