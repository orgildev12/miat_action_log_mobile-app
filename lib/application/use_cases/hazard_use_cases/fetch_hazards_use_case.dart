class FetchHazardsUseCase {
  final HazardRepository repository;
  FetchHazardUseCase({required this.repository});

  Future<List<Hazard>> call() async {
    try {
      final hazards = await repository.fetchhazards();
      return hazards;
    } catch (e) {
      rethrow;
    }
  }
}