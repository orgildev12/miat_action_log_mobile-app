class FetchHazardTypesUseCase {
  final HazardTypeRepository repository;
  FetchHazardTypesUseCase({required this.repository});

  Future<List<HazardType>> call() async {
    try {
      final hazardTypes = await repository.fetchHazardTypes();
      return hazardTypes;
    } catch (e){
      rethrow;
    }
  }
}