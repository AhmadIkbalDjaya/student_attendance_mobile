import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student_attendance/bloc/admin/student/student_bloc.dart';
import 'package:student_attendance/components/admin/my_app_bar.dart';
import 'package:student_attendance/components/admin/my_drawer.dart';
import 'package:student_attendance/components/my_snack_bar.dart';
import 'package:student_attendance/cubit/drop_down_value_cubit.dart';
import 'package:student_attendance/values/theme.dart';

class AdminCreateStudentPage extends StatelessWidget {
  AdminCreateStudentPage({super.key, required this.claassId});
  final int claassId;
  final nisController = TextEditingController();
  final nameController = TextEditingController();
  final genderValue = DropDownValueCubit();
  // final claassIdValue = DropDownValueCubit();

  @override
  Widget build(BuildContext context) {
    StudentBloc studentBloc = context.read<StudentBloc>();
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
                          "Tambahkan Siswa",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          "Tambahkan Siswa pada colom di bawah",
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
                    child: Column(
                      children: [
                        TextField(
                          controller: nisController,
                          decoration: const InputDecoration(
                            label: Text("NIS"),
                          ),
                          keyboardType: TextInputType.number,
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
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: BlocConsumer<StudentBloc, StudentState>(
                      builder: (context, state) {
                        return ElevatedButton(
                          onPressed: () {
                            state is StudentLoading
                                ? null
                                : studentBloc.add(AddStudentEvent(
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
                        if (state is StudentAddSuccess) {
                          Navigator.pop(context);
                          studentBloc
                              .add(GetAllStudentEvent(claassId: claassId));
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
