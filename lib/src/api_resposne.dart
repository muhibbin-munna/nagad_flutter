import 'dart:convert';

class ApiResponse {
  String callBackUrl;
  String status;

  ApiResponse({
    required this.callBackUrl,
    required this.status,
  });

  factory ApiResponse.fromJson(String json) {
    Map<String, dynamic> decodedJson = jsonDecode(json);
    return ApiResponse(
      callBackUrl: decodedJson['callBackUrl'],
      status: decodedJson['status'],
    );
  }
}