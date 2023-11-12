import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student_attendance/bloc/teacher/attendance/attendance_bloc.dart';
import 'package:student_attendance/components/center_loading.dart';
import 'package:student_attendance/components/teacher/attendance_box.dart';
import 'package:student_attendance/cubit/teacher_tab_bloc.dart';
import 'package:student_attendance/components/my_bottom_nav_bar.dart';
import 'package:student_attendance/models/teacher/course_attendance.dart';

class CourseAttendancePage extends StatelessWidget {
  const CourseAttendancePage({super.key, required this.courseId});
  final int courseId;

  @override
  Widget build(BuildContext context) {
    TeacherTabBloc teacherTab = context.read<TeacherTabBloc>();
    AttendanceBloc attendanceBloc = context.read<AttendanceBloc>();
    attendanceBloc.add(GetCourseAttendanceEvent(courseId: courseId));
    return Scaffold(
      body: Column(
        children: [
          Container(
            decoration: const BoxDecoration(
              color: Color(0xFFD9D9D9),
            ),
            padding:
                const EdgeInsets.only(top: 0, bottom: 10, right: 10, left: 10),
            width: double.infinity,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Column(
                    children: [
                      const Text(
                        "KELAS",
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      BlocBuilder<AttendanceBloc, AttendanceState>(
                        builder: (context, state) {
                          if (state is AttendanceGetLoading) {
                            return const CenterLoading();
                          }
                          if (state is AttendanceGetSuccess) {
                            Course course = state.courseAttendance.course;
                            return SizedBox(
                              width: double.infinity,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${course.name} (${course.claass})",
                                    style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Text(
                                    course.semester,
                                    style: const TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  ElevatedButton(
                                    onPressed: () {
                                      Navigator.pushNamed(context,
                                          "/teacher/attendance/create",arguments: {
                                            "courseId": state.courseAttendance.course.id
                                          });
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color(0xFF696CFF),
                                    ),
                                    child: const Text("Buat Absensi"),
                                  ),
                                ],
                              ),
                            );
                          }
                          return Container();
                        },
                      )
                    ],
                  ),
                ),
                const Positioned(
                  top: 0,
                  left: 0,
                  child: BackButton(),
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: BlocConsumer<AttendanceBloc, AttendanceState>(
                listener: (context, state) {
                  // TODO: implement listener
                },
                builder: (context, state) {
                  if (state is AttendanceGetSuccess) {
                    return ListView(
                      children: List<Widget>.generate(
                        state.courseAttendance.attendances.length,
                        (index) {
                          return AttendanceBox(
                            attendance:
                                state.courseAttendance.attendances[index],
                          );
                        },
                      ),
                    );
                  }
                  return Container();
                },
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: MyBottomNavBar(teacherTab: teacherTab),
    );
  }
}
