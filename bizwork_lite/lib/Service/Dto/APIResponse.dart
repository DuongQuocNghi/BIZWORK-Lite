class APIResponse<T> {
  int returnCode;
  String returnMessage;
  dynamic data;

  APIResponse({this.returnCode, this.returnMessage, this.data});

  factory APIResponse.fromJson(Map<String, dynamic> json) {
    return APIResponse(
        returnCode: json['ReturnCode'] as int,
        returnMessage: json['ReturnMessage'] as String,
        data: json['Data'] as dynamic
    );
  }
}
