import 'package:flutter/material.dart';
import 'package:student_attendance/pages/login.dart';
import 'package:student_attendance/pages/admin/admin_home.dart';
import 'package:student_attendance/pages/error/not_found.dart';
import 'package:student_attendance/pages/splash_screen.dart';
import 'package:student_attendance/pages/teacher/attendance/attendance.dart';
import 'package:student_attendance/pages/teacher/attendance/Claass.dart';
import 'package:student_attendance/pages/teacher/attendance/create_attendance.dart';
import 'package:student_attendance/pages/teacher/attendance/course_attendance.dart';
import 'package:student_attendance/pages/teacher/recap/course_recap.dart';
import 'package:student_attendance/pages/teacher/recap/recap_claass_list.dart';
import 'package:student_attendance/pages/teacher/teacher.dart';

class MyRoute {
  Route onRoute(RouteSettings settings) {
    switch (settings.name) {
      case "/":
        return MaterialPageRoute(
          builder: (context) => const LoginPage(),
        );
      case "/splash_screen":
        return MaterialPageRoute(
          builder: (context) => const SplashScreen(),
        );
      case "/admin":
        return MaterialPageRoute(
          builder: (context) => const AdminHomePage(),
        );
      case "/teacher":
        return MaterialPageRoute(
          builder: (context) => const TeacherPage(),
        );
      case "/teacher/attendance":
        return MaterialPageRoute(
          builder: (context) => const ClaassPage(),
        );
      case "/teacher/attendance/course":
        return MaterialPageRoute(
          builder: (context) => const CourseAttendancePage(),
        );
      case "/teacher/attendance/attend":
        return MaterialPageRoute(
          builder: (context) => const AttendancePage(),
        );
      case "/teacher/attendance/create":
        return MaterialPageRoute(
          builder: (context) => const CreateAttendancePage(),
        );
      case "/teacher/recap":
        return MaterialPageRoute(
          builder: (context) => const RecapClaassListPage(),
        );
      case "/teacher/recap/course":
        return MaterialPageRoute(
          builder: (context) => const CourseRecapPage(),
        );
      default:
        return MaterialPageRoute(
          builder: (context) => const NotFoundPage(),
        );
    }
  }
}
