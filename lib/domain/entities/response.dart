class Response {
  final int hazardId;
  final int isStarted;
  final String? responseBody;
  final int? isRequestApproved;
  final int isResponseConfirmed;
  final DateTime dateUpdated;

  Response({
    required this.hazardId,
    required this.isStarted,
    this.responseBody,
    this.isRequestApproved,
    required this.isResponseConfirmed,
    required this.dateUpdated
  });
}