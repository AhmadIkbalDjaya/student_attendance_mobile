import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student_attendance/bloc/admin/student/student_bloc.dart';

class DetailIB extends StatelessWidget {
  const DetailIB({super.key, required this.route, this.id = 0});
  final String route;
  final int id;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        Navigator.pushNamed(context, route, arguments: {'id': id});
        context.read<StudentBloc>().add(GetDetailStudentEvent(studentId: id));
      },
      icon: const Icon(
        Icons.remove_red_eye,
        color: Colors.blue,
      ),
    );
  }
}
