import 'dart:io';

import 'package:student_attendance/values/auth.dart';

const String apiUrl = "https://mobile.attendance.sman17gowa.com/api";

Map<String, String> apiHeaderWithToken = {
  HttpHeaders.acceptHeader: "application/json",
  HttpHeaders.authorizationHeader: "Bearer ${Auth.token}",
};
