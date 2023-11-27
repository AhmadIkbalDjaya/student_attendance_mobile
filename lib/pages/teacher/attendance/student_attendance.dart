import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:student_attendance/bloc/teacher/student_attendance/student_attendance_bloc.dart';
import 'package:student_attendance/bloc/teacher/update_student_attendance/update_student_attendance_bloc.dart';
import 'package:student_attendance/components/loading_button.dart';
import 'package:student_attendance/components/my_snack_bar.dart';
import 'package:student_attendance/cubit/radio_cubit.dart';
import 'package:student_attendance/cubit/teacher_tab_bloc.dart';
import 'package:student_attendance/components/my_bottom_nav_bar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student_attendance/models/teacher/student_attendance.dart';

class StudentAttendancePage extends StatelessWidget {
  StudentAttendancePage(
      {super.key, required this.attendanceId, required this.courseId});
  final int attendanceId;
  final int courseId;
  final RadioCubit idsValue = RadioCubit();
  final RadioCubit statusesValue = RadioCubit();

  @override
  Widget build(BuildContext context) {
    TeacherTabBloc teacherTab = context.read<TeacherTabBloc>();
    StudentAttendanceBloc studentAttendanceBloc =
        context.read<StudentAttendanceBloc>();
    studentAttendanceBloc.add(
      GetStudentAttendanceEvent(attendanceId: attendanceId),
    );
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
                BlocBuilder<StudentAttendanceBloc, StudentAttendanceState>(
                  builder: (context, state) {
                    Attendance attendance = state is StudentAttendanceGetSuccess
                        ? state.studentAttendance.attendance
                        : dummyStudentAttendance.attendance;
                    return Skeletonizer(
                      enabled: state is! StudentAttendanceGetSuccess,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 15, horizontal: 15),
                        child: Column(
                          children: [
                            Text(
                              attendance.title,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "${attendance.course} ${attendance.claass}",
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                              ),
                            ),
                            const SizedBox(height: 15),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    const Skeleton.keep(
                                      child: Icon(
                                        Icons.people,
                                        color: Colors.white,
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    Text(
                                      "${attendance.studentCount} Peserta",
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
                                      attendance.datetime,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    const Skeleton.keep(
                                      child: Icon(
                                        Icons.date_range,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Skeleton.keep(
                              child: SizedBox(
                                width: double.infinity,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      "Keterangan",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 5),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        RichText(
                                          text: const TextSpan(
                                            style: TextStyle(
                                              color: Colors.white,
                                            ),
                                            children: [
                                              TextSpan(
                                                text: "H",
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              TextSpan(text: " : "),
                                              TextSpan(text: "Hadir"),
                                            ],
                                          ),
                                        ),
                                        RichText(
                                          text: const TextSpan(
                                            style: TextStyle(
                                              color: Colors.white,
                                            ),
                                            children: [
                                              TextSpan(
                                                text: "S",
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              TextSpan(text: " : "),
                                              TextSpan(text: "Sakit"),
                                            ],
                                          ),
                                        ),
                                        RichText(
                                          text: const TextSpan(
                                            style: TextStyle(
                                              color: Colors.white,
                                            ),
                                            children: [
                                              TextSpan(
                                                text: "I",
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              TextSpan(text: " : "),
                                              TextSpan(text: "Izin"),
                                            ],
                                          ),
                                        ),
                                        RichText(
                                          text: const TextSpan(
                                            style: TextStyle(
                                              color: Colors.white,
                                            ),
                                            children: [
                                              TextSpan(
                                                text: "A",
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              TextSpan(text: " : "),
                                              TextSpan(text: "Alfa"),
                                            ],
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
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
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 3),
              child:
                  BlocConsumer<StudentAttendanceBloc, StudentAttendanceState>(
                listener: (context, state) {
                  if (state is StudentAttendanceGetSuccess) {
                    for (var i = 0;
                        i < state.studentAttendance.studentAttendances.length;
                        i++) {
                      StudentAttendanceElement studentAttendance =
                          state.studentAttendance.studentAttendances[i];

                      idsValue.setInitValue(
                        i,
                        studentAttendance.id.toString(),
                      );
                      statusesValue.setInitValue(i, studentAttendance.statusId);
                    }
                  }
                },
                builder: (context, state) {
                  List<StudentAttendanceElement> studentAttendances =
                      state is StudentAttendanceGetSuccess
                          ? state.studentAttendance.studentAttendances
                          : dummyStudentAttendance.studentAttendances;
                  return Skeletonizer(
                    enabled: state is! StudentAttendanceGetSuccess,
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
                                label: Skeleton.unite(
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      SizedBox(width: 18),
                                      Text(
                                        "H",
                                      ),
                                      SizedBox(width: 40),
                                      Text(
                                        "S",
                                      ),
                                      SizedBox(width: 40),
                                      Text(
                                        "I",
                                      ),
                                      SizedBox(width: 40),
                                      Text(
                                        "A",
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                            rows: List<DataRow>.generate(
                              studentAttendances.length,
                              (index) {
                                StudentAttendanceElement studentAttendance =
                                    studentAttendances[index];
                                return DataRow(
                                  cells: [
                                    DataCell(
                                      Center(child: Text("${index + 1}")),
                                    ),
                                    DataCell(
                                      Text(studentAttendance.studentName),
                                    ),
                                    DataCell(
                                      Text(studentAttendance.nis),
                                    ),
                                    DataCell(
                                      Center(
                                        child: Text(
                                          studentAttendance.gender == "male"
                                              ? "L"
                                              : "P",
                                        ),
                                      ),
                                    ),
                                    DataCell(
                                      BlocBuilder<RadioCubit, List<String>>(
                                        bloc: statusesValue,
                                        builder: (context, state) {
                                          return Skeleton.ignore(
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Radio(
                                                  value: "1",
                                                  groupValue: statusesValue
                                                          .state.isNotEmpty
                                                      ? statusesValue
                                                          .state[index]
                                                      : null,
                                                  onChanged: (value) {
                                                    statusesValue.setRadioValue(
                                                      index,
                                                      "1",
                                                    );
                                                  },
                                                ),
                                                Radio(
                                                  value: "2",
                                                  groupValue: statusesValue
                                                          .state.isNotEmpty
                                                      ? statusesValue
                                                          .state[index]
                                                      : null,
                                                  onChanged: (value) {
                                                    statusesValue.setRadioValue(
                                                      index,
                                                      "2",
                                                    );
                                                  },
                                                ),
                                                Radio(
                                                  value: "3",
                                                  groupValue: statusesValue
                                                          .state.isNotEmpty
                                                      ? statusesValue
                                                          .state[index]
                                                      : null,
                                                  onChanged: (value) {
                                                    statusesValue.setRadioValue(
                                                      index,
                                                      "3",
                                                    );
                                                  },
                                                ),
                                                Radio(
                                                  value: "4",
                                                  groupValue: statusesValue
                                                          .state.isNotEmpty
                                                      ? statusesValue
                                                          .state[index]
                                                      : null,
                                                  onChanged: (value) {
                                                    statusesValue.setRadioValue(
                                                      index,
                                                      "4",
                                                    );
                                                  },
                                                ),
                                              ],
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ],
                                );
                              },
                            ),
                          ),
                        ),
                        BlocConsumer<UpdateStudentAttendanceBloc,
                            UpdateStudentAttendanceState>(
                          listener: (context, state) {
                            if (state is UpdateStudentAttendanceSuccess) {
                              showCostumSnackBar(
                                context: context,
                                message: "Absensi Berhasil di simpan",
                                type: "success",
                              );
                              // Navigator.pop(context);
                              Navigator.pushNamed(
                                context,
                                "/teacher/attendance/course",
                                arguments: {"courseId": courseId},
                              );
                            }
                            if (state is UpdateStudentAttendanceFailure) {
                              showCostumSnackBar(
                                context: context,
                                message: state.message,
                                type: "danger",
                              );
                            }
                          },
                          builder: (context, state) {
                            if (state is UpdateStudentAttendanceLoading) {
                              return const LoadingButton();
                            }
                            return Skeleton.ignore(
                              child: ElevatedButton(
                                onPressed: () {
                                  context
                                      .read<UpdateStudentAttendanceBloc>()
                                      .add(
                                        UpdateEvent(
                                          attendanceId: attendanceId,
                                          ids: idsValue.state,
                                          statusesId: statusesValue.state,
                                        ),
                                      );
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFF696CFF),
                                ),
                                child: const Text("Simpan"),
                              ),
                            );
                          },
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
