import 'package:flutter/material.dart';
import 'package:student_attendance/bloc/admin/claass/claass_bloc.dart';
import 'package:student_attendance/bloc/admin/course/course_bloc.dart';
import 'package:student_attendance/bloc/admin/semester/semester_bloc.dart';
import 'package:student_attendance/bloc/admin/teacher/teacher_bloc.dart';
import 'package:student_attendance/components/admin/my_app_bar.dart';
import 'package:student_attendance/components/admin/my_drawer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student_attendance/components/center_loading.dart';
import 'package:student_attendance/components/loading_button.dart';
import 'package:student_attendance/components/my_snack_bar.dart';
import 'package:student_attendance/cubit/drop_down_value_cubit.dart';
import 'package:student_attendance/models/admin/claass.dart';
import 'package:student_attendance/models/admin/course.dart';
import 'package:student_attendance/models/admin/semester.dart';
import 'package:student_attendance/models/admin/teacher.dart';

class AdminEditCoursePage extends StatelessWidget {
  AdminEditCoursePage({super.key, required this.courseId});
  final int courseId;
  final nameController = TextEditingController();
  final teacherIdValue = DropDownValueCubit();
  final claassIdValue = DropDownValueCubit();
  final semesterIdValue = DropDownValueCubit();

  @override
  Widget build(BuildContext context) {
    CourseBloc courseBloc = context.read<CourseBloc>();
    courseBloc.add(GetDetailCourseEvent(id: courseId));
    TeacherBloc teacherBloc = context.read<TeacherBloc>();
    teacherBloc.add(GetAllTeacherEvent());
    ClaassBloc claassBloc = context.read<ClaassBloc>();
    claassBloc.add(GetAllClaassEvent());
    SemesterBloc semesterBloc = context.read<SemesterBloc>();
    semesterBloc.add(GetAllSemesterEvent());
    return WillPopScope(
      onWillPop: () async {
        courseBloc.add(GetAllCourseEvent());
        return true;
      },
      child: Scaffold(
        appBar: const MyAppBar(),
        drawer: const MyDrawer(),
        body: Column(
          children: [
            Container(
              decoration: const BoxDecoration(
                color: Color(0xFFD9D9D9),
              ),
              padding: const EdgeInsets.only(
                  top: 0, bottom: 10, right: 10, left: 10),
              width: double.infinity,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 20),
                    child: Column(
                      children: [
                        Text(
                          "Edit Mapel",
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          "Edit Mapel pada colom dibawah",
                          style: TextStyle(fontSize: 16),
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
                        courseBloc.add(GetAllCourseEvent());
                      },
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(
                      vertical: 20,
                      horizontal: 15,
                    ),
                    padding: const EdgeInsets.symmetric(
                      vertical: 25,
                      horizontal: 10,
                    ),
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(15),
                      ),
                      color: Color(0xFFD9D9D9),
                    ),
                    child: BlocConsumer<CourseBloc, CourseState>(
                      listener: (context, state) {
                        if (state is CourseDetailSuccess) {
                          Course course = state.course;
                          nameController.text = course.name;
                          teacherIdValue
                              .changeValue(course.teacherId.toString());
                          claassIdValue.changeValue(course.claassId.toString());
                          semesterIdValue
                              .changeValue(course.semesterId.toString());
                        }
                      },
                      builder: (context, state) {
                        if (state is CourseGetLoading) {
                          return const CenterLoading();
                        }
                        return Column(
                          children: [
                            SizedBox(
                              height: 40,
                              child: TextField(
                                controller: nameController,
                                textInputAction: TextInputAction.next,
                                decoration: const InputDecoration(
                                  label: Text("Nama Mapel"),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(8),
                                    ),
                                  ),
                                  contentPadding: EdgeInsets.symmetric(
                                    horizontal: 10,
                                    vertical: 0,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 25),
                            SizedBox(
                              height: 40,
                              width: double.infinity,
                              child: BlocBuilder<TeacherBloc, TeacherState>(
                                builder: (context, state) {
                                  if (state is TeacherAllSuccess) {
                                    return DropdownButtonFormField(
                                      hint: const Text("Guru Pengajar"),
                                      value: teacherIdValue.state != ""
                                          ? teacherIdValue.state
                                          : null,
                                      items: List<DropdownMenuItem>.generate(
                                          state.teachers.length, (index) {
                                        Teacher teacher = state.teachers[index];
                                        return DropdownMenuItem(
                                          value: "${teacher.id}",
                                          child: Text(teacher.name),
                                        );
                                      }),
                                      decoration: const InputDecoration(
                                        contentPadding: EdgeInsets.symmetric(
                                            horizontal: 10),
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(8),
                                          ),
                                        ),
                                      ),
                                      onChanged: (value) {
                                        teacherIdValue.changeValue(value);
                                      },
                                    );
                                  }
                                  return DropdownButtonFormField(
                                    hint: const Text("Guru Pengajar"),
                                    items: const [],
                                    decoration: const InputDecoration(
                                      contentPadding:
                                          EdgeInsets.symmetric(horizontal: 10),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(8),
                                        ),
                                      ),
                                    ),
                                    onChanged: (value) {},
                                  );
                                },
                              ),
                            ),
                            const SizedBox(height: 25),
                            SizedBox(
                              height: 40,
                              width: double.infinity,
                              child: BlocBuilder<ClaassBloc, ClaassState>(
                                builder: (context, state) {
                                  if (state is ClaassAllSuccess) {
                                    return DropdownButtonFormField(
                                      hint: const Text("Kelas"),
                                      value: claassIdValue.state != ""
                                          ? claassIdValue.state
                                          : null,
                                      items: List<DropdownMenuItem>.generate(
                                          state.claasses.length, (index) {
                                        Claass claass = state.claasses[index];
                                        return DropdownMenuItem(
                                          value: "${claass.id}",
                                          child: Text(claass.name),
                                        );
                                      }),
                                      decoration: const InputDecoration(
                                        contentPadding: EdgeInsets.symmetric(
                                            horizontal: 10),
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(8),
                                          ),
                                        ),
                                      ),
                                      onChanged: (value) {
                                        claassIdValue.changeValue(value);
                                      },
                                    );
                                  }
                                  return DropdownButtonFormField(
                                    hint: const Text("Kelas"),
                                    items: const [],
                                    decoration: const InputDecoration(
                                      contentPadding:
                                          EdgeInsets.symmetric(horizontal: 10),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(8),
                                        ),
                                      ),
                                    ),
                                    onChanged: (value) {},
                                  );
                                },
                              ),
                            ),
                            const SizedBox(height: 25),
                            SizedBox(
                              height: 40,
                              width: double.infinity,
                              child: BlocBuilder<SemesterBloc, SemesterState>(
                                builder: (context, state) {
                                  if (state is SemesterAllSuccess) {
                                    return DropdownButtonFormField(
                                      hint: const Text("Semester"),
                                      value: semesterIdValue.state != ""
                                          ? semesterIdValue.state
                                          : null,
                                      items: List<DropdownMenuItem>.generate(
                                        state.semesters.length,
                                        (index) {
                                          Semester semester =
                                              state.semesters[index];
                                          return DropdownMenuItem(
                                            value: "${semester.id}",
                                            child: Row(
                                              children: [
                                                Text(
                                                  semester.oddEven == "1"
                                                      ? "Ganjil ${semester.startYear}/${semester.endYear}"
                                                      : "Genap ${semester.startYear}/${semester.endYear}",
                                                ),
                                                semester.isActive == "1"
                                                    ? const Icon(
                                                        Icons.done_rounded)
                                                    : Container()
                                              ],
                                            ),
                                          );
                                        },
                                      ),
                                      decoration: const InputDecoration(
                                        contentPadding: EdgeInsets.symmetric(
                                            horizontal: 10),
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(8),
                                          ),
                                        ),
                                      ),
                                      onChanged: (value) {
                                        semesterIdValue.changeValue(value);
                                      },
                                    );
                                  }
                                  return DropdownButtonFormField(
                                    hint: const Text("Semester"),
                                    items: const [],
                                    decoration: const InputDecoration(
                                      contentPadding:
                                          EdgeInsets.symmetric(horizontal: 10),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(8),
                                        ),
                                      ),
                                    ),
                                    onChanged: (value) {},
                                  );
                                },
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: BlocConsumer<CourseBloc, CourseState>(
                      listener: (context, state) {
                        if (state is CourseEditSuccess) {
                          Navigator.pushNamed(context, "/admin/course");
                          showCostumSnackBar(
                            context: context,
                            message: "Mapel Berhasil Diedit",
                            type: "success",
                          );
                        } else if (state is CourseValidationError) {
                          showCostumSnackBar(
                            context: context,
                            message: state.message,
                            type: "danger",
                          );
                        }
                      },
                      builder: (context, state) {
                        if (state is CourseLoading) {
                          return const LoadingButton();
                        }
                        return ElevatedButton(
                          onPressed: () {
                            courseBloc.add(EditCourseEvent(
                              id: courseId,
                              name: nameController.text,
                              teacherId: teacherIdValue.state,
                              claassId: claassIdValue.state,
                              semesterId: semesterIdValue.state,
                            ));
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
          ],
        ),
      ),
    );
  }
}
