import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:student_attendance/bloc/admin/about_us/about_us_bloc.dart';
import 'package:student_attendance/components/admin/button/detail_icon_button.dart';
import 'package:student_attendance/components/admin/button/edit_icon_button.dart';
import 'package:student_attendance/components/admin/my_app_bar.dart';
import 'package:student_attendance/components/admin/my_drawer.dart';
import 'package:student_attendance/components/my_snack_bar.dart';
import 'package:student_attendance/models/about_us.dart';
import 'package:student_attendance/values/theme.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AdminAboutUsPage extends StatelessWidget {
  const AdminAboutUsPage({super.key});

  @override
  Widget build(BuildContext context) {
    AboutUsBloc aboutUsBloc = context.read<AboutUsBloc>();
    aboutUsBloc.add(GetAllAboutUsEvent());
    return Scaffold(
      appBar: const MyAppBar(),
      drawer: const MyDrawer(),
      body: Column(
        children: [
          Container(
            decoration: CustomTheme.headerDecoration(),
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "AboutUs",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Text(
                  "Tambah, Edit atau Hapus AboutUs",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, "/admin/aboutUs/create");
                  },
                  child: const Text("Tambah AboutUs"),
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 3),
              child: ListView(
                children: [
                  BlocBuilder<AboutUsBloc, AboutUsState>(
                    builder: (context, state) {
                      return Skeletonizer(
                        enabled: state is! AboutUsAllSuccess,
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
                                    "Nama",
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                              DataColumn(
                                label: Expanded(
                                  child: Text(
                                    "Posisi / Jabatan",
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
                              state is AboutUsAllSuccess
                                  ? state.aboutUses.length
                                  : dummtAboutUses.length,
                              (index) {
                                AboutUs aboutUs = state is AboutUsAllSuccess
                                    ? state.aboutUses[index]
                                    : dummtAboutUses[index];
                                return DataRow(
                                  cells: [
                                    DataCell(
                                      Center(child: Text("${index + 1}")),
                                    ),
                                    DataCell(
                                      Text(aboutUs.name),
                                    ),
                                    DataCell(
                                      Text(aboutUs.position),
                                    ),
                                    DataCell(
                                      Row(
                                        children: [
                                          DetailIB(
                                            onPress: () {
                                              Navigator.pushNamed(
                                                context,
                                                "/admin/aboutUs/detail",
                                                arguments: {
                                                  "aboutUsId": aboutUs.id,
                                                },
                                              );
                                            },
                                          ),
                                          EditIB(
                                            onPress: () {
                                              Navigator.pushNamed(
                                                context,
                                                "/admin/aboutUs/edit",
                                                arguments: {
                                                  "aboutUsId": aboutUs.id,
                                                },
                                              );
                                            },
                                          ),
                                          IconButton(
                                            onPressed: () {
                                              showDialog(
                                                context: context,
                                                builder: (context) {
                                                  return BlocConsumer<
                                                      AboutUsBloc,
                                                      AboutUsState>(
                                                    listener: (context, state) {
                                                      if (state
                                                          is AboutUsDeleteSuccess) {
                                                        Navigator.of(context)
                                                            .pop();
                                                        aboutUsBloc.add(
                                                            GetAllAboutUsEvent());
                                                        showCostumSnackBar(
                                                          context: context,
                                                          message:
                                                              "AboutUs Behasil Dihapus",
                                                          type: "success",
                                                        );
                                                      } else if (state
                                                          is AboutUsFailure) {
                                                        Navigator.of(context)
                                                            .pop();
                                                        aboutUsBloc.add(
                                                            GetAllAboutUsEvent());
                                                        showCostumSnackBar(
                                                          context: context,
                                                          message:
                                                              "AboutUs Gagal Dihapus",
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
                                                                is AboutUsLoading
                                                            ? const Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .center,
                                                                children: [
                                                                  CircularProgressIndicator(),
                                                                ],
                                                              )
                                                            : Text(
                                                                "Yakin Ingin Menghapus ${aboutUs.name}?",
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
                                                              aboutUsBloc.add(
                                                                DeleteAboutUsEvent(
                                                                  id: aboutUs
                                                                      .id,
                                                                ),
                                                              );
                                                            },
                                                            child: const Text(
                                                              "Ya",
                                                            ),
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
