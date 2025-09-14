class HazardRepositoryImpl implements HazardRepository {
  final HazardLocalDataSource local;
  final HazardRemoteDataSource remote;

  HazardRepositoryImpl({
    required this.local,
    required this.remote
  });

  Future<List<Hazard>> fetchHazards() async {
    try{
      final List<HazardModel> localModels = await local.getHazards();
      if(hazardModels.isNotEmpty){
        final List<Hazard> entities = [];
        for(var model in localModels) {
          entities.add(model.toEntity())
        }
        return entities;
      }

      final HazardModel remoteModel = await remote.fetchHazards();
      await local.saveHazards([remoteModel]);
      return [remoteModel.toEntity()];
    } 
    catch(e){
      rethrow;
    }
  } 
}