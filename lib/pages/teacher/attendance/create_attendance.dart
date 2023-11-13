import 'package:flutter/material.dart';
import 'package:student_attendance/bloc/teacher/attendance/attendance_bloc.dart';
import 'package:student_attendance/bloc/teacher/create_attendance/create_attendance_bloc.dart';
import 'package:student_attendance/components/loading_button.dart';
import 'package:student_attendance/components/my_snack_bar.dart';
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
            decoration: const BoxDecoration(
              color: Color(0xFFD9D9D9),
            ),
            padding:
                const EdgeInsets.only(top: 0, bottom: 15, right: 10, left: 10),
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
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text("Tambah Absensi pada colom dibawah"),
                    ],
                  ),
                ),
                Positioned(
                  top: 0,
                  left: 0,
                  child: BackButton(),
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 35, horizontal: 10),
              child: ListView(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 35,
                      horizontal: 15,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: const Color(0xFFD9D9D9),
                    ),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 50,
                          child: TextField(
                            controller: titleController,
                            decoration: const InputDecoration(
                              label: Text("Judul Absensi"),
                              border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8)),
                              ),
                            ),
                            textInputAction: TextInputAction.next,
                          ),
                        ),
                        const SizedBox(height: 35),
                        SizedBox(
                          height: 50,
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
                                  label: Text("Tanggal Absensi"),
                                  filled: true,
                                  prefixIcon: Icon(Icons.date_range),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide.none),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color(0xFF696CFF),
                                    ),
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(8)),
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
                                courseId: courseId,
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

class DatePickerCubit extends Cubit<DateTime?> {
  DatePickerCubit() : super(null);

  void pickDate(BuildContext context, DateTime initialDate) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(3000),
    );
    if (picked != null) {
      emit(picked);
    }
  }
}
