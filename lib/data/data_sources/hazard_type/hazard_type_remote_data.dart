class HazardTypeRemoteDataSource {
  final ConnectivityChecker connectivityChecker;
  final ApiClient apiClient;

  HazardTypeRemoteDataSource({
    required this.connectivityChecker,
    required this.apiClient
  });

  Future<HazardTypeModel> fetchHazardType() async {
    if(!await connectivityChecker.isConnected) {
      throw Exception('No internet connection');
    }
    final result = await apiClient.get('/hazardType');
    return HazardTypeModel.fromJson(result);
  }
}