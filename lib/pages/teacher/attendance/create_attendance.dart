import 'package:flutter/material.dart';
import 'package:student_attendance/bloc/teacher/attendance/attendance/attendance_bloc.dart';
import 'package:student_attendance/bloc/teacher/attendance/create_attendance/create_attendance_bloc.dart';
import 'package:student_attendance/components/loading_button.dart';
import 'package:student_attendance/components/my_snack_bar.dart';
import 'package:student_attendance/cubit/date_picker_cubit.dart';
import 'package:student_attendance/cubit/teacher_tab_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student_attendance/components/my_bottom_nav_bar.dart';

class CreateAttendancePage extends StatelessWidget {
  CreateAttendancePage({super.key, required this.courseId});
  final int courseId;
  final DatePickerCubit datePickerCubit = DatePickerCubit();
  final TextEditingController titleController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    TeacherTabBloc teacherTab = context.read<TeacherTabBloc>();
    CreateAttendanceBloc createAttendanceBloc =
        context.read<CreateAttendanceBloc>();
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
            child: const Stack(
              alignment: Alignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: Column(
                    children: [
                      Text(
                        "Tambah Absensi",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        "Tambah Absensi pada colom dibawah",
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
                  Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 35,
                      horizontal: 15,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.white,
                      boxShadow: const [
                        BoxShadow(
                          color: Color.fromARGB(25, 0, 0, 0),
                          spreadRadius: 1,
                          blurRadius: 1,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
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
                              border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5)),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0xFF696CFF),
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
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
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color(0xFF696CFF),
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color(0xFF696CFF),
                                    ),
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5)),
                                  ),
                                ),
                                textInputAction: TextInputAction.done,
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    child: BlocConsumer<CreateAttendanceBloc,
                        CreateAttendanceState>(
                      listener: (context, state) {
                        if (state is CreateAttendanceSuccess) {
                          Navigator.pop(context);
                          context.read<AttendanceBloc>().add(
                              GetCourseAttendanceEvent(courseId: courseId));
                        } else if (state is CreateAttendanceFailure) {
                          showCostumSnackBar(
                            context: context,
                            message: state.message,
                            type: "danger",
                          );
                        }
                      },
                      builder: (context, state) {
                        if (state is CreateAttendanceLoading) {
                          return const LoadingButton();
                        }
                        return ElevatedButton(
                          onPressed: () {
                            createAttendanceBloc.add(
                              CreateNewAttendanceEvent(
                                courseId: courseId.toString(),
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
                          child: const Text("Simpan"),
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
