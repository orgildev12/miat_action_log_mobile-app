class HazardImageModel {
  final int id;
  final int hazardId;
  String imageData;

  HazardImageModel({
    required this.id,
    required this.hazardId,
    required this.imageData,
  });

  factory HazardImageModel.fromJson(Map<String, dynamic> json) {
    return HazardImageModel(
      id: int.parse(json['id'].toString()),
      hazardId: json['hazard_id'] ?? '',
      imageData: json['image_data'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'hazard_id': hazardId,
      'image_data': imageData
    };
  }
}