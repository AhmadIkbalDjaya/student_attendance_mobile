import 'package:flutter/material.dart';
import 'package:student_attendance/bloc/teacher/attendance/attendance_bloc.dart';
import 'package:student_attendance/components/center_loading.dart';
import 'package:student_attendance/components/my_snack_bar.dart';
import 'package:student_attendance/models/teacher/course_attendance.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AttendanceBox extends StatelessWidget {
  const AttendanceBox(
      {super.key, required this.attendance, required this.courseId});
  final Attendance attendance;
  final int courseId;
  @override
  Widget build(BuildContext context) {
    AttendanceBloc attendanceBloc = context.read<AttendanceBloc>();
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(10),
      ),
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(10),
            decoration: const BoxDecoration(
              color: Color(0xFFC4C4C4),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
            ),
            child: Text(
              attendance.title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        "/teacher/attendance/student_attendance",
                        arguments: {
                          "attendanceId": attendance.id,
                        },
                      );
                    },
                    child: const Row(
                      children: [
                        Icon(Icons.people),
                        SizedBox(width: 5),
                        Text(
                          "Kehadiran",
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 5,
                      height: 5,
                      child: Checkbox(
                        value: attendance.isFilled == "1" ? true : false,
                        onChanged: (value) {},
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return BlocConsumer<AttendanceBloc,
                                AttendanceState>(
                              listener: (context, state) {
                                if (state is AttendanceDeleteSuccess) {
                                  Navigator.pop(context);
                                  attendanceBloc.add(
                                    GetCourseAttendanceEvent(
                                        courseId: courseId),
                                  );
                                  showCostumSnackBar(
                                    context: context,
                                    message: "Absensi Berhasil Dihapus",
                                    type: "success",
                                  );
                                }
                                if (state is AttendanceFailure) {
                                  showCostumSnackBar(
                                    context: context,
                                    message: state.message,
                                    type: "danger",
                                  );
                                }
                              },
                              builder: (context, state) {
                                return AlertDialog(
                                  title: const Text("Konfirmasi Hapus"),
                                  content: state is AttendanceLoading
                                      ? const CenterLoading()
                                      : Text(
                                          "Yakin Ingin Menghapus ${attendance.title}",
                                          textAlign: TextAlign.center,
                                        ),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: const Text("Tidak"),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        attendanceBloc.add(
                                          DeleteAttendanceEvent(
                                            attendanceId: attendance.id,
                                          ),
                                        );
                                      },
                                      child: const Text("Ya"),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                        );
                      },
                      icon: const Icon(Icons.delete),
                    )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
