import 'package:flutter/material.dart';
import 'package:student_attendance/bloc/admin/claass/claass_bloc.dart';
import 'package:student_attendance/components/admin/button/edit_icon_button.dart';
import 'package:student_attendance/components/admin/my_app_bar.dart';
import 'package:student_attendance/components/admin/my_drawer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student_attendance/components/center_loading.dart';
import 'package:student_attendance/components/my_snack_bar.dart';
import 'package:student_attendance/models/admin/claass.dart';

class AdminClaassPage extends StatelessWidget {
  const AdminClaassPage({super.key});

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
            decoration: const BoxDecoration(
              color: Color(0xFFD9D9D9),
            ),
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Kelas",
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Text(
                  "Tambah, Edit atau Hapus Kelas",
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, "/admin/claass/create");
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF696CFF),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(20),
                      ),
                    ),
                  ),
                  child: const Text("Tambah Kelas"),
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
                      if (state is ClaassGetLoading) {
                        return const CenterLoading();
                      }
                      if (state is ClaassAllSuccess) {
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
                                    "Nama Kelas",
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
                                    "Jurusan",
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
                            rows: List<DataRow>.generate(state.claasses.length,
                                (index) {
                              Claass claass = state.claasses[index];
                              return DataRow(
                                cells: [
                                  DataCell(
                                    Text("${index + 1}"),
                                  ),
                                  DataCell(
                                    Text(claass.name),
                                  ),
                                  DataCell(
                                    Text(claass.level),
                                  ),
                                  DataCell(
                                    Text(claass.major),
                                  ),
                                  DataCell(
                                    Row(
                                      children: [
                                        EditIB(
                                          onPress: () {
                                            Navigator.pushNamed(
                                                context, "/admin/claass/edit",
                                                arguments: {
                                                  "claassId": claass.id,
                                                });
                                          },
                                        ),
                                        IconButton(
                                          onPressed: () {
                                            showDialog(
                                              context: context,
                                              builder: (context) {
                                                return BlocConsumer<ClaassBloc,
                                                    ClaassState>(
                                                  listener: (context, state) {
                                                    if (state
                                                        is ClaassDeleteSuccess) {
                                                      Navigator.of(context)
                                                          .pop();
                                                      claassBloc.add(
                                                          GetAllClaassEvent());
                                                      showCostumSnackBar(
                                                        context: context,
                                                        message:
                                                            "Kelas Behasil Dihapus",
                                                        type: "success",
                                                      );
                                                    } else if (state
                                                        is ClaassFailure) {
                                                      claassBloc.add(
                                                          GetAllClaassEvent());
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
                                                      content:
                                                          state is ClaassLoading
                                                              ? const Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .center,
                                                                  children: [
                                                                    CircularProgressIndicator(),
                                                                  ],
                                                                )
                                                              : Text(
                                                                  "Yakin Ingin Menghapus ${claass.name}?",
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
                                                            claassBloc.add(
                                                                DeleteClaassEvent(
                                                                    id: claass
                                                                        .id));
                                                          },
                                                          child:
                                                              const Text("Ya"),
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
                            }),
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
