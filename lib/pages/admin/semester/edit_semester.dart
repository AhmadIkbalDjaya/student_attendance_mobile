import 'package:flutter/material.dart';
import 'package:student_attendance/bloc/admin/semester/semester_bloc.dart';
import 'package:student_attendance/components/admin/my_app_bar.dart';
import 'package:student_attendance/components/admin/my_drawer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student_attendance/components/my_snack_bar.dart';
import 'package:student_attendance/cubit/drop_down_value_cubit.dart';
import 'package:student_attendance/models/admin/semester.dart';
import 'package:student_attendance/values/theme.dart';

class AdminEditSemesterPage extends StatelessWidget {
  AdminEditSemesterPage({super.key, required this.semesterId});
  final int semesterId;
  final oddEvenValue = DropDownValueCubit();
  final startYear = DropDownValueCubit();

  @override
  Widget build(BuildContext context) {
    SemesterBloc semesterBloc = context.read<SemesterBloc>();
    semesterBloc.add(GetDetailSemesterEvent(semesterId: semesterId));
    return WillPopScope(
      onWillPop: () async {
        semesterBloc.add(GetAllSemesterEvent());
        return true;
      },
      child: Scaffold(
        appBar: const MyAppBar(),
        drawer: const MyDrawer(),
        body: Column(
          children: [
            Container(
              decoration: CustomTheme.headerDecoration(),
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
                          "Edit Semester",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          "Ubah/Edit Semester pada colom dibawah",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    top: 0,
                    left: 0,
                    child: BackButton(
                      color: Colors.white,
                      onPressed: () {
                        Navigator.pop(context);
                        semesterBloc.add(GetAllSemesterEvent());
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
                    decoration: CustomTheme.contentDecoration(),
                    child: BlocConsumer<SemesterBloc, SemesterState>(
                      listener: (context, state) {
                        if (state is SemesterDetailSuccess) {
                          Semester semester = state.semester;
                          oddEvenValue.changeValue(semester.oddEven);
                          startYear.changeValue(semester.startYear);
                        }
                      },
                      builder: (context, state) {
                        return Column(
                          children: [
                            const Text(
                              "Semester",
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(height: 10),
                            SizedBox(
                              height: 40,
                              width: double.infinity,
                              child: DropdownButtonFormField(
                                value: oddEvenValue.state != ""
                                    ? oddEvenValue.state
                                    : null,
                                hint: const Text("Semester"),
                                items: const [
                                  DropdownMenuItem(
                                    value: "1",
                                    child: Text("Ganjil"),
                                  ),
                                  DropdownMenuItem(
                                    value: "0",
                                    child: Text("Genap"),
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
                                  oddEvenValue.changeValue(value.toString());
                                },
                              ),
                            ),
                            const SizedBox(height: 25),
                            SizedBox(
                              height: 40,
                              width: double.infinity,
                              child: DropdownButtonFormField(
                                value: startYear.state != ""
                                    ? startYear.state
                                    : null,
                                hint: const Text("Tahun Ajaran"),
                                items: const [
                                  DropdownMenuItem(
                                    value: "2022",
                                    child: Text("2022"),
                                  ),
                                  DropdownMenuItem(
                                    value: "2023",
                                    child: Text("2023"),
                                  ),
                                  DropdownMenuItem(
                                    value: "2024",
                                    child: Text("2024"),
                                  ),
                                  DropdownMenuItem(
                                    value: "2025",
                                    child: Text("2025"),
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
                                  startYear.changeValue(value.toString());
                                },
                              ),
                            ),
                            const SizedBox(height: 25),
                            BlocBuilder<DropDownValueCubit, String>(
                              bloc: startYear,
                              builder: (context, state) {
                                return Container(
                                  width: double.infinity,
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: const Color(0xFF696CFF),
                                      width: 2,
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Column(
                                    children: [
                                      const Text(
                                        "Tahun Ajaran",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                          color: Color(0xFF696CFF),
                                        ),
                                      ),
                                      startYear.state != ""
                                          ? Text(
                                              "${startYear.state} / ${int.parse(startYear.state) + 1}",
                                              style: const TextStyle(
                                                color: Color(0xFF696CFF),
                                                fontWeight: FontWeight.w500,
                                              ),
                                            )
                                          : Container(),
                                    ],
                                  ),
                                );
                              },
                            )
                          ],
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: BlocConsumer<SemesterBloc, SemesterState>(
                      listener: (context, state) {
                        if (state is SemesterEditSuccess) {
                          Navigator.pushNamed(context, "/admin/semester");
                          showCostumSnackBar(
                            context: context,
                            message: "Semester Berhasil Diedit",
                            type: "success",
                          );
                        } else if (state is SemesterValidationError) {
                          showCostumSnackBar(
                            context: context,
                            message: state.message,
                            type: "danger",
                          );
                        }
                      },
                      builder: (context, state) {
                        return ElevatedButton(
                          onPressed: () {
                            state is SemesterLoading
                                ? null
                                : semesterBloc.add(EditSemesterEvent(
                                    id: semesterId,
                                    startYear: startYear.state,
                                    oddEven: oddEvenValue.state,
                                  ));
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF696CFF),
                          ),
                          child: Text(
                            state is SemesterLoading ? "Simpan..." : "Simpan",
                          ),
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
