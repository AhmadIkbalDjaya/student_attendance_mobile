import 'package:flutter/material.dart';
import 'package:student_attendance/bloc/admin/semester/semester_bloc.dart';
import 'package:student_attendance/components/admin/button/edit_icon_button.dart';
import 'package:student_attendance/components/admin/my_app_bar.dart';
import 'package:student_attendance/components/admin/my_drawer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student_attendance/components/center_loading.dart';
import 'package:student_attendance/components/loading_button.dart';
import 'package:student_attendance/components/my_snack_bar.dart';
import 'package:student_attendance/cubit/drop_down_value_cubit.dart';
import 'package:student_attendance/models/admin/semester.dart';

class AdminSemesterPage extends StatelessWidget {
  AdminSemesterPage({super.key});
  final activeSemesterValue = DropDownValueCubit();

  @override
  Widget build(BuildContext context) {
    SemesterBloc semesterBloc = context.read<SemesterBloc>();
    SemesterBloc semesterBloc2 = SemesterBloc();
    semesterBloc.add(GetAllSemesterEvent());
    semesterBloc2.add(GetAllSemesterEvent());
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
                  "Semester",
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Text(
                  "Tambah, Edit atau Hapus Semester",
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, "/admin/semester/create");
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF696CFF),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(20),
                      ),
                    ),
                  ),
                  child: const Text("Tambah Semester"),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Semester Aktif",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        BlocConsumer<SemesterBloc, SemesterState>(
                          bloc: semesterBloc2,
                          listener: (context, state) {
                            if (state is SemesterAllSuccess) {
                              for (var semester in state.semesters) {
                                if (semester.isActive == "1") {
                                  activeSemesterValue.changeValue(
                                    semester.id.toString(),
                                  );
                                }
                              }
                            }
                          },
                          builder: (context, state) {
                            if (state is SemesterAllSuccess) {
                              return SizedBox(
                                width: 200,
                                height: 35,
                                child: DropdownButtonFormField(
                                  decoration: InputDecoration(
                                    contentPadding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  isExpanded: true,
                                  value: activeSemesterValue.state != ""
                                      ? activeSemesterValue.state
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
                                                ? const Icon(Icons.done_rounded)
                                                : Container()
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                                  onChanged: (value) {
                                    activeSemesterValue.changeValue(
                                      value.toString(),
                                    );
                                  },
                                ),
                              );
                            }
                            return SizedBox(
                              width: 200,
                              height: 35,
                              child: DropdownButtonFormField(
                                decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                isExpanded: true,
                                value: activeSemesterValue.state != ""
                                    ? activeSemesterValue.state
                                    : null,
                                items: const [],
                                onChanged: (value) {
                                  activeSemesterValue.changeValue(
                                    value.toString(),
                                  );
                                },
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 15),
                      child: BlocConsumer<SemesterBloc, SemesterState>(
                        bloc: semesterBloc2,
                        listener: (context, state) {
                          if (state is SemesterChangeSuccess) {
                            semesterBloc.add(GetAllSemesterEvent());
                            semesterBloc2.add(GetAllSemesterEvent());
                            showCostumSnackBar(
                              context: context,
                              message: "Semester berhasil diubah",
                              type: "success",
                            );
                          } else if (state is SemesterValidationError) {
                            showCostumSnackBar(
                              context: context,
                              message: "Semester Gagal diubah",
                              type: "danger",
                            );
                          }
                        },
                        builder: (context, state) {
                          if (state is SemesterLoading) {
                            return const LoadingButton();
                          }
                          return ElevatedButton(
                            onPressed: () {
                              semesterBloc2.add(ChangeSemesterEvent(
                                id: activeSemesterValue.state,
                              ));
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF696CFF),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            child: const Text("Ubah Semester"),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 3),
              child: ListView(
                children: [
                  BlocBuilder<SemesterBloc, SemesterState>(
                    builder: (context, state) {
                      if (state is SemesterGetLoading) {
                        return const CenterLoading();
                      }
                      if (state is SemesterAllSuccess) {
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
                                    "Semester",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                ),
                              ),
                              DataColumn(
                                label: Expanded(
                                  child: Text(
                                    "Status",
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
                              state.semesters.length,
                              (index) {
                                Semester semester = state.semesters[index];
                                return DataRow(
                                  cells: [
                                    DataCell(
                                      Text("${index + 1}"),
                                    ),
                                    DataCell(
                                      Text(
                                        semester.oddEven == "1"
                                            ? "Ganjil ${semester.startYear}/${semester.endYear}"
                                            : "Genap ${semester.startYear}/${semester.endYear}",
                                      ),
                                    ),
                                    DataCell(
                                      Text(semester.isActive == "1"
                                          ? "Aktif"
                                          : "Nonaktif"),
                                    ),
                                    DataCell(
                                      Row(
                                        children: [
                                          EditIB(
                                            onPress: () {
                                              Navigator.pushNamed(context,
                                                  "/admin/semester/edit",
                                                  arguments: {
                                                    "semesterId": semester.id
                                                  });
                                            },
                                          ),
                                          IconButton(
                                            onPressed: () {
                                              showDialog(
                                                context: context,
                                                builder: (context) {
                                                  return BlocConsumer<
                                                      SemesterBloc,
                                                      SemesterState>(
                                                    listener: (context, state) {
                                                      if (state
                                                          is SemesterDeleteSuccess) {
                                                        Navigator.of(context)
                                                            .pop();
                                                        semesterBloc.add(
                                                            GetAllSemesterEvent());
                                                        showCostumSnackBar(
                                                          context: context,
                                                          message:
                                                              "Kelas Behasil Dihapus",
                                                          type: "success",
                                                        );
                                                      } else if (state
                                                          is SemesterFailure) {
                                                        semesterBloc.add(
                                                            GetAllSemesterEvent());
                                                        Navigator.of(context)
                                                            .pop();
                                                        showCostumSnackBar(
                                                          context: context,
                                                          message:
                                                              "Kelas Gagal Dihapus",
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
                                                                is SemesterLoading
                                                            ? const Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .center,
                                                                children: [
                                                                  CircularProgressIndicator(),
                                                                ],
                                                              )
                                                            : const Text(
                                                                "Yakin Ingin Menghapus Semester?",
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
                                                              semesterBloc.add(
                                                                  DeleteSemesterEvent(
                                                                      id: semester
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
                            // DataRow(
                            //     cells: [
                            //       DataCell(
                            //         Text("1"),
                            //       ),
                            //       DataCell(
                            //         Text("Ganjil 2022/2023"),
                            //       ),
                            //       DataCell(
                            //         Text("Aktif"),
                            //       ),
                            //       DataCell(
                            //         Row(
                            //           children: [
                            //             EditIB(),
                            //             DeleteIB(),
                            //           ],
                            //         ),
                            //       ),
                            //     ],
                            //   ),
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
