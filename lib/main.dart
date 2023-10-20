import 'package:flutter/material.dart';
import 'package:student_attendance/routes/routes.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // home: TeacherPage(),
      initialRoute: "/teacher",
      onGenerateRoute: MyRoute().onRoute,
    );
  }
}
