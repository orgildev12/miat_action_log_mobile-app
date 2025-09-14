class HazardTypeLocalDataSource {
  final _storage = FlutterSecureStorage();
  final _key = 'hazard_types_cache';

  Future<void> saveHazardTypes(List<HazardTypeModel> hazardTypes) async {
    final jsonList = hazardTypes.map((hazardType) => hazardType.toJson()).toList();
    final jsonString = jsonEncode(jsonList);
    await _storage.write(key: _key, value: jsonString);
  }

  Future<List<HazardTypeModel>> getHazardTypes() async {
    final jsonString = await _storage.read(key: _key);
    if(jsonString != null) {
      final List<dynamic> jsonList = jsonDecode(jsonString);
      return jsonList.map((json) => HazardTypeModel.fromJson(json).toList());
    }
    return [];
  }

  Future<void> clearHazardTypes() async {
    await _storage.delete(key: _key);
  }
}