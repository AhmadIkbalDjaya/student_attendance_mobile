import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:student_attendance/bloc/course_recap/course_recap_bloc.dart';
import 'package:student_attendance/components/my_snack_bar.dart';
import 'package:student_attendance/cubit/teacher_tab_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student_attendance/components/my_bottom_nav_bar.dart';
import 'package:student_attendance/helper/pdf_helper.dart';
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
            padding: const EdgeInsets.only(top: 35),
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
                          color: Colors.white,
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
                          return Skeletonizer(
                            enabled: state is! CourseRecapSuccess,
                            child: Column(
                              children: [
                                Text(
                                  state is CourseRecapSuccess
                                      ? "${state.courseRecap.course.courseName} ${state.courseRecap.course.claass}"
                                      : "Bahasa Indonesia XII IPA 1",
                                  style: const TextStyle(
                                    color: Colors.white,
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
                                        const Skeleton.shade(
                                          child: Icon(
                                            Icons.leaderboard_rounded,
                                            color: Colors.white,
                                          ),
                                        ),
                                        const SizedBox(width: 10),
                                        Text(
                                          state is CourseRecapSuccess
                                              ? state
                                                  .courseRecap.course.semester
                                              : "(Genap) 2020/2021",
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          state is CourseRecapSuccess
                                              ? "${state.courseRecap.course.attendanceCount} Pertemuan"
                                              : "16 Pertamuan",
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        const SizedBox(width: 10),
                                        const Skeleton.shade(
                                          child: Icon(
                                            Icons.meeting_room,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ],
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
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: BlocBuilder<CourseRecapBloc, CourseRecapState>(
                builder: (context, state) {
                  return Skeletonizer(
                    enabled: state is! CourseRecapSuccess,
                    child: ListView(
                      children: [
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: DataTable(
                            horizontalMargin: 10,
                            columnSpacing: 25,
                            dataRowMinHeight: 42,
                            dataRowMaxHeight: 42,
                            headingRowHeight: 42,
                            headingTextStyle: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                            ),
                            border: TableBorder.all(
                              width: 2,
                              color: const Color(0xFFACAEFE),
                              borderRadius: BorderRadius.circular(3),
                            ),
                            columns: const [
                              DataColumn(
                                label: Text(
                                  "No",
                                ),
                              ),
                              DataColumn(
                                label: Text(
                                  "Nama",
                                ),
                              ),
                              DataColumn(
                                label: Text(
                                  "NIS",
                                ),
                              ),
                              DataColumn(
                                label: Text(
                                  "L/P",
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
                              state is CourseRecapSuccess
                                  ? state.courseRecap.studentsRecap.length
                                  : dummyCourseRecap.studentsRecap.length,
                              (index) {
                                StudentsRecap studentsRecap =
                                    state is CourseRecapSuccess
                                        ? state.courseRecap.studentsRecap[index]
                                        : dummyCourseRecap.studentsRecap[index];
                                return DataRow(
                                  cells: [
                                    DataCell(
                                      Center(
                                        child: Text(
                                          "${index + 1}",
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ),
                                    DataCell(
                                      Text(studentsRecap.name),
                                    ),
                                    DataCell(
                                      Text(studentsRecap.nis),
                                    ),
                                    DataCell(
                                      Center(
                                        child: Text(
                                          studentsRecap.gender == "male"
                                              ? "L"
                                              : "P",
                                        ),
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
                        Skeleton.ignore(
                          child: ElevatedButton(
                            onPressed: () {
                              state is CourseRecapSuccess
                                  ? PdfHelper.getPDF(state.courseRecap)
                                  : null;
                            },
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
                        ),
                      ],
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
