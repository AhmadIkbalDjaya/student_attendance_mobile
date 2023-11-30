import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:student_attendance/bloc/admin/student/student_bloc.dart';
import 'package:student_attendance/components/admin/button/detail_icon_button.dart';
import 'package:student_attendance/components/admin/button/edit_icon_button.dart';
import 'package:student_attendance/components/admin/my_app_bar.dart';
import 'package:student_attendance/components/admin/my_drawer.dart';
import 'package:student_attendance/components/center_loading.dart';
import 'package:student_attendance/components/my_snack_bar.dart';
import 'package:student_attendance/models/admin/student.dart';
import 'package:student_attendance/values/theme.dart';

class AdminStudentPage extends StatelessWidget {
  const AdminStudentPage(
      {super.key, required this.claassId, required this.claassName});
  final String claassName;
  final int claassId;
  @override
  Widget build(BuildContext context) {
    StudentBloc studentBloc = context.read<StudentBloc>();
    studentBloc.add(GetAllStudentEvent(claassId: claassId));
    return Scaffold(
      appBar: const MyAppBar(),
      drawer: const MyDrawer(),
      body: Column(
        children: [
          Container(
            decoration: CustomTheme.headerDecoration(),
            padding: const EdgeInsets.symmetric(horizontal: 10),
            width: double.infinity,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Siswa $claassName",
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Text(
                        "Tambah, Edit atau Hapus Siswa",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pushNamed(
                              context,
                              "/admin/student/create",
                              arguments: {"claassId": claassId},
                            );
                          },
                          child: const Text("Tambah Siswa"),
                        ),
                      ),
                    ],
                  ),
                ),
                const Positioned(
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
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 3),
              child: ListView(
                children: [
                  BlocBuilder<StudentBloc, StudentState>(
                    builder: (context, state) {
                      return Skeletonizer(
                        enabled: state is! StudentAllSuccess,
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: DataTable(
                            border: TableBorder.all(
                              width: 2,
                              color: const Color(0xFFACAEFE),
                              borderRadius: BorderRadius.circular(3),
                            ),
                            columns: const [
                              DataColumn(
                                label: Expanded(
                                  child: Text(
                                    "No",
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                              DataColumn(
                                label: Expanded(
                                  child: Text(
                                    "NIS",
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                              DataColumn(
                                label: Expanded(
                                  child: Text(
                                    "Nama",
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                              DataColumn(
                                label: Expanded(
                                  child: Text(
                                    "Aksi",
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            ],
                            rows: List<DataRow>.generate(
                              state is StudentAllSuccess
                                  ? state.students.length
                                  : dummyStudents.length,
                              (index) {
                                Student student = state is StudentAllSuccess
                                    ? state.students[index]
                                    : dummyStudents[index];
                                return DataRow(
                                  cells: [
                                    DataCell(
                                      Center(child: Text("${index + 1}")),
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
                                                    "claassId": claassId,
                                                    "studentId": student.id
                                                  });
                                            },
                                          ),
                                          EditIB(
                                            onPress: () {
                                              Navigator.pushNamed(context,
                                                  "/admin/student/edit",
                                                  arguments: {
                                                    "claassId": claassId,
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
                                                          GetAllStudentEvent(
                                                            claassId: claassId,
                                                          ),
                                                        );
                                                        showCostumSnackBar(
                                                          context: context,
                                                          message:
                                                              "Siswa Behasil Dihapus",
                                                          type: "success",
                                                        );
                                                      } else if (state
                                                          is StudentFailure) {
                                                        studentBloc.add(
                                                          GetAllStudentEvent(
                                                            claassId: claassId,
                                                          ),
                                                        );
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
                                                            ? const CenterLoading()
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
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
