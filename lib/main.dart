import 'package:flutter/material.dart';
import 'package:student_attendance/pages/admin/claass/Claass.dart';
import 'package:student_attendance/pages/admin/claass/CreateClaass.dart';
import 'package:student_attendance/pages/admin/claass/EditClaass.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: EditClaassPage(),
    );
  }
}
