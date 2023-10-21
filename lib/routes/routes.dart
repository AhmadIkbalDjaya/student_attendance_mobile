import 'package:flutter/material.dart';
import 'package:student_attendance/pages/admin/claass/claass.dart';
import 'package:student_attendance/pages/admin/claass/create_claass.dart';
import 'package:student_attendance/pages/admin/claass/edit_claass.dart';
import 'package:student_attendance/pages/admin/course/course.dart';
import 'package:student_attendance/pages/admin/course/create_course.dart';
import 'package:student_attendance/pages/admin/course/detail_course.dart';
import 'package:student_attendance/pages/admin/course/edit_course.dart';
import 'package:student_attendance/pages/admin/recap/recap.dart';
import 'package:student_attendance/pages/admin/recap/recap_course.dart';
import 'package:student_attendance/pages/admin/semester/create_semester.dart';
import 'package:student_attendance/pages/admin/semester/edit_semester.dart';
import 'package:student_attendance/pages/admin/semester/semester.dart';
import 'package:student_attendance/pages/admin/student/create_student.dart';
import 'package:student_attendance/pages/admin/student/detail_student.dart';
import 'package:student_attendance/pages/admin/student/edit_student.dart';
import 'package:student_attendance/pages/admin/student/student.dart';
import 'package:student_attendance/pages/admin/teacher/create_teacher.dart';
import 'package:student_attendance/pages/admin/teacher/detail_teacher.dart';
import 'package:student_attendance/pages/admin/teacher/edit_teacher.dart';
import 'package:student_attendance/pages/admin/teacher/teacher.dart';
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

      // Admin Page
      case "/admin":
        return MaterialPageRoute(
          builder: (context) => const AdminHomePage(),
        );

      case "/admin/claass":
        return MaterialPageRoute(
          builder: (context) => const AdminClaassPage(),
        );
      case "/admin/claass/create":
        return MaterialPageRoute(
          builder: (context) => const AdminCreateClaassPage(),
        );
      case "/admin/claass/edit":
        return MaterialPageRoute(
          builder: (context) => const AdminEditClaassPage(),
        );

      case "/admin/course":
        return MaterialPageRoute(
          builder: (context) => const AdminCoursePage(),
        );
      case "/admin/course/create":
        return MaterialPageRoute(
          builder: (context) => const AdminCreateCoursePage(),
        );
      case "/admin/course/detail":
        return MaterialPageRoute(
          builder: (context) => const AdminDetailCoursePage(),
        );
      case "/admin/course/edit":
        return MaterialPageRoute(
          builder: (context) => const AdminEditCoursePage(),
        );

      case "/admin/recap":
        return MaterialPageRoute(
          builder: (context) => const AdminRecapPage(),
        );
      case "/admin/recap/course":
        return MaterialPageRoute(
          builder: (context) => const AdminRecapCoursePage(),
        );

      case "/admin/semester":
        return MaterialPageRoute(
          builder: (context) => const AdminSemesterPage(),
        );
      case "/admin/semester/create":
        return MaterialPageRoute(
          builder: (context) => const AdminCreateSemesterPage(),
        );
      case "/admin/semester/edit":
        return MaterialPageRoute(
          builder: (context) => const AdminEditSemesterPage(),
        );

      case "/admin/student":
        return MaterialPageRoute(
          builder: (context) => const AdminStudentPage(),
        );
      case "/admin/student/create":
        return MaterialPageRoute(
          builder: (context) => const AdminCreateStudentPage(),
        );
      case "/admin/student/detail":
        return MaterialPageRoute(
          builder: (context) => const AdminDetailStudentPage(),
        );
      case "/admin/student/edit":
        return MaterialPageRoute(
          builder: (context) => const AdminEditStudentPage(),
        );

      case "/admin/teacher":
        return MaterialPageRoute(
          builder: (context) => const AdminTeacherPage(),
        );
      case "/admin/teacher/create":
        return MaterialPageRoute(
          builder: (context) => const AdminCreateTeacherPage(),
        );
      case "/admin/teacher/detail":
        return MaterialPageRoute(
          builder: (context) => const AdminDetailTeacherPage(),
        );
      case "/admin/teacher/edit":
        return MaterialPageRoute(
          builder: (context) => const AdminEditTeacherPage(),
        );

      // Teacher Page
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
