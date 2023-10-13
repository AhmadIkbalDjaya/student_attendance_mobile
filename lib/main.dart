import 'package:flutter/material.dart';
import 'package:student_attendance/pages/admin/course/CreateCourse.dart';
import 'package:student_attendance/pages/admin/course/DetailCourse.dart';
import 'package:student_attendance/pages/admin/course/EditCourse.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: EditCoursePage(),
    );
  }
}
