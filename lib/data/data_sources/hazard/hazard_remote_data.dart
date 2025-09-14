class HazardRemoteDataSource {
  final ConnectivityChecker connectivityChecker;
  final ApiClient apiClient;

  HazardRemoteDataSource({
    required this.connectivityChecker,
    required this.apiClient
  });

  Future<HazardModel> fetchHazard() async {
    if(!await connectivityChecker.isConnected) {
      throw Exception('No internet connection');
    }
    final result = await apiClient.get('/hazard');
    return HazardModel.fromJson(result);
  }
}