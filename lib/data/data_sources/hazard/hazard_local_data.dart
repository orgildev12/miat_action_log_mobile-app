class HazardLocalDataSource {
  final _storage = FlutterSecureStorage();
  final _key = 'hazards_cache';

  Future<void> saveHazards(List<HazardModel> hazards) async {
    final jsonList = hazards.map((hazard) => hazard.toJson()).toList();
    final jsonString = jsonEncode(jsonList);
    await _storage.write(key: _key, value: jsonString);
  }

  Future<List<HazardModel>> getHazards() async {
    final jsonString = await _storage.read(key: _key);
    if(jsonString != null) {
      final List<dynamic> jsonList = jsonDecode(jsonString);
      return jsonList.map((json) => HazardModel.fromJson(json).toList());
    }
    return [];
  }

  Future<void> clearHazards() async {
    await _storage.delete(key: _key);
  }
}