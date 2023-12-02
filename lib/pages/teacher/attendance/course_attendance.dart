import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:student_attendance/bloc/teacher/attendance/attendance_bloc.dart';
import 'package:student_attendance/components/my_snack_bar.dart';
import 'package:student_attendance/components/teacher/attendance_box.dart';
import 'package:student_attendance/cubit/teacher_tab_bloc.dart';
import 'package:student_attendance/components/my_bottom_nav_bar.dart';
import 'package:student_attendance/models/teacher/course_attendance.dart';
import 'package:student_attendance/presentation/costum_icons_icons.dart';

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
              gradient: LinearGradient(
                colors: [
                  Color(0xFF696CFF),
                  Color(0xFFACAEFE),
                ],
                begin: Alignment(0, 0.3),
                end: Alignment.bottomCenter,
              ),
            ),
            padding: const EdgeInsets.only(top: 35),
            width: double.infinity,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                  child: BlocConsumer<AttendanceBloc, AttendanceState>(
                    listener: (context, state) {
                      if (state is AttendanceFailure) {
                        showCostumSnackBar(
                            context: context, message: state.message);
                      }
                    },
                    builder: (context, state) {
                      Course course = state is AttendanceGetSuccess
                          ? state.courseAttendance.course
                          : dummyCourseAttendance.course;
                      return Skeletonizer(
                        enabled: state is! AttendanceGetSuccess,
                        child: Column(
                          children: [
                            const Skeleton.keep(
                              child: Text(
                                "Absensi Mapel",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Text(
                              course.name,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(height: 10),
                            SizedBox(
                              width: double.infinity,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          const Skeleton.keep(
                                            child: Icon(
                                              Icons.leaderboard_rounded,
                                              color: Colors.white,
                                            ),
                                          ),
                                          const SizedBox(width: 10),
                                          Text(
                                            course.semester,
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            course.claass,
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          const SizedBox(width: 10),
                                          const Skeleton.keep(
                                            child: Icon(
                                              CostumIcons.claass,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 10),
                                  Skeleton.shade(
                                    child: SizedBox(
                                      width: double.infinity,
                                      child: ElevatedButton(
                                        onPressed: () {
                                          Navigator.pushNamed(
                                            context,
                                            "/teacher/attendance/create",
                                            arguments: {"courseId": courseId},
                                          );
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor:
                                              const Color(0xFF696CFF),
                                        ),
                                        child: const Text("Buat Absensi"),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      );
                    },
                  ),
                ),
                const Positioned(
                  top: 0,
                  left: 0,
                  child: BackButton(
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: BlocBuilder<AttendanceBloc, AttendanceState>(
                builder: (context, state) {
                  return Skeletonizer(
                    enabled: state is! AttendanceGetSuccess,
                    child: ListView(
                      children: List<Widget>.generate(
                        state is AttendanceGetSuccess
                            ? state.courseAttendance.attendances.length
                            : dummyCourseAttendance.attendances.length,
                        (index) {
                          return AttendanceBox(
                            courseId: courseId,
                            attendance: state is AttendanceGetSuccess
                                ? state.courseAttendance.attendances[index]
                                : dummyCourseAttendance.attendances[index],
                          );
                        },
                      ),
                    ),
                  );
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
