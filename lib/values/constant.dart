import 'dart:io';

import 'package:student_attendance/values/auth.dart';

// const String apiUrl = "https://mobile.attendance.sman17gowa.com/api";

// Map<String, String> apiHeaderWithToken = {
//   HttpHeaders.acceptHeader: "application/json",
//   HttpHeaders.authorizationHeader: "Bearer ${Auth.token}",
// };

class ApiConfig {
  static String url = "https://mobile.attendance.sman17gowa.com/api";
  static Map<String, String> headerWithToken = {
    HttpHeaders.acceptHeader: "application/json",
    HttpHeaders.authorizationHeader:
        Auth.token != null ? "Bearer ${Auth.token}" : "Bearer ",
  };

  static void setHeader({
    String? token,
  }) {
    ApiConfig.headerWithToken = {
      HttpHeaders.acceptHeader: "application/json",
      HttpHeaders.authorizationHeader: "Bearer $token",
    };
  }
}
