// I might delete it

extension HazardMapper on HazardModel {
  Hazard toEntity({<Response> responseOfHazard}) {
    return Location(
      hazard_id: hazard_id,
      isStarted: isStarted,
      responseBody: responseBody,
      isRequestApproved: isRequestApproved,
      isResponseConfirmed: isResponseConfirmed,
      dateUpdated: dateUpdated
    );
  }
}