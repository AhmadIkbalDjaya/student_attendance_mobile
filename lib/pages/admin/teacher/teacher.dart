import 'package:flutter/material.dart';
import 'package:student_attendance/bloc/admin/teacher/teacher_bloc.dart';
import 'package:student_attendance/components/admin/button/detail_icon_button.dart';
import 'package:student_attendance/components/admin/button/edit_icon_button.dart';
import 'package:student_attendance/components/admin/my_app_bar.dart';
import 'package:student_attendance/components/admin/my_drawer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student_attendance/components/my_snack_bar.dart';
import 'package:student_attendance/models/admin/teacher.dart';

class AdminTeacherPage extends StatelessWidget {
  const AdminTeacherPage({super.key});

  @override
  Widget build(BuildContext context) {
    TeacherBloc teacherBloc = context.read<TeacherBloc>();
    teacherBloc.add(GetAllTeacherEvent());
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
                  "Guru",
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Text(
                  "Tambah, Edit atau Hapus Guru",
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, "/admin/teacher/create");
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF696CFF),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(20),
                      ),
                    ),
                  ),
                  child: const Text("Tambah Guru"),
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 3),
              child: ListView(
                children: [
                  BlocBuilder<TeacherBloc, TeacherState>(
                    builder: (context, state) {
                      if (state is TeacherGetLoading) {
                        return const Padding(
                          padding: EdgeInsets.symmetric(vertical: 50),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CircularProgressIndicator(),
                            ],
                          ),
                        );
                      }
                      if (state is TeacherAllSuccess) {
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
                                      "NIP",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                  ),
                                ),
                                DataColumn(
                                  label: Expanded(
                                    child: Text(
                                      "Nama",
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
                                state.teachers.length,
                                (index) {
                                  Teacher teacher = state.teachers[index];
                                  return DataRow(
                                    cells: [
                                      DataCell(
                                        Text("${index + 1}"),
                                      ),
                                      DataCell(
                                        Text(teacher.username),
                                      ),
                                      DataCell(
                                        Text(teacher.name),
                                      ),
                                      DataCell(
                                        Row(
                                          children: [
                                            DetailIB(
                                              onPress: () {
                                                Navigator.pushNamed(context,
                                                    "/admin/teacher/detail",
                                                    arguments: {
                                                      "teacherId": teacher.id,
                                                    });
                                              },
                                            ),
                                            EditIB(
                                              onPress: () {
                                                Navigator.pushNamed(context,
                                                    "/admin/teacher/edit",
                                                    arguments: {
                                                      "teacherId": teacher.id,
                                                    });
                                              },
                                            ),
                                            IconButton(
                                              onPressed: () {
                                                showDialog(
                                                  context: context,
                                                  builder: (context) {
                                                    return BlocConsumer<
                                                        TeacherBloc,
                                                        TeacherState>(
                                                      listener:
                                                          (context, state) {
                                                        if (state
                                                            is TeacherDeleteSuccess) {
                                                          Navigator.of(context)
                                                              .pop();
                                                          teacherBloc.add(
                                                              GetAllTeacherEvent());
                                                          showCostumSnackBar(
                                                            context: context,
                                                            message:
                                                                "Guru Behasil Dihapus",
                                                            type: "success",
                                                          );
                                                        } else if (state
                                                            is TeacherFailure) {
                                                          Navigator.of(context)
                                                              .pop();
                                                          teacherBloc.add(
                                                              GetAllTeacherEvent());
                                                          showCostumSnackBar(
                                                            context: context,
                                                            message:
                                                                "Guru Gagal Dihapus",
                                                            type: "danger",
                                                          );
                                                        }
                                                      },
                                                      builder:
                                                          (context, state) {
                                                        return AlertDialog(
                                                          title: const Text(
                                                            "Konfirmasi Hapus",
                                                            textAlign: TextAlign
                                                                .center,
                                                          ),
                                                          content: state
                                                                  is TeacherLoading
                                                              ? const Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .center,
                                                                  children: [
                                                                    CircularProgressIndicator(),
                                                                  ],
                                                                )
                                                              : Text(
                                                                  "Yakin Ingin Menghapus ${teacher.name}?",
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
                                                                teacherBloc.add(
                                                                    DeleteTeacherEvent(
                                                                        id: teacher
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
                              )),
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
