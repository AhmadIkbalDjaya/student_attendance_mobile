import 'package:flutter/material.dart';
import 'package:student_attendance/bloc/admin/claass/claass_bloc.dart';
import 'package:student_attendance/components/admin/my_app_bar.dart';
import 'package:student_attendance/components/admin/my_drawer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student_attendance/components/center_loading.dart';
import 'package:student_attendance/components/loading_button.dart';
import 'package:student_attendance/components/my_snack_bar.dart';
import 'package:student_attendance/cubit/drop_down_value_cubit.dart';
import 'package:student_attendance/models/admin/claass.dart';

class AdminEditClaassPage extends StatelessWidget {
  AdminEditClaassPage({super.key, required this.claassId});
  final int claassId;
  final nameController = TextEditingController();
  final majorValue = DropDownValueCubit();
  final levelValue = DropDownValueCubit();

  @override
  Widget build(BuildContext context) {
    ClaassBloc claassBloc = context.read<ClaassBloc>();
    claassBloc.add(GetDetailClaassEvent(claassId: claassId));
    return WillPopScope(
      onWillPop: () async {
        claassBloc.add(GetAllClaassEvent());
        return true;
      },
      child: Scaffold(
        appBar: const MyAppBar(),
        drawer: const MyDrawer(),
        body: Column(
          children: [
            Container(
              decoration: const BoxDecoration(
                color: Color(0xFFD9D9D9),
              ),
              padding: const EdgeInsets.only(
                  top: 0, bottom: 10, right: 10, left: 10),
              width: double.infinity,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 20),
                    child: Column(
                      children: [
                        Text(
                          "Edit Kelas",
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          "Ubah/Edit Kelas pada colom dibawah",
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    top: 0,
                    left: 0,
                    child: BackButton(
                      onPressed: () {
                        Navigator.pop(context);
                        claassBloc.add(GetAllClaassEvent());
                      },
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(
                      vertical: 20,
                      horizontal: 15,
                    ),
                    padding: const EdgeInsets.symmetric(
                      vertical: 25,
                      horizontal: 10,
                    ),
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(15),
                      ),
                      color: Color(0xFFD9D9D9),
                    ),
                    child: BlocConsumer<ClaassBloc, ClaassState>(
                      listener: (context, state) {
                        if (state is ClaassDetailSuccess) {
                          Claass claass = state.claass;
                          nameController.text = claass.name;
                          majorValue.changeValue(claass.majorId);
                          levelValue.changeValue(claass.level);
                        }
                      },
                      builder: (context, state) {
                        if (state is ClaassGetLoading) {
                          return const CenterLoading();
                        }
                        return Column(
                          children: [
                            SizedBox(
                              height: 40,
                              width: double.infinity,
                              child: DropdownButtonFormField(
                                value: majorValue.state != ""
                                    ? majorValue.state
                                    : null,
                                hint: const Text("Jurusan"),
                                items: const [
                                  DropdownMenuItem(
                                    value: "1",
                                    child: Text("IPA"),
                                  ),
                                  DropdownMenuItem(
                                    value: "2",
                                    child: Text("IPS"),
                                  ),
                                ],
                                decoration: const InputDecoration(
                                  contentPadding:
                                      EdgeInsets.symmetric(horizontal: 10),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(8),
                                    ),
                                  ),
                                ),
                                onChanged: (value) {
                                  majorValue.changeValue(value.toString());
                                },
                              ),
                            ),
                            const SizedBox(height: 25),
                            SizedBox(
                              height: 40,
                              width: double.infinity,
                              child: DropdownButtonFormField(
                                value: levelValue.state != ""
                                    ? levelValue.state
                                    : null,
                                hint: const Text("Kelas"),
                                items: const [
                                  DropdownMenuItem(
                                    value: "10",
                                    child: Text("10"),
                                  ),
                                  DropdownMenuItem(
                                    value: "11",
                                    child: Text("11"),
                                  ),
                                  DropdownMenuItem(
                                    value: "12",
                                    child: Text("12"),
                                  ),
                                ],
                                decoration: const InputDecoration(
                                  contentPadding:
                                      EdgeInsets.symmetric(horizontal: 10),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(8),
                                    ),
                                  ),
                                ),
                                onChanged: (value) {
                                  levelValue.changeValue(value.toString());
                                },
                              ),
                            ),
                            const SizedBox(height: 25),
                            SizedBox(
                              height: 40,
                              child: TextField(
                                controller: nameController,
                                decoration: const InputDecoration(
                                  label: Text("Nama Kelas"),
                                  border: OutlineInputBorder(),
                                  contentPadding: EdgeInsets.symmetric(
                                    horizontal: 10,
                                    vertical: 0,
                                  ),
                                ),
                              ),
                            )
                          ],
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: BlocConsumer<ClaassBloc, ClaassState>(
                      listener: (context, state) {
                        if (state is ClaassEditSuccess) {
                          Navigator.pushNamed(context, "/admin/claass");
                          showCostumSnackBar(
                            context: context,
                            message: "Kelas Berhasil Diedit",
                            type: "success",
                          );
                        } else if (state is ClaassValidationError) {
                          showCostumSnackBar(
                            context: context,
                            message: state.message,
                            type: "danger",
                          );
                        }
                      },
                      builder: (context, state) {
                        if (state is ClaassLoading) {
                          return const LoadingButton();
                        }
                        return ElevatedButton(
                          onPressed: () {
                            claassBloc.add(EditClaassEvent(
                                id: claassId,
                                level: levelValue.state,
                                majorId: majorValue.state,
                                name: nameController.text));
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF696CFF),
                          ),
                          child: const Text("Simpan"),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
