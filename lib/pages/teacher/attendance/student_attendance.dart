import 'package:flutter/material.dart';
import 'package:student_attendance/bloc/teacher/student_attendance/student_attendance_bloc.dart';
import 'package:student_attendance/bloc/teacher/update_student_attendance/update_student_attendance_bloc.dart';
import 'package:student_attendance/components/center_loading.dart';
import 'package:student_attendance/components/loading_button.dart';
import 'package:student_attendance/components/my_snack_bar.dart';
import 'package:student_attendance/cubit/radio_cubit.dart';
import 'package:student_attendance/cubit/teacher_tab_bloc.dart';
import 'package:student_attendance/components/my_bottom_nav_bar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student_attendance/models/teacher/student_attendance.dart';

class StudentAttendancePage extends StatelessWidget {
  StudentAttendancePage({super.key, required this.attendanceId});
  final int attendanceId;
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
            padding: const EdgeInsets.symmetric(vertical: 0),
            color: const Color(0xFFD9D9D9),
            child: Stack(
              alignment: Alignment.center,
              children: [
                BlocBuilder<StudentAttendanceBloc, StudentAttendanceState>(
                  builder: (context, state) {
                    if (state is StudentAttendanceGetLoading) {
                      return const CenterLoading();
                    }
                    if (state is StudentAttendanceGetSuccess) {
                      Attendance attendance =
                          state.studentAttendance.attendance;
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 15, horizontal: 15),
                        child: Column(
                          children: [
                            Text(
                              attendance.title,
                              style: const TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "${attendance.course} ${attendance.claass}",
                              style: const TextStyle(
                                fontSize: 18,
                              ),
                            ),
                            const SizedBox(height: 15),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    const Icon(Icons.people),
                                    const SizedBox(width: 10),
                                    Text(
                                      "${attendance.studentCount} Peserta",
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
                                      attendance.datetime,
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    const Icon(Icons.date_range),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            SizedBox(
                              width: double.infinity,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    "Keterangan",
                                    style: TextStyle(
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
                                            color: Colors.black,
                                          ),
                                          children: [
                                            TextSpan(
                                              text: "H",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            TextSpan(text: " : "),
                                            TextSpan(text: "Hadir"),
                                          ],
                                        ),
                                      ),
                                      RichText(
                                        text: const TextSpan(
                                          style: TextStyle(
                                            color: Colors.black,
                                          ),
                                          children: [
                                            TextSpan(
                                              text: "S",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            TextSpan(text: " : "),
                                            TextSpan(text: "Sakit"),
                                          ],
                                        ),
                                      ),
                                      RichText(
                                        text: const TextSpan(
                                          style: TextStyle(
                                            color: Colors.black,
                                          ),
                                          children: [
                                            TextSpan(
                                              text: "I",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            TextSpan(text: " : "),
                                            TextSpan(text: "Izin"),
                                          ],
                                        ),
                                      ),
                                      RichText(
                                        text: const TextSpan(
                                          style: TextStyle(
                                            color: Colors.black,
                                          ),
                                          children: [
                                            TextSpan(
                                              text: "A",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
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
                          ],
                        ),
                      );
                    }
                    return Container();
                  },
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
                  if (state is StudentAttendanceGetLoading) {
                    return const CenterLoading();
                  }
                  if (state is StudentAttendanceGetSuccess) {
                    List<StudentAttendanceElement> studentAttendances =
                        state.studentAttendance.studentAttendances;
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
                                label: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(width: 18),
                                    Text(
                                      "H",
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                    SizedBox(width: 40),
                                    Text(
                                      "S",
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                    SizedBox(width: 40),
                                    Text(
                                      "I",
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                    SizedBox(width: 40),
                                    Text(
                                      "A",
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                  ],
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
                                      Text("${index + 1}"),
                                    ),
                                    DataCell(
                                      Text(studentAttendance.studentName),
                                    ),
                                    DataCell(
                                      Text(studentAttendance.nis),
                                    ),
                                    DataCell(
                                      Text(
                                        studentAttendance.gender == "male"
                                            ? "L"
                                            : "P",
                                      ),
                                    ),
                                    DataCell(
                                      BlocBuilder<RadioCubit, List<String>>(
                                        bloc: statusesValue,
                                        builder: (context, state) {
                                          return Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Radio(
                                                value: "1",
                                                groupValue: statusesValue
                                                        .state.isNotEmpty
                                                    ? statusesValue.state[index]
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
                                                    ? statusesValue.state[index]
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
                                                    ? statusesValue.state[index]
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
                                                    ? statusesValue.state[index]
                                                    : null,
                                                onChanged: (value) {
                                                  statusesValue.setRadioValue(
                                                    index,
                                                    "4",
                                                  );
                                                },
                                              ),
                                            ],
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
                              Navigator.pop(context);
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
                            return ElevatedButton(
                              onPressed: () {
                                context.read<UpdateStudentAttendanceBloc>().add(
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
                            );
                          },
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
