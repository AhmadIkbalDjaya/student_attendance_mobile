import 'package:flutter/material.dart';
import 'package:student_attendance/bloc/admin/course/course_bloc.dart';
import 'package:student_attendance/components/admin/my_app_bar.dart';
import 'package:student_attendance/components/admin/my_drawer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student_attendance/components/center_loading.dart';
import 'package:student_attendance/models/admin/course.dart';

class AdminDetailCoursePage extends StatelessWidget {
  const AdminDetailCoursePage({super.key, required this.courseId});
  final int courseId;

  @override
  Widget build(BuildContext context) {
    CourseBloc courseBloc = context.read<CourseBloc>();
    courseBloc.add(GetDetailCourseEvent(id: courseId));
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
                          "Informasi Mapel",
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          "Datail Informasi Mata Pelajaran",
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
                      horizontal: 30,
                    ),
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(15),
                      ),
                      color: Color(0xFFD9D9D9),
                    ),
                    width: double.infinity,
                    child: BlocBuilder<CourseBloc, CourseState>(
                      builder: (context, state) {
                        if (state is CourseGetLoading) {
                          return const CenterLoading();
                        }
                        if (state is CourseDetailSuccess) {
                          Course course = state.course;
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                course.name,
                                style: const TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                "${course.teacher}",
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(height: 20),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.class_,
                                    size: 25,
                                  ),
                                  const SizedBox(width: 10),
                                  Text(
                                    course.claass,
                                    style: const TextStyle(
                                      fontSize: 18,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.format_list_numbered_rounded,
                                    size: 25,
                                  ),
                                  const SizedBox(width: 10),
                                  Text(
                                    "${course.semester}",
                                    style: const TextStyle(
                                      fontSize: 18,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              Row(
                                children: [
                                  ElevatedButton(
                                    onPressed: () {},
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.amber[300],
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 15,
                                        vertical: 0,
                                      ),
                                    ),
                                    child: const Row(
                                      children: [
                                        Icon(
                                          Icons.edit_square,
                                          color: Colors.black,
                                          size: 20,
                                        ),
                                        SizedBox(width: 5),
                                        Text(
                                          "Edit",
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(width: 15),
                                  ElevatedButton(
                                    onPressed: () {},
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.red,
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 15,
                                        vertical: 0,
                                      ),
                                    ),
                                    child: const Row(
                                      children: [
                                        Icon(
                                          Icons.delete,
                                          color: Colors.black,
                                          size: 20,
                                        ),
                                        SizedBox(width: 5),
                                        Text(
                                          "Hapus",
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              )
                            ],
                          );
                        }
                        return Container();
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
