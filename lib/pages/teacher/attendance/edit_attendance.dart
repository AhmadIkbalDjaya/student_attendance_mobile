import 'package:flutter/material.dart';
import 'package:student_attendance/bloc/teacher/attendance/attendance/attendance_bloc.dart';
import 'package:student_attendance/bloc/teacher/attendance/edit_attendance/edit_attendance_bloc.dart';
import 'package:student_attendance/components/my_snack_bar.dart';
import 'package:student_attendance/cubit/date_picker_cubit.dart';
import 'package:student_attendance/cubit/teacher_tab_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student_attendance/components/my_bottom_nav_bar.dart';
import 'package:student_attendance/values/theme.dart';

class EditAttendancePage extends StatelessWidget {
  EditAttendancePage(
      {super.key, required this.courseId, required this.attendanceId});
  final int courseId;
  final int attendanceId;
  final DatePickerCubit datePickerCubit = DatePickerCubit();
  final TextEditingController titleController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    TeacherTabBloc teacherTab = context.read<TeacherTabBloc>();
    AttendanceBloc attendanceBloc = context.read<AttendanceBloc>();
    attendanceBloc.add(GetDetailAttendanceEvent(attendanceId: attendanceId));
    EditAttendanceBloc createAttendanceBloc =
        context.read<EditAttendanceBloc>();
    return Scaffold(
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(top: 35, bottom: 15),
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
            width: double.infinity,
            child: Stack(
              alignment: Alignment.center,
              children: [
                const Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: Column(
                    children: [
                      Text(
                        "Edit Absensi",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        "Edit Absensi pada colom dibawah",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: 0,
                  left: 0,
                  child: BackButton(
                    onPressed: () {
                      Navigator.pop(context);
                      attendanceBloc
                          .add(GetCourseAttendanceEvent(courseId: courseId));
                    },
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 10),
              child: ListView(
                children: [
                  BlocConsumer<AttendanceBloc, AttendanceState>(
                    listener: (context, state) {
                      if (state is AttendanceDetailSucces) {
                        titleController.text = state.attendance.title;
                        datePickerCubit
                            .setData(DateTime.parse(state.attendance.datetime));
                      }
                    },
                    builder: (context, state) {
                      return Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 35,
                          horizontal: 15,
                        ),
                        decoration: CustomTheme.contentDecoration(),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 40,
                              child: TextField(
                                controller: titleController,
                                decoration: const InputDecoration(
                                  label: Text(
                                    "Judul Absensi",
                                    style: TextStyle(
                                      color: Color(0xFF696CFF),
                                    ),
                                  ),
                                ),
                                textInputAction: TextInputAction.next,
                              ),
                            ),
                            const SizedBox(height: 35),
                            SizedBox(
                              height: 40,
                              child: BlocBuilder<DatePickerCubit, DateTime?>(
                                bloc: datePickerCubit,
                                builder: (context, state) {
                                  return TextField(
                                    onTap: () {
                                      datePickerCubit.pickDate(
                                        context,
                                        state ?? DateTime.now(),
                                      );
                                    },
                                    controller: TextEditingController(
                                      text: state != null
                                          ? state.toString().split(" ")[0]
                                          : '',
                                    ),
                                    readOnly: true,
                                    decoration: const InputDecoration(
                                      label: Text(
                                        "Tanggal Absensi",
                                        style: TextStyle(
                                          color: Color(0xFF696CFF),
                                        ),
                                      ),
                                      filled: true,
                                      suffixIcon: Icon(
                                        Icons.date_range,
                                        color: Color(0xFF696CFF),
                                      ),
                                    ),
                                    textInputAction: TextInputAction.done,
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    child:
                        BlocConsumer<EditAttendanceBloc, EditAttendanceState>(
                      listener: (context, state) {
                        if (state is EditAttendanceSuccess) {
                          Navigator.pop(context);
                          context.read<AttendanceBloc>().add(
                              GetCourseAttendanceEvent(courseId: courseId));
                          showCostumSnackBar(
                            context: context,
                            message: "Kehadiran Berhasil diEdit",
                            type: "success",
                          );
                        } else if (state is EditAttendanceFailure) {
                          showCostumSnackBar(
                            context: context,
                            message: state.message,
                            type: "danger",
                          );
                        }
                      },
                      builder: (context, state) {
                        return ElevatedButton(
                          onPressed: () {
                            state is EditAttendanceLoading
                                ? null
                                : createAttendanceBloc.add(
                                    EditEvent(
                                      attendanceId: attendanceId,
                                      title: titleController.text,
                                      datetime: datePickerCubit.state != null
                                          ? datePickerCubit.state.toString()
                                          : "",
                                    ),
                                  );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF696CFF),
                          ),
                          child: Text(
                            state is EditAttendanceLoading
                                ? "Simpan..."
                                : "Simpan",
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
      bottomNavigationBar: MyBottomNavBar(teacherTab: teacherTab),
    );
  }
}
