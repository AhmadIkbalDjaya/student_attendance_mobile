import 'package:flutter/material.dart';
import 'package:student_attendance/bloc/course_recap/course_recap_bloc.dart';
import 'package:student_attendance/components/center_loading.dart';
import 'package:student_attendance/components/my_snack_bar.dart';
import 'package:student_attendance/cubit/teacher_tab_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student_attendance/components/my_bottom_nav_bar.dart';
import 'package:student_attendance/models/teacher/course_recap.dart';

class CourseRecapPage extends StatelessWidget {
  const CourseRecapPage({super.key, required this.courseId});
  final int courseId;

  @override
  Widget build(BuildContext context) {
    TeacherTabBloc teacherTab = context.read<TeacherTabBloc>();
    CourseRecapBloc courseRecapBloc = context.read<CourseRecapBloc>();
    courseRecapBloc.add(GetCourseRecapEvent(courseId: courseId));
    return Scaffold(
      body: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 0),
            color: const Color(0xFFD9D9D9),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                  child: Column(
                    children: [
                      const Text(
                        "Rekapan Siswa",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      BlocConsumer<CourseRecapBloc, CourseRecapState>(
                        listener: (context, state) {
                          if (state is CourseRecapFailure) {
                            showCostumSnackBar(
                              context: context,
                              message: state.message,
                              type: "danger",
                            );
                          }
                        },
                        builder: (context, state) {
                          if (state is CourseRecapSuccess) {
                            Course course = state.courseRecap.course;
                            return Column(
                              children: [
                                Text(
                                  "${course.courseName} ${course.claass}",
                                  // "Bahasa Indonesia XII IPA 1",
                                  style: const TextStyle(
                                    fontSize: 18,
                                  ),
                                ),
                                const SizedBox(height: 15),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        const Icon(Icons.leaderboard_rounded),
                                        const SizedBox(width: 10),
                                        Text(
                                          course.semester,
                                          style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          "${course.attendanceCount} Pertemuan",
                                          style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        const SizedBox(width: 10),
                                        const Icon(Icons.meeting_room),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            );
                          }
                          return const CenterLoading();
                        },
                      ),
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
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 3),
              child: BlocBuilder<CourseRecapBloc, CourseRecapState>(
                builder: (context, state) {
                  if (state is CourseRecapGetLoading) {
                    return const CenterLoading();
                  }
                  if (state is CourseRecapSuccess) {
                    return ListView(
                      children: [
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: DataTable(
                            border: TableBorder.all(
                              width: 2,
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(3),
                            ),
                            columns: const [
                              DataColumn(
                                label: Text(
                                  "No",
                                  style: TextStyle(
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                              DataColumn(
                                label: Text(
                                  "Nama",
                                  style: TextStyle(
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                              DataColumn(
                                label: Text(
                                  "NIS",
                                  style: TextStyle(
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                              DataColumn(
                                label: Text(
                                  "L/P",
                                  style: TextStyle(
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                              DataColumn(
                                label: Text("H"),
                              ),
                              DataColumn(
                                label: Text("S"),
                              ),
                              DataColumn(
                                label: Text("I"),
                              ),
                              DataColumn(
                                label: Text("A"),
                              ),
                            ],
                            rows: List<DataRow>.generate(
                              state.courseRecap.studentsRecap.length,
                              (index) {
                                StudentsRecap studentsRecap =
                                    state.courseRecap.studentsRecap[index];
                                return DataRow(
                                  cells: [
                                    DataCell(
                                      Text("${index + 1}"),
                                    ),
                                    DataCell(
                                      Text(studentsRecap.name),
                                    ),
                                    DataCell(
                                      Text(studentsRecap.nis),
                                    ),
                                    DataCell(
                                      Text(
                                        studentsRecap.gender == "male"
                                            ? "L"
                                            : "P",
                                      ),
                                    ),
                                    DataCell(
                                      Text("${studentsRecap.hCount}"),
                                    ),
                                    DataCell(
                                      Text("${studentsRecap.sCount}"),
                                    ),
                                    DataCell(
                                      Text("${studentsRecap.iCount}"),
                                    ),
                                    DataCell(
                                      Text("${studentsRecap.aCount}"),
                                    ),
                                  ],
                                );
                              },
                            ),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF696CFF),
                          ),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.print),
                              Text("Print"),
                            ],
                          ),
                        ),
                      ],
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
