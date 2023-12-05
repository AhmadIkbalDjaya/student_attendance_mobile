import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student_attendance/bloc/admin/about_us/about_us_bloc.dart';
import 'package:student_attendance/bloc/admin/admin_home/admin_home_bloc.dart';
import 'package:student_attendance/bloc/admin/admin_recap/admin_recap_bloc.dart';
import 'package:student_attendance/bloc/admin/claass/claass_bloc.dart';
import 'package:student_attendance/bloc/admin/course/course_bloc.dart';
import 'package:student_attendance/bloc/admin/semester/semester_bloc.dart';
import 'package:student_attendance/bloc/admin/teacher/teacher_bloc.dart';
import 'package:student_attendance/bloc/auth/auth_bloc.dart';
import 'package:student_attendance/bloc/login/login_bloc.dart';
import 'package:student_attendance/bloc/teacher/attendance/attendance_bloc.dart';
import 'package:student_attendance/bloc/course_recap/course_recap_bloc.dart';
import 'package:student_attendance/bloc/teacher/create_attendance/create_attendance_bloc.dart';
import 'package:student_attendance/bloc/teacher/edit_attendance/edit_attendance_bloc.dart';
import 'package:student_attendance/bloc/teacher/profil/account_setting/account_setting_bloc.dart';
import 'package:student_attendance/bloc/teacher/student_attendance/student_attendance_bloc.dart';
import 'package:student_attendance/bloc/teacher/teacher_course/teacher_course_bloc.dart';
import 'package:student_attendance/bloc/teacher/teacher_home/teacher_home_bloc.dart';
import 'package:student_attendance/bloc/teacher/update_student_attendance/update_student_attendance_bloc.dart';
import 'package:student_attendance/cubit/admin_drawer_bloc.dart';
import 'package:student_attendance/bloc/admin/student/student_bloc.dart';
import 'package:student_attendance/cubit/teacher_tab_bloc.dart';
import 'package:student_attendance/pages/admin/admin_home.dart';
import 'package:student_attendance/pages/login.dart';
import 'package:student_attendance/pages/splash_screen.dart';
import 'package:student_attendance/pages/teacher/teacher.dart';
import 'package:student_attendance/routes/routes.dart';
import 'package:student_attendance/values/theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => AuthBloc()..add(CheckAuth()),
          ),
          BlocProvider(
            create: (context) => LoginBloc(),
          ),
          BlocProvider(
            create: (context) => TeacherTabBloc(),
          ),
          BlocProvider(
            create: (context) => AdminDrawerBloc(),
          ),
          BlocProvider(
            create: (context) => AdminHomeBloc(),
          ),
          BlocProvider(
            create: (context) => StudentBloc(),
          ),
          BlocProvider(
            create: (context) => TeacherBloc(),
          ),
          BlocProvider(
            create: (context) => ClaassBloc(),
          ),
          BlocProvider(
            create: (context) => SemesterBloc(),
          ),
          BlocProvider(
            create: (context) => CourseBloc(),
          ),
          BlocProvider(
            create: (context) => AdminRecapBloc(),
          ),
          BlocProvider(
            create: (context) => AboutUsBloc(),
          ),
          BlocProvider(
            create: (context) => TeacherHomeBloc(),
          ),
          BlocProvider(
            create: (context) => TeacherCourseBloc(),
          ),
          BlocProvider(
            create: (context) => AttendanceBloc(),
          ),
          BlocProvider(
            create: (context) => CreateAttendanceBloc(),
          ),
          BlocProvider(
            create: (context) => EditAttendanceBloc(),
          ),
          BlocProvider(
            create: (context) => StudentAttendanceBloc(),
          ),
          BlocProvider(
            create: (context) => UpdateStudentAttendanceBloc(),
          ),
          BlocProvider(
            create: (context) => CourseRecapBloc(),
          ),
          BlocProvider(
            create: (context) => AccountSettingBloc(),
          ),
        ],
        child: MaterialApp(
          theme: ThemeData(
            scaffoldBackgroundColor: const Color(0xFFF9F9F9),
            dataTableTheme: CustomTheme.customDataTableTheme,
            elevatedButtonTheme: CustomTheme.elevatedButtonThemeData,
            inputDecorationTheme: CustomTheme.inputDecorationTheme,
          ),
          debugShowCheckedModeBanner: false,
          // initialRoute: initialRoute,
          home: BlocBuilder<AuthBloc, AuthState>(
            builder: (context, state) {
              if (state is UserSignIn) {
                if (state.login.role == "admin") {
                  return const AdminHomePage();
                } else {
                  context
                      .read<TeacherCourseBloc>()
                      .add(GetTeacherCourseEvent());
                  return const TeacherPage();
                }
              } else if (state is UserSignOut) {
                return LoginPage();
              }
              return const SplashScreen();
            },
          ),
          onGenerateRoute: MyRoute().onRoute,
        ));
  }
}
