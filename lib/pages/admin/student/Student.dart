import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student_attendance/bloc/admin/student/student_bloc.dart';
import 'package:student_attendance/components/admin/button/detail_icon_button.dart';
import 'package:student_attendance/components/admin/button/edit_icon_button.dart';
import 'package:student_attendance/components/admin/my_app_bar.dart';
import 'package:student_attendance/components/admin/my_drawer.dart';
import 'package:student_attendance/components/center_loading.dart';
import 'package:student_attendance/components/my_snack_bar.dart';
import 'package:student_attendance/models/admin/student.dart';

class AdminStudentPage extends StatelessWidget {
  const AdminStudentPage({super.key});

  @override
  Widget build(BuildContext context) {
    StudentBloc studentBloc = context.read<StudentBloc>();
    studentBloc.add(GetAllStudentEvent());
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
                  "Siswa",
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Text(
                  "Tambah, Edit atau Hapus Siswa",
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, "/admin/student/create");
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF696CFF),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(20),
                      ),
                    ),
                  ),
                  child: const Text("Tambah Siswa"),
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 3),
              child: ListView(
                children: [
                  BlocBuilder<StudentBloc, StudentState>(
                    builder: (context, state) {
                      if (state is StudentGetLoading) {
                        return const CenterLoading();
                      }
                      if (state is StudentAllSuccess) {
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
                                    "NIS",
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
                              state.students.length,
                              (index) {
                                Student student = state.students[index];
                                return DataRow(
                                  cells: [
                                    DataCell(
                                      Text("${index + 1}"),
                                    ),
                                    DataCell(
                                      Text(student.nis),
                                    ),
                                    DataCell(
                                      Text(student.name),
                                    ),
                                    DataCell(
                                      Row(
                                        children: [
                                          DetailIB(
                                            onPress: () {
                                              Navigator.pushNamed(context,
                                                  '/admin/student/detail',
                                                  arguments: {
                                                    "studentId": student.id
                                                  });
                                            },
                                          ),
                                          EditIB(
                                            onPress: () {
                                              Navigator.pushNamed(context,
                                                  "/admin/student/edit",
                                                  arguments: {
                                                    "studentId": student.id
                                                  });
                                            },
                                          ),
                                          IconButton(
                                            onPressed: () {
                                              showDialog(
                                                context: context,
                                                builder: (context) {
                                                  return BlocConsumer<
                                                      StudentBloc,
                                                      StudentState>(
                                                    listener: (context, state) {
                                                      if (state
                                                          is StudentDeleteSuccess) {
                                                        Navigator.of(context)
                                                            .pop();
                                                        studentBloc.add(
                                                            GetAllStudentEvent());
                                                        showCostumSnackBar(
                                                          context: context,
                                                          message:
                                                              "Siswa Behasil Dihapus",
                                                          type: "success",
                                                        );
                                                      } else if (state
                                                          is StudentFailure) {
                                                        studentBloc.add(
                                                            GetAllStudentEvent());
                                                        Navigator.of(context)
                                                            .pop();
                                                        showCostumSnackBar(
                                                          context: context,
                                                          message:
                                                              "Siswa Gagal Dihapus",
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
                                                                is StudentLoading
                                                            ? const Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .center,
                                                                children: [
                                                                  CircularProgressIndicator(),
                                                                ],
                                                              )
                                                            : Text(
                                                                "Yakin Ingin Menghapus ${student.name}?",
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
                                                              studentBloc.add(
                                                                  DeleteStudentEvent(
                                                                      id: student
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
