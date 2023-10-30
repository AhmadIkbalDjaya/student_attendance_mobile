import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student_attendance/bloc/admin/student/student_bloc.dart';
import 'package:student_attendance/components/admin/button/delete_icon_button.dart';
import 'package:student_attendance/components/admin/button/detail_icon_button.dart';
import 'package:student_attendance/components/admin/button/edit_icon_button.dart';
import 'package:student_attendance/components/admin/my_app_bar.dart';
import 'package:student_attendance/components/admin/my_drawer.dart';

class AdminStudentPage extends StatelessWidget {
  const AdminStudentPage({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<StudentBloc>().add(GetAllStudentEvent());
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
                      if (state is StudentLoading) {
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
                      if (state is StudentSuccess) {
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
                              (index) => DataRow(
                                cells: [
                                  DataCell(
                                    Text("${index + 1}"),
                                  ),
                                  DataCell(
                                    Text(state.students[index].nis),
                                  ),
                                  DataCell(
                                    Text(state.students[index].name),
                                  ),
                                  DataCell(
                                    Row(
                                      children: [
                                        DetailIB(
                                          route: "/admin/student/detail",
                                          id: state.students[index].id,
                                        ),
                                        const EditIB(
                                            route: "/admin/student/edit"),
                                        const DeleteIB(),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }
                      return const Text("No Data");
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
