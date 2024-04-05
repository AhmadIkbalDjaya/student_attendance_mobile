import 'package:flutter/material.dart';
import 'package:student_attendance/bloc/admin/teacher/teacher_bloc.dart';
import 'package:student_attendance/components/admin/my_app_bar.dart';
import 'package:student_attendance/components/admin/my_drawer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student_attendance/components/my_snack_bar.dart';
import 'package:student_attendance/cubit/drop_down_value_cubit.dart';
import 'package:student_attendance/models/admin/teacher.dart';
import 'package:student_attendance/values/theme.dart';

class AdminEditTeacherPage extends StatelessWidget {
  AdminEditTeacherPage({super.key, required this.teacherId});
  final int teacherId;
  final nipController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final genderValue = DropDownValueCubit();

  @override
  Widget build(BuildContext context) {
    TeacherBloc teacherBloc = context.read<TeacherBloc>();
    teacherBloc.add(GetDetailTeacherEvent(teacherId: teacherId));
    return WillPopScope(
      onWillPop: () async {
        teacherBloc.add(GetAllTeacherEvent());
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
                          "Edit Guru",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          "Ubah/Edit Guru pada colom dibawah",
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
                        teacherBloc.add(GetAllTeacherEvent());
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
                    child: BlocConsumer<TeacherBloc, TeacherState>(
                      listener: (context, state) {
                        if (state is TeacherDetailSuccess) {
                          Teacher teacher = state.teacher;
                          nipController.text = teacher.username;
                          nameController.text = teacher.name;
                          emailController.text = teacher.email.toString();
                          phoneController.text = teacher.phone.toString();
                          if (teacher.gender != null) {
                            genderValue.changeValue(teacher.gender.toString());
                          }
                        }
                      },
                      builder: (context, state) {
                        return Column(
                          children: [
                            TextField(
                              controller: nipController,
                              decoration: const InputDecoration(
                                label: Text("Username"),
                              ),
                              textInputAction: TextInputAction.next,
                            ),
                            const SizedBox(height: 25),
                            TextField(
                              controller: passwordController,
                              decoration: const InputDecoration(
                                label: Text("Password"),
                                suffixIcon: Icon(Icons.remove_red_eye),
                              ),
                              textInputAction: TextInputAction.next,
                              obscureText: true,
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
                            TextField(
                              controller: emailController,
                              decoration: const InputDecoration(
                                label: Text("Email"),
                              ),
                              textInputAction: TextInputAction.next,
                              keyboardType: TextInputType.emailAddress,
                            ),
                            const SizedBox(height: 25),
                            TextField(
                              controller: phoneController,
                              decoration: const InputDecoration(
                                label: Text("Nomor Telepon"),
                              ),
                              textInputAction: TextInputAction.next,
                              keyboardType: TextInputType.number,
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
                            )
                          ],
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: BlocConsumer<TeacherBloc, TeacherState>(
                      builder: (context, state) {
                        return ElevatedButton(
                          onPressed: () {
                            state is TeacherLoading
                                ? null
                                : teacherBloc.add(EditTeacherEvent(
                                    id: teacherId,
                                    username: nipController.text,
                                    password: passwordController.text,
                                    email: emailController.text,
                                    name: nameController.text,
                                    phone: phoneController.text,
                                    gender: genderValue.state,
                                  ));
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF696CFF),
                          ),
                          child: Text(
                              state is TeacherLoading ? "Simpan..." : "Simpan"),
                        );
                      },
                      listener: (context, state) {
                        if (state is TeacherEditSuccess) {
                          Navigator.pushNamed(context, "/admin/teacher");
                          showCostumSnackBar(
                            context: context,
                            message: "Guru Berhasil Diedit",
                            type: "success",
                          );
                        } else if (state is TeacherValidationError) {
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
