class HazardTypeRepositoryImpl implements HazardTypeRepository {
  final HazardTypeLocalDataSource local;
  final HazardTypeRemoteDataSource remote;

  HazardTypeRepositoryImpl({
    required this.local,
    required this.remote
  });

  Future<List<HazardType>> fetchHazardTypes() async {
    try{
      final List<HazardTypeModel> localModels = await local.getHazardTypes();
      if(hazardModels.isNotEmpty){
        final List<Location> entities = [];
        for(var model in localModels) {
          entities.add(model.toEntity())
        }
        return entities;
      }

      final HazardTypeModel remoteModel = await remote.fetchHazardTypes();
      await local.saveHazardTypes([remoteModel]);
      return [remoteModel.toEntity()];
    } 
    catch(e){
      rethrow;
    }
  } 
}