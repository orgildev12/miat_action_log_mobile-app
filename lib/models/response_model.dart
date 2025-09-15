class ResponseModel {
  final int hazardId;
  final String currentStatus;
  final int isStarted;
  final String? responseBody;
  final int? isRequestApproved;
  final int isResponseFinished;
  final DateTime? responseFinishedDate;
  final int isCheckingResponse;
  final int isResponseConfirmed;
  final int isResponseDenied;
  final String? reasonToDeny;
  final DateTime dateUpdated;

  ResponseModel({
    required this.hazardId,
    required this.currentStatus,
    required this.isStarted,
    this.responseBody,
    this.isRequestApproved,
    required this.isResponseFinished,
    this.responseFinishedDate,
    required this.isCheckingResponse,
    required this.isResponseConfirmed,
    required this.isResponseDenied,
    this.reasonToDeny,
    required this.dateUpdated
  });
  
  factory ResponseModel.fromJson(Map<String, dynamic> json) {
    return ResponseModel(
      hazardId: json['hazardId'],
      currentStatus: json['currentStatus'],
      isStarted: json['isStarted'],
      responseBody: json['responseBody'],
      isRequestApproved: json['isRequestApproved'],
      isResponseFinished: json['isResponseFinished'],
      responseFinishedDate: json['responseFinishedDate'] != null 
          ? DateTime.parse(json['responseFinishedDate']) 
          : null,
      isCheckingResponse: json['isCheckingResponse'],
      isResponseConfirmed: json['isResponseConfirmed'],
      isResponseDenied: json['isResponseDenied'],
      reasonToDeny: json['reasonToDeny'],
      dateUpdated: DateTime.parse(json['dateUpdated'])
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'hazardId': hazardId,
      'currentStatus': currentStatus,
      'isStarted': isStarted,
      'responseBody': responseBody,
      'isRequestApproved': isRequestApproved,
      'isResponseFinished': isResponseFinished,
      'responseFinishedDate': responseFinishedDate?.toIso8601String(),
      'isCheckingResponse': isCheckingResponse,
      'isResponseConfirmed': isResponseConfirmed,
      'isResponseDenied': isResponseDenied,
      'reasonToDeny': reasonToDeny,
      'dateUpdated': dateUpdated.toIso8601String()
    };
  }
}
