import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student_attendance/bloc/admin/student/student_bloc.dart';
import 'package:student_attendance/components/admin/my_app_bar.dart';
import 'package:student_attendance/components/admin/my_drawer.dart';
import 'package:student_attendance/components/loading_button.dart';
import 'package:student_attendance/components/my_snack_bar.dart';
import 'package:student_attendance/cubit/drop_down_value_cubit.dart';
import 'package:student_attendance/models/admin/student.dart';
import 'package:student_attendance/values/theme.dart';

class AdminEditStudentPage extends StatelessWidget {
  AdminEditStudentPage(
      {super.key, required this.studentId, required this.claassId});
  final int claassId;
  final int studentId;
  final nisController = TextEditingController();
  final nameController = TextEditingController();
  final genderValue = DropDownValueCubit();

  @override
  Widget build(BuildContext context) {
    StudentBloc studentBloc = context.read<StudentBloc>();
    studentBloc.add(GetDetailStudentEvent(studentId: studentId));
    return WillPopScope(
      onWillPop: () async {
        studentBloc.add(GetAllStudentEvent(claassId: claassId));
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
                          "Edit Siswa",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          "Ubah/Edit Siswa pada colom di bawah",
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
                        studentBloc.add(GetAllStudentEvent(claassId: claassId));
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
                    child: BlocConsumer<StudentBloc, StudentState>(
                      listener: (context, state) {
                        if (state is StudentDetailSuccess) {
                          Student student = state.student;
                          nisController.text = student.nis;
                          nameController.text = student.name;
                          if (student.gender != null) {
                            genderValue.changeValue(student.gender.toString());
                          }
                        }
                      },
                      builder: (context, state) {
                        return Column(
                          children: [
                            TextField(
                              controller: nisController,
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                label: Text("NIS"),
                              ),
                              textInputAction: TextInputAction.next,
                            ),
                            const SizedBox(height: 25),
                            TextField(
                              controller: nameController,
                              decoration: const InputDecoration(
                                label: Text("Nama"),
                              ),
                              textInputAction: TextInputAction.next,
                            ),
                            const SizedBox(height: 25),
                            DropdownButtonFormField(
                              value: genderValue.state != ""
                                  ? genderValue.state
                                  : null,
                              hint: const Text("Jenis Kelamin"),
                              items: const [
                                DropdownMenuItem(
                                  value: "male",
                                  child: Text("Laki-Laki"),
                                ),
                                DropdownMenuItem(
                                  value: "female",
                                  child: Text("Perempuan"),
                                ),
                              ],
                              onChanged: (value) {
                                genderValue.changeValue("$value");
                              },
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: BlocConsumer<StudentBloc, StudentState>(
                      builder: (context, state) {
                        if (state is StudentLoading) {
                          return const LoadingButton();
                        }
                        return ElevatedButton(
                          onPressed: () {
                            state is StudentLoading
                                ? null
                                : studentBloc.add(EditStudentEvent(
                                    id: studentId,
                                    nis: nisController.text,
                                    name: nameController.text,
                                    gender: genderValue.state,
                                    classId: claassId.toString(),
                                  ));
                          },
                          child: Text(
                            state is StudentLoading ? "Simpan..." : "Simpan",
                          ),
                        );
                      },
                      listener: (context, state) {
                        if (state is StudentEditSuccess) {
                          Navigator.pop(context);
                          studentBloc
                              .add(GetAllStudentEvent(claassId: claassId));
                          showCostumSnackBar(
                            context: context,
                            message: "Siswa Berhasil Diedit",
                            type: "success",
                          );
                        } else if (state is StudentValidationError) {
                          showCostumSnackBar(
                            context: context,
                            message: state.message,
                            type: "danger",
                          );
                        }
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
