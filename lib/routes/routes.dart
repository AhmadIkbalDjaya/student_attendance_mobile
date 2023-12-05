import 'package:flutter/material.dart';
import 'package:student_attendance/pages/admin/about_us/about_us.dart';
import 'package:student_attendance/pages/admin/about_us/create_about_us.dart';
import 'package:student_attendance/pages/admin/about_us/detail_about_us.dart';
import 'package:student_attendance/pages/admin/about_us/edit_about_us.dart';
import 'package:student_attendance/pages/admin/admin_change_password.dart';
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
import 'package:student_attendance/pages/admin/student/student_claass.dart';
import 'package:student_attendance/pages/admin/teacher/create_teacher.dart';
import 'package:student_attendance/pages/admin/teacher/detail_teacher.dart';
import 'package:student_attendance/pages/admin/teacher/edit_teacher.dart';
import 'package:student_attendance/pages/admin/teacher/set_pass_teacher.dart';
import 'package:student_attendance/pages/admin/teacher/teacher.dart';
import 'package:student_attendance/pages/login.dart';
import 'package:student_attendance/pages/admin/admin_home.dart';
import 'package:student_attendance/pages/error/not_found.dart';
import 'package:student_attendance/pages/splash_screen.dart';
import 'package:student_attendance/pages/teacher/attendance/edit_attendance.dart';
import 'package:student_attendance/pages/teacher/attendance/student_attendance.dart';
import 'package:student_attendance/pages/teacher/attendance/Claass.dart';
import 'package:student_attendance/pages/teacher/attendance/create_attendance.dart';
import 'package:student_attendance/pages/teacher/attendance/course_attendance.dart';
import 'package:student_attendance/pages/teacher/profil/about_us.dart';
import 'package:student_attendance/pages/teacher/profil/account.dart';
import 'package:student_attendance/pages/teacher/profil/change_password.dart';
import 'package:student_attendance/pages/teacher/profil/profil.dart';
import 'package:student_attendance/pages/teacher/profil/user_guide.dart';
import 'package:student_attendance/pages/teacher/recap/course_recap.dart';
import 'package:student_attendance/pages/teacher/recap/recap_claass_list.dart';
import 'package:student_attendance/pages/teacher/teacher.dart';

class MyRoute {
  Route onRoute(RouteSettings settings) {
    final arguments = settings.arguments;
    switch (settings.name) {
      case "/":
        return MaterialPageRoute(
          builder: (context) => LoginPage(),
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
      case "/admin/changePass":
        return MaterialPageRoute(
          builder: (context) => AdminChangePassPage(),
        );

      case "/admin/claass":
        return MaterialPageRoute(
          builder: (context) => const AdminClaassPage(),
        );
      case "/admin/claass/create":
        return MaterialPageRoute(
          builder: (context) => AdminCreateClaassPage(),
        );
      case "/admin/claass/edit":
        if (arguments != null && arguments is Map<String, dynamic>) {
          final claassId = arguments['claassId'] as int;
          return MaterialPageRoute(
            builder: (context) => AdminEditClaassPage(claassId: claassId),
          );
        } else {
          return MaterialPageRoute(
            builder: (context) => const NotFoundPage(),
          );
        }

      case "/admin/course":
        return MaterialPageRoute(
          builder: (context) => const AdminCoursePage(),
        );
      case "/admin/course/create":
        return MaterialPageRoute(
          builder: (context) => AdminCreateCoursePage(),
        );
      case "/admin/course/detail":
        if (arguments != null && arguments is Map<String, dynamic>) {
          final int courseId = arguments['courseId'] as int;
          return MaterialPageRoute(
            builder: (context) => AdminDetailCoursePage(courseId: courseId),
          );
        } else {
          return MaterialPageRoute(
            builder: (context) => const NotFoundPage(),
          );
        }
      case "/admin/course/edit":
        if (arguments != null && arguments is Map<String, dynamic>) {
          final int courseId = arguments['courseId'] as int;
          return MaterialPageRoute(
            builder: (context) => AdminEditCoursePage(courseId: courseId),
          );
        } else {
          return MaterialPageRoute(
            builder: (context) => const NotFoundPage(),
          );
        }
      case "/admin/recap":
        return MaterialPageRoute(
          builder: (context) => const AdminRecapPage(),
        );
      case "/admin/recap/course":
        if (arguments != null && arguments is Map<String, dynamic>) {
          final courseId = arguments['courseId'];
          return MaterialPageRoute(
            builder: (context) => AdminRecapCoursePage(courseId: courseId),
          );
        } else {
          return MaterialPageRoute(
            builder: (context) => const NotFoundPage(),
          );
        }
      case "/admin/semester":
        return MaterialPageRoute(
          builder: (context) => AdminSemesterPage(),
        );
      case "/admin/semester/create":
        return MaterialPageRoute(
          builder: (context) => AdminCreateSemesterPage(),
        );
      case "/admin/semester/edit":
        if (arguments != null && arguments is Map<String, dynamic>) {
          final semesterId = arguments['semesterId'] as int;
          return MaterialPageRoute(
            builder: (context) => AdminEditSemesterPage(semesterId: semesterId),
          );
        } else {
          return MaterialPageRoute(
            builder: (context) => const NotFoundPage(),
          );
        }
      case "/admin/student_claass":
        return MaterialPageRoute(
          builder: (context) => const AdminStudentClaassPage(),
        );
      case "/admin/student":
        if (arguments != null && arguments is Map<String, dynamic>) {
          final claassId = arguments['claassId'] as int;
          final claassName = arguments['claassName'];
          return MaterialPageRoute(
            builder: (context) => AdminStudentPage(
              claassId: claassId,
              claassName: claassName,
            ),
          );
        } else {
          return MaterialPageRoute(
            builder: (context) => const NotFoundPage(),
          );
        }
      case "/admin/student/create":
        if (arguments != null && arguments is Map<String, dynamic>) {
          final claassId = arguments['claassId'] as int;
          return MaterialPageRoute(
            builder: (context) => AdminCreateStudentPage(claassId: claassId),
          );
        } else {
          return MaterialPageRoute(
            builder: (context) => const NotFoundPage(),
          );
        }
      case "/admin/student/detail":
        if (arguments != null && arguments is Map<String, dynamic>) {
          final studentId = arguments['studentId'] as int;
          final claassId = arguments['claassId'] as int;
          return MaterialPageRoute(
            builder: (context) => AdminDetailStudentPage(
              claassId: claassId,
              studentId: studentId,
            ),
          );
        } else {
          return MaterialPageRoute(
            builder: (context) => const NotFoundPage(),
          );
        }
      case "/admin/student/edit":
        if (arguments != null && arguments is Map<String, dynamic>) {
          final studentId = arguments['studentId'] as int;
          final claassId = arguments['claassId'] as int;
          return MaterialPageRoute(
            builder: (context) => AdminEditStudentPage(
              claassId: claassId,
              studentId: studentId,
            ),
          );
        } else {
          return MaterialPageRoute(
            builder: (context) => const NotFoundPage(),
          );
        }
      case "/admin/teacher":
        return MaterialPageRoute(
          builder: (context) => const AdminTeacherPage(),
        );
      case "/admin/teacher/create":
        return MaterialPageRoute(
          builder: (context) => AdminCreateTeacherPage(),
        );
      case "/admin/teacher/detail":
        if (arguments != null && arguments is Map<String, dynamic>) {
          final teacherId = arguments['teacherId'] as int;
          return MaterialPageRoute(
            builder: (context) => AdminDetailTeacherPage(
              teacherId: teacherId,
            ),
          );
        } else {
          return MaterialPageRoute(
            builder: (context) => const NotFoundPage(),
          );
        }
      case "/admin/teacher/edit":
        if (arguments != null && arguments is Map<String, dynamic>) {
          final teacherId = arguments['teacherId'] as int;
          return MaterialPageRoute(
            builder: (context) => AdminEditTeacherPage(
              teacherId: teacherId,
            ),
          );
        } else {
          return MaterialPageRoute(
            builder: (context) => const NotFoundPage(),
          );
        }
      case "/admin/teacher/setPass":
        if (arguments != null && arguments is Map<String, dynamic>) {
          final teacherId = arguments['teacherId'] as int;
          return MaterialPageRoute(
            builder: (context) => AdminSetPassTeacherPage(
              teacherId: teacherId,
            ),
          );
        } else {
          return MaterialPageRoute(
            builder: (context) => const NotFoundPage(),
          );
        }
      case "/admin/aboutUs":
        return MaterialPageRoute(
          builder: (context) => const AdminAboutUsPage(),
        );
      case "/admin/aboutUs/create":
        return MaterialPageRoute(
          builder: (context) => AdminCreateAboutUsPage(),
        );
      case "/admin/aboutUs/detail":
        if (arguments != null && arguments is Map<String, dynamic>) {
          final aboutUsId = arguments['aboutUsId'] as int;
          return MaterialPageRoute(
            builder: (context) => AdminDetailAboutUsPage(aboutUsId: aboutUsId),
          );
        } else {
          return MaterialPageRoute(
            builder: (context) => const NotFoundPage(),
          );
        }
      case "/admin/aboutUs/edit":
        if (arguments != null && arguments is Map<String, dynamic>) {
          final aboutUsId = arguments['aboutUsId'] as int;
          return MaterialPageRoute(
            builder: (context) => AdminEditAboutUsPage(
              aboutUsId: aboutUsId,
            ),
          );
        } else {
          return MaterialPageRoute(
            builder: (context) => const NotFoundPage(),
          );
        }

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
        if (arguments != null && arguments is Map<String, dynamic>) {
          final courseId = arguments['courseId'];
          return MaterialPageRoute(
            builder: (context) => CourseAttendancePage(courseId: courseId),
          );
        } else {
          return MaterialPageRoute(
            builder: (context) => const NotFoundPage(),
          );
        }
      case "/teacher/attendance/student_attendance":
        if (arguments != null && arguments is Map<String, dynamic>) {
          final int attendanceId = arguments["attendanceId"];
          final int courseId = arguments["courseId"];
          return MaterialPageRoute(
            builder: (context) => StudentAttendancePage(
              attendanceId: attendanceId,
              courseId: courseId,
            ),
          );
        } else {
          return MaterialPageRoute(
            builder: (context) => const NotFoundPage(),
          );
        }
      case "/teacher/attendance/create":
        if (arguments != null && arguments is Map<String, dynamic>) {
          final courseId = arguments['courseId'];
          return MaterialPageRoute(
            builder: (context) => CreateAttendancePage(courseId: courseId),
          );
        } else {
          return MaterialPageRoute(
            builder: (context) => const NotFoundPage(),
          );
        }
      case "/teacher/attendance/edit":
        if (arguments != null && arguments is Map<String, dynamic>) {
          final courseId = arguments['courseId'];
          final attendanceId = arguments['attendanceId'];
          return MaterialPageRoute(
            builder: (context) => EditAttendancePage(
              courseId: courseId,
              attendanceId: attendanceId,
            ),
          );
        } else {
          return MaterialPageRoute(
            builder: (context) => const NotFoundPage(),
          );
        }
      case "/teacher/recap":
        return MaterialPageRoute(
          builder: (context) => const RecapClaassListPage(),
        );
      case "/teacher/recap/course":
        if (arguments != null && arguments is Map<String, dynamic>) {
          final courseId = arguments['courseId'];
          return MaterialPageRoute(
            builder: (context) => CourseRecapPage(courseId: courseId),
          );
        } else {
          return MaterialPageRoute(
            builder: (context) => const NotFoundPage(),
          );
        }
      case "/profil":
        return MaterialPageRoute(
          builder: (context) => const ProfilPage(),
        );
      case "/profil/account":
        return MaterialPageRoute(
          builder: (context) => AccountPage(),
        );
      case "/profil/changePass":
        return MaterialPageRoute(
          builder: (context) => ChangePasswordPage(),
        );
      case "/profil/userGuide":
        return MaterialPageRoute(
          builder: (context) => const UserGuidePage(),
        );
      case "/profil/aboutUs":
        return MaterialPageRoute(
          builder: (context) => const AboutUsPage(),
        );

      default:
        return MaterialPageRoute(
          builder: (context) => const NotFoundPage(),
        );
    }
  }
}
