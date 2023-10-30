import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student_attendance/cubit/admin_drawer_bloc.dart';
import 'package:student_attendance/bloc/admin/student/student_bloc.dart';
import 'package:student_attendance/cubit/teacher_tab_bloc.dart';
import 'package:student_attendance/routes/routes.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => TeacherTabBloc(),
        ),
        BlocProvider(
          create: (context) => AdminDrawerBloc(),
        ),
        BlocProvider(
          create: (context) => StudentBloc(),
          // create: (context) => StudentBloc()..add(GetAllStudentEvent()),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: "/admin/student",
        onGenerateRoute: MyRoute().onRoute,
      ),
    );
  }
}
