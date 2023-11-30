import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:student_attendance/bloc/admin/claass/claass_bloc.dart';
import 'package:student_attendance/components/admin/my_app_bar.dart';
import 'package:student_attendance/components/admin/my_drawer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student_attendance/models/admin/claass.dart';
import 'package:student_attendance/values/theme.dart';

class AdminStudentClaassPage extends StatelessWidget {
  const AdminStudentClaassPage({super.key});

  @override
  Widget build(BuildContext context) {
    ClaassBloc claassBloc = context.read<ClaassBloc>();
    claassBloc.add(GetAllClaassEvent());
    return Scaffold(
      appBar: const MyAppBar(),
      drawer: const MyDrawer(),
      body: Column(
        children: [
          Container(
            decoration: CustomTheme.headerDecoration(),
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
            width: double.infinity,
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Kelas Siswa",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "Pilih Kelas Untuk Mengelolah Siswa",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 3),
              child: ListView(
                children: [
                  BlocBuilder<ClaassBloc, ClaassState>(
                    builder: (context, state) {
                      return Skeletonizer(
                        enabled: state is! ClaassAllSuccess,
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
                                    "Nama Kelas",
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                              DataColumn(
                                label: Expanded(
                                  child: Text(
                                    "Kelas",
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                              DataColumn(
                                label: Expanded(
                                  child: Text(
                                    "Jurusan",
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
                                state is ClaassAllSuccess
                                    ? state.claasses.length
                                    : dummyClaasses.length, (index) {
                              Claass claass = state is ClaassAllSuccess
                                  ? state.claasses[index]
                                  : dummyClaasses[index];
                              return DataRow(
                                cells: [
                                  DataCell(
                                    Center(child: Text("${index + 1}")),
                                  ),
                                  DataCell(
                                    Text(claass.name),
                                  ),
                                  DataCell(
                                    Center(child: Text(claass.level)),
                                  ),
                                  DataCell(
                                    Center(child: Text(claass.major)),
                                  ),
                                  DataCell(
                                    IconButton(
                                      onPressed: () {
                                        Navigator.pushNamed(
                                          context,
                                          "/admin/student",
                                          arguments: {
                                            "claassId": claass.id,
                                            "claassName": claass.name,
                                          },
                                        );
                                      },
                                      icon: const Icon(
                                        Icons.remove_red_eye,
                                        color: Colors.blueAccent,
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            }),
                          ),
                        ),
                      );
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
