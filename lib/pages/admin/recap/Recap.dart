import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:student_attendance/bloc/admin/admin_recap/admin_recap_bloc.dart';
import 'package:student_attendance/components/admin/button/detail_icon_button.dart';
import 'package:student_attendance/components/admin/my_app_bar.dart';
import 'package:student_attendance/components/admin/my_drawer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student_attendance/components/my_snack_bar.dart';
import 'package:student_attendance/models/admin/admin_recap.dart';
import 'package:student_attendance/values/theme.dart';

class AdminRecapPage extends StatelessWidget {
  const AdminRecapPage({super.key});

  @override
  Widget build(BuildContext context) {
    AdminRecapBloc adminRecapBloc = context.read<AdminRecapBloc>();
    adminRecapBloc.add(GetAdminRecapEvent());
    return Scaffold(
      appBar: const MyAppBar(),
      drawer: const MyDrawer(),
      body: Column(
        children: [
          Container(
            decoration: CustomTheme.headerDecoration(),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 25),
            width: double.infinity,
            child: const Column(
              children: [
                Text(
                  "Rekap Absensi",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  "Rekap Absensi Mata Pelajaran Semester ini",
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
              padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 3),
              child: BlocConsumer<AdminRecapBloc, AdminRecapState>(
                listener: (context, state) {
                  if (state is AdminRecapFailure) {
                    showCostumSnackBar(
                      context: context,
                      message: state.message,
                      type: "danger",
                    );
                  }
                },
                builder: (context, state) {
                  return Skeletonizer(
                    enabled: state is! AdminRecapSuccess,
                    child: ListView(
                      children: [
                        SingleChildScrollView(
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
                                    "Mata Pelajaran",
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
                                    "Aksi",
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            ],
                            rows: List<DataRow>.generate(
                              state is AdminRecapSuccess
                                  ? state.adminRecap.length
                                  : dummyAdminRecap.length,
                              (index) {
                                AdminRecap adminRecap =
                                    state is AdminRecapSuccess
                                        ? state.adminRecap[index]
                                        : dummyAdminRecap[0];
                                return DataRow(
                                  cells: [
                                    DataCell(
                                      Center(child: Text("${index + 1}")),
                                    ),
                                    DataCell(
                                      Text(adminRecap.course),
                                    ),
                                    DataCell(
                                      Text(adminRecap.claass),
                                    ),
                                    DataCell(
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          DetailIB(
                                            onPress: () {
                                              Navigator.pushNamed(context,
                                                  "/admin/recap/course",
                                                  arguments: {
                                                    "courseId": adminRecap.id,
                                                  });
                                            },
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
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
