import 'package:action_log_app/application/use_cases/hazard_use_cases/fetch_hazards_use_case.dart';
import 'package:action_log_app/application/use_cases/hazard_use_cases/post_hazard_use_case.dart';
import 'package:action_log_app/application/use_cases/hazard_use_cases/clear_hazard_cache_use_case.dart';
import 'package:action_log_app/core/di/core_di.dart';
import 'package:action_log_app/data/data_sources/hazard/hazard_local_data.dart';
import 'package:action_log_app/data/data_sources/hazard/hazard_remote_data.dart';
import 'package:action_log_app/domain/repositories/hazard_repository.dart';
import 'package:action_log_app/data/repositories/hazard_repository_impl.dart';

class HazardDI {
  static late final HazardLocalDataSource _localDataSource;
  static late final HazardRemoteDataSource _remoteDataSource;
  static late final HazardRepository _repository;
  
  // Hazard use cases
  static late final FetchHazardsUseCase _fetchHazardsUseCase;
  static late final PostHazardUseCase _postHazardUseCase;
  static late final ClearHazardCacheUseCase _clearHazardCacheUseCase;
  
  static void setup() {
    // Data sources
    _localDataSource = HazardLocalDataSource();
    _remoteDataSource = HazardRemoteDataSource(
      connectivityChecker: CoreDI.connectivityChecker,
      apiClient: CoreDI.apiClient,
    );

    // Repository
    _repository = HazardRepositoryImpl(
      local: _localDataSource,
      remote: _remoteDataSource,
    );

    // Hazard use cases
    _fetchHazardsUseCase = FetchHazardsUseCase(
      repository: _repository,
    );
    
    _postHazardUseCase = PostHazardUseCase(
      repository: _repository,
    );
    
    _clearHazardCacheUseCase = ClearHazardCacheUseCase(
      repository: _repository,
    );
  }

  // Getters for dependencies
  static HazardLocalDataSource get localDataSource => _localDataSource;
  static HazardRemoteDataSource get remoteDataSource => _remoteDataSource;
  static HazardRepository get repository => _repository;
  
  // Hazard use case getters
  static FetchHazardsUseCase get fetchHazardsUseCase => _fetchHazardsUseCase;
  static PostHazardUseCase get postHazardUseCase => _postHazardUseCase;
  static ClearHazardCacheUseCase get clearHazardCacheUseCase => _clearHazardCacheUseCase;
}