import 'package:action_log_app/application/use_cases/hazard_use_cases/clear_hazard_image_cache.dart';
import 'package:action_log_app/application/use_cases/hazard_use_cases/fetch_hazard_image_use_case.dart';
import 'package:action_log_app/application/use_cases/hazard_use_cases/fetch_hazards_use_case.dart';
import 'package:action_log_app/application/use_cases/hazard_use_cases/post_hazard_use_case.dart';
import 'package:action_log_app/application/use_cases/hazard_use_cases/clear_hazard_cache_use_case.dart';
import 'package:action_log_app/core/di/core_di.dart';
import 'package:action_log_app/core/di/features/user_di.dart';
import 'package:action_log_app/data/data_sources/hazard/hazard_local_data.dart';
import 'package:action_log_app/data/data_sources/hazard/hazard_remote_data.dart';
import 'package:action_log_app/domain/repositories/hazard_repository.dart';
import 'package:action_log_app/data/repositories/hazard_repository_impl.dart';
import 'package:action_log_app/domain/repositories/user_repository.dart';

class HazardDI {
  static late final HazardLocalDataSource _localDataSource;
  static late final HazardRemoteDataSource _remoteDataSource;
  static late final HazardRepository _repository;
  static late final UserRepository _userRepository;
  
  // Hazard use cases
  static late final FetchHazardsUseCase _fetchHazardsUseCase;
  static late final PostHazardUseCase _postHazardUseCase;
  static late final ClearHazardCacheUseCase _clearHazardCacheUseCase;
  static late final FetchHazardImageUseCase _fetchHazardImageUseCase;
  static late final ClearHazardImageCache _clearHazardImageCache;

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

  // Initialize _userRepository from UserDI
  _userRepository = UserDI.repository;

  // Hazard use cases
  _fetchHazardsUseCase = FetchHazardsUseCase(
    repository: _repository,
    userRepository: _userRepository,
    userLocalDataSource: UserDI.localDataSource
  );
  _fetchHazardImageUseCase = FetchHazardImageUseCase(
    repository: _repository,
    userRepository: _userRepository,
    userLocalDataSource: UserDI.localDataSource,
  );
  
  _postHazardUseCase = PostHazardUseCase(
    repository: _repository,
    userLocalDataSource: UserDI.localDataSource,
  );
  
  _clearHazardCacheUseCase = ClearHazardCacheUseCase(
    repository: _repository,
  );

  _clearHazardImageCache = ClearHazardImageCache(
    hazardRepository: _repository,
  );
}

  // Getters for dependencies
  static HazardLocalDataSource get localDataSource => _localDataSource;
  static HazardRemoteDataSource get remoteDataSource => _remoteDataSource;
  static HazardRepository get repository => _repository;
  static UserRepository get userRepository => _userRepository;
  
  // Hazard use case getters
  static FetchHazardsUseCase get fetchHazardsUseCase => _fetchHazardsUseCase;
  static FetchHazardImageUseCase get fetchHazardImageUseCase => _fetchHazardImageUseCase;
  static PostHazardUseCase get postHazardUseCase => _postHazardUseCase;
  static ClearHazardCacheUseCase get clearHazardCacheUseCase => _clearHazardCacheUseCase;
  static ClearHazardImageCache get clearHazardImageCacheUseCase => _clearHazardImageCache;
}