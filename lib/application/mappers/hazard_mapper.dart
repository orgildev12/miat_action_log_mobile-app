extension HazardMapper on HazardModel {
  Hazard toEntity({<Response> responseOfHazard}) {


    // to do: 
    //  connect responseOfHazard
    //  take typeName from HazardTypes
    //  take locationName from Locations
    return Hazard(
      id: id,
      code: code,
      statusEn: statusEn,
      statusMn: statusMn,
      userId: userId,
      typeNameEn: typeNameEn,
      typeNameMn: typeNameMn,
      locationNameEn: locationNameEn,
      locationNameEn: locationNameEn,
      description: description,
      solution: solution,
      isPrivate: isPrivate,
      dateCreated: dateCreated,
      responseOfHazard: responseOfHazard,
    );
  }
}