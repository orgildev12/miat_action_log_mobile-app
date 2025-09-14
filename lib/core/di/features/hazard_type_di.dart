class HazardTypeDI {
  static late final HazardTypeLocalDataSource _localDataSource;
  static late final HazardTypeRemoteDataSource _remoteDataSource;
  static late final HazardTypeRepository _repository;
  static late final FetchHazardTypesUseCase _fetchHazardTypesUseCase;

  static void setup() {
    _localDataSource = HazardTypeLocalDataSource();
    _remoteDataSource = HazardTypeRemoteDataSource(
      connectivity_checker: CoreDI.connectivityChecker,
      apiClient: CoreDI.apiClient
    );

    _repository = HazardTypeRepositoryImpl(
      local: _localDataSource,
      remote: _remoteDataSource
    );

    _fetchHazardTypesUseCase = FetchHazardTypeUseCase(
      repository: _repository
    );

    _clearHazardTypesCacheUseCase = ClearHazardTypesCacheUseCase(
      repository: _repository
    );
  }

  static HazardTypesLocalDataSource get localDataSource => _localDataSource;
  static HazardTypeRemoteDataSource get remoteDataSource => _remoteDataSource;
  static HazardTypeRepository get repository => _repository;
  static FetchHazardTypesUseCase get fetchHazardTypesUseCase => _fetchHazardTypesUseCase;
  static ClearHazardTypesCacheUseCase get clearHazardFetchCacheUseCase => _clearHazardFetchCacheUseCase;
}