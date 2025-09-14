extension HazardTypeMapper on HazardTypeModel {
  HazardType toEntity() {
    return HazardType(
      id: id,
      shortCode: shortCode;
      nameEn: nameEn,
      nameMn: nameMn,
    )
  }
}