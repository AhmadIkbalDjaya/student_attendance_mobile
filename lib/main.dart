import 'package:flutter/material.dart';
import 'package:student_attendance/pages/admin/recap/RecapCourse.dart';
import 'package:student_attendance/pages/teacher/Teacher.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: TeacherPage(),
    );
  }
}
