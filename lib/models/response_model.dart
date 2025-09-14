class ResponseModel {
  final int hazardId;
  final String currentStatus;
  final int isStarted;
  final String responseBody;
  final int isRequestApproved;
  final int isResponseFinished;
  final Date responseFinishedDate;
  final int isCheckingResponse;
  final int isResponseConfirmed;
  final int isResponseDenied;
  final String reasonToDeny;
  final Date dateUpdated;

  ResponseModel({
    required this.hazardId,
    required this.currentStatus,
    required this.isStarted,
    required this.responseBody,
    required this.isRequestApproved,
    required this.isResponseFinished,
    required this.responseFinishedDate,
    required this.isCheckingResponse,
    required this.isResponseConfirmed,
    required this.isResponseDenied;
    required this.reasonToDeny,
    required this.dateUpdated
  });
  
  factory ResponseModel.fromJson(Map<String, dynamic> json) {
    return ResponseModel(
      hazardId : json['hazard_id'],
      currentStatus : json['current_status'],
      isStarted : json['is_started'],
      responseBody : json['response_body'],
      isRequestApproved : json['is_request_approved'],
      isResponseFinished : json['is_response_finished'],
      responseFinishedDate : json['response_finished_date'],
      isCheckingResponse : json['is_checking_response'],
      isResponseConfirmed : json['is_response_confirmed'],
      isResponseDenied : json['is_response_denied'],
      reasonToDeny : json['reason_to_deny'],
      dateUpdated : json['date_updated']
    )
  }

  Map<String, dynamic> toJson() {
    return {
      'hazard_id' : hazardId,
      'current_status' : currentStatus,
      'is_started' : isStarted,
      'response_body' : responseBody,
      'is_request_approved' : isRequestApproved,
      'is_response_finished' : isResponseFinished,
      'response_finished_date' : responseFinishedDate,
      'is_checking_response' : isCheckingResponse,
      'is_response_confirmed' : isResponseConfirmed,
      'is_response_denied' : isResponseDenied,
      'reason_to_deny' : reasonToDeny,
      'date_updated' : dateUpdated
    }
  }
}
