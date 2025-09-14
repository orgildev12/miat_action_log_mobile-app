class HazardDI {
  static late final HazardLocalDataSource _localDataSource;
  static late final HazardRemoteDataSource _remoteDataSource;
  static late final HazardRepository _repository;
  static late final FetchHazardsUseCase _fetchHazardsUseCase;
  static late final PostHazardUseCase _postHazardUseCase;
  static late final ClearHazardCacheUseCase _clearHazardCacheUseCase;

  static void setup() {
    _localDataSource = HazardLocalDataSource();
    _remoteDataSource = HazardRemoteDataSource(
      connectivity_checker: CoreDI.connectivityChecker,
      apiClient: CoreDI.apiClient
    );

    _repository = HazardRepositoryImpl(
      local: _localDataSource,
      remote: _remoteDataSource
    )

    _fetchHazardsUseCase = FetchHazardUseCase(
      repository: _repository
    )

    _postHazardUseCase = PostHazardUseCase(
      repository: _repository
    );
    
    _clearHazardCacheUseCase = ClearHazardCacheUseCase(
      repository: _repository
    );
  }

  static HazardsLocalDataSource get localDataSource => _localDataSource;
  static HazardRemoteDataSource get remoteDataSource => _remoteDataSource;
  static HazardRepository get repository => _repository;
  static FetchHazardsUseCase get fetchHazardsUseCase => _fetchHazardsUseCase;
  static PostHazardUseCase get postHazardUseCase => _postHazardUseCase;
  static ClearHazardCacheUseCase get clearHazardCacheUseCase => _clearHazardCacheUseCase;
}