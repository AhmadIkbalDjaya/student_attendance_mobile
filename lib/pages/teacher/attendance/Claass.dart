import 'package:flutter/material.dart';
import 'package:student_attendance/bloc/teacher/teacher_course/teacher_course_bloc.dart';
import 'package:student_attendance/components/center_loading.dart';
import 'package:student_attendance/components/claass_list.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ClaassPage extends StatelessWidget {
  const ClaassPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.only(top: 35, bottom: 15),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFF696CFF),
                  Color(0xFFACAEFE),
                ],
                begin: Alignment(0, 0.3),
                end: Alignment.bottomCenter,
                // end: Alignment(0, -1),
                // begin: Alignment.bottomCenter,
              ),
            ),
            child: const Column(
              children: [
                Text(
                  "KELAS",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "Pilih salah satu kelas di bawah",
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 15,
                horizontal: 20,
              ),
              child: BlocBuilder<TeacherCourseBloc, TeacherCourseState>(
                builder: (conteximpot, state) {
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
