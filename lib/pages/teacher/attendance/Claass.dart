import 'package:flutter/material.dart';
import 'package:student_attendance/bloc/teacher/teacher_course/teacher_course_bloc.dart';
import 'package:student_attendance/components/center_loading.dart';
import 'package:student_attendance/components/claass_list.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ClaassPage extends StatelessWidget {
  const ClaassPage({super.key});

  @override
  Widget build(BuildContext context) {
    TeacherCourseBloc teacherCourseBloc = context.read<TeacherCourseBloc>();
    // teacherCourseBloc.add(GetTeacherCourseEvent());
    return Scaffold(
      body: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 25),
            decoration: const BoxDecoration(
              color: Color(0xFFD9D9D9),
            ),
            child: const Column(
              children: [
                Text(
                  "KELAS",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text("Pilih salah satu kelas di bawah"),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 15,
                horizontal: 20,
              ),
              child: BlocConsumer<TeacherCourseBloc, TeacherCourseState>(
                listener: (context, state) {},
                builder: (context, state) {
                  if (state is TeacherCourseGetLoading) {
                    return const CenterLoading();
                  }
                  if (state is TeacherCourseGetSuccess) {
                    return ListView(
                      children: List<ClaassList>.generate(
                          state.teacherCourses.length, (index) {
                        return ClaassList(
                          teacherCourse: state.teacherCourses[index],
                        );
                      }),
                    );
                  }
                  return Container();
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
