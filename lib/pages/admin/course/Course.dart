import 'package:flutter/material.dart';
import 'package:student_attendance/bloc/admin/course/course_bloc.dart';
import 'package:student_attendance/components/admin/button/detail_icon_button.dart';
import 'package:student_attendance/components/admin/button/edit_icon_button.dart';
import 'package:student_attendance/components/admin/my_app_bar.dart';
import 'package:student_attendance/components/admin/my_drawer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student_attendance/components/center_loading.dart';
import 'package:student_attendance/components/my_snack_bar.dart';
import 'package:student_attendance/models/admin/course.dart';

class AdminCoursePage extends StatelessWidget {
  const AdminCoursePage({super.key});

  @override
  Widget build(BuildContext context) {
    CourseBloc courseBloc = context.read<CourseBloc>();
    courseBloc.add(GetAllCourseEvent());
    return Scaffold(
      appBar: const MyAppBar(),
      drawer: const MyDrawer(),
      body: Column(
        children: [
          Container(
            decoration: const BoxDecoration(
              color: Color(0xFFD9D9D9),
            ),
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Mata Pelajaran",
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Text(
                  "Tambah, Edit atau Hapus Mata Pelajaran",
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, "/admin/course/create");
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF696CFF),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(20),
                      ),
                    ),
                  ),
                  child: const Text("Tambah Mata Pelajaran"),
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 3),
              child: ListView(
                children: [
                  BlocBuilder<CourseBloc, CourseState>(
                    builder: (context, state) {
                      if (state is CourseGetLoading) {
                        return const CenterLoading();
                      }
                      if (state is CourseAllSuccess) {
                        return SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: DataTable(
                            border: TableBorder.all(
                              width: 2,
                              color: Colors.grey,
                              borderRadius: const BorderRadius.all(
                                Radius.circular(3),
                              ),
                            ),
                            columns: const [
                              DataColumn(
                                label: Expanded(
                                  child: Text(
                                    "No",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                ),
                              ),
                              DataColumn(
                                label: Expanded(
                                  child: Text(
                                    "Mata Pelajaran",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                ),
                              ),
                              DataColumn(
                                label: Expanded(
                                  child: Text(
                                    "Kelas",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                ),
                              ),
                              DataColumn(
                                label: Expanded(
                                  child: Text(
                                    "Aksi",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                ),
                              ),
                            ],
                            rows: List<DataRow>.generate(
                              state.courses.length,
                              (index) {
                                Course course = state.courses[index];
                                return DataRow(
                                  cells: [
                                    DataCell(
                                      Text("${index + 1}"),
                                    ),
                                    DataCell(
                                      Text(course.name),
                                    ),
                                    DataCell(
                                      Text(course.claass),
                                    ),
                                    DataCell(
                                      Row(
                                        children: [
                                          DetailIB(
                                            onPress: () {
                                              Navigator.pushNamed(context,
                                                  "/admin/course/detail",
                                                  arguments: {
                                                    "courseId": course.id
                                                  });
                                            },
                                          ),
                                          EditIB(
                                            onPress: () {
                                              Navigator.pushNamed(
                                                  context, "/admin/course/edit",
                                                  arguments: {
                                                    "courseId": course.id,
                                                  });
                                            },
                                          ),
                                          IconButton(
                                            onPressed: () {
                                              showDialog(
                                                context: context,
                                                builder: (context) {
                                                  return BlocConsumer<
                                                      CourseBloc, CourseState>(
                                                    listener: (context, state) {
                                                      if (state
                                                          is CourseDeleteSuccess) {
                                                        Navigator.of(context)
                                                            .pop();
                                                        courseBloc.add(
                                                            GetAllCourseEvent());
                                                        showCostumSnackBar(
                                                          context: context,
                                                          message:
                                                              "Mapel Behasil Dihapus",
                                                          type: "success",
                                                        );
                                                      } else if (state
                                                          is CourseFailure) {
                                                        courseBloc.add(
                                                            GetAllCourseEvent());
                                                        Navigator.of(context)
                                                            .pop();
                                                        showCostumSnackBar(
                                                          context: context,
                                                          message:
                                                              "Mapel Gagal Dihapus",
                                                          type: "danger",
                                                        );
                                                      }
                                                    },
                                                    builder: (context, state) {
                                                      return AlertDialog(
                                                        title: const Text(
                                                          "Konfirmasi Hapus",
                                                          textAlign:
                                                              TextAlign.center,
                                                        ),
                                                        content: state
                                                                is CourseLoading
                                                            ? const Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .center,
                                                                children: [
                                                                  CircularProgressIndicator(),
                                                                ],
                                                              )
                                                            : Text(
                                                                "Yakin Ingin Menghapus ${course.name}?",
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                              ),
                                                        actions: [
                                                          TextButton(
                                                            onPressed: () {
                                                              Navigator.of(
                                                                      context)
                                                                  .pop();
                                                            },
                                                            child: const Text(
                                                                "Tidak"),
                                                          ),
                                                          TextButton(
                                                            onPressed: () {
                                                              courseBloc.add(
                                                                  DeleteCourseEvent(
                                                                      id: course
                                                                          .id));
                                                            },
                                                            child: const Text(
                                                                "Ya"),
                                                          ),
                                                        ],
                                                      );
                                                    },
                                                  );
                                                },
                                              );
                                            },
                                            icon: const Icon(
                                              Icons.delete,
                                              color: Colors.red,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                );
                              },
                            ),
                          ),
                        );
                      }
                      return Container();
                    },
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
