import 'package:flutter/material.dart';
import 'package:student_attendance/components/my_bottom_nav_bar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student_attendance/cubit/show_password_cubit.dart';
import 'package:student_attendance/cubit/teacher_tab_bloc.dart';

class ChangePasswordPage extends StatelessWidget {
  ChangePasswordPage({super.key});
  final ShowPassCubit showOldPass = ShowPassCubit();
  final ShowPassCubit showNewPass = ShowPassCubit();
  final ShowPassCubit showConfirmNewPass = ShowPassCubit();

  @override
  Widget build(BuildContext context) {
    TeacherTabBloc teacherTab = context.read<TeacherTabBloc>();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
        leading: const BackButton(
          color: Colors.black,
        ),
        title: const Text(
          "Ubah Password",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        centerTitle: false,
      ),
      body: ListView(
        children: [
          Container(
            margin: const EdgeInsets.only(
              left: 25,
              right: 25,
              top: 15,
              bottom: 10,
            ),
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(5),
            ),
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 15),
                  height: 40,
                  child: BlocBuilder<ShowPassCubit, bool>(
                    bloc: showOldPass,
                    builder: (context, state) {
                      return TextField(
                        textInputAction: TextInputAction.next,
                        obscureText: state,
                        decoration: InputDecoration(
                          suffixIcon: GestureDetector(
                            onTap: () => showOldPass.handleClick(),
                            child: Icon(
                              state ? Icons.visibility_off : Icons.visibility,
                            ),
                          ),
                          labelText: "Password Saat Ini",
                          floatingLabelStyle: const TextStyle(
                            color: Color(0xFF696CFF),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 0,
                            horizontal: 10,
                          ),
                          focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xFF696CFF),
                              width: 1,
                              style: BorderStyle.solid,
                            ),
                          ),
                          border: const OutlineInputBorder(),
                        ),
                      );
                    },
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 15),
                  height: 40,
                  child: BlocBuilder<ShowPassCubit, bool>(
                    bloc: showNewPass,
                    builder: (context, state) {
                      return TextField(
                        textInputAction: TextInputAction.next,
                        obscureText: state,
                        decoration: InputDecoration(
                          suffixIcon: GestureDetector(
                            onTap: () => showNewPass.handleClick(),
                            child: Icon(
                              state ? Icons.visibility_off : Icons.visibility,
                            ),
                          ),
                          labelText: "Password Baru",
                          floatingLabelStyle: const TextStyle(
                            color: Color(0xFF696CFF),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 0,
                            horizontal: 10,
                          ),
                          focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xFF696CFF),
                              width: 1,
                              style: BorderStyle.solid,
                            ),
                          ),
                          border: const OutlineInputBorder(),
                        ),
                      );
                    },
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 15),
                  height: 40,
                  child: BlocBuilder<ShowPassCubit, bool>(
                    bloc: showConfirmNewPass,
                    builder: (context, state) {
                      return TextField(
                        textInputAction: TextInputAction.next,
                        obscureText: state,
                        decoration: InputDecoration(
                          suffixIcon: GestureDetector(
                            onTap: () => showConfirmNewPass.handleClick(),
                            child: Icon(
                              state ? Icons.visibility_off : Icons.visibility,
                            ),
                          ),
                          labelText: "Konfirmasi Password Baru",
                          floatingLabelStyle: const TextStyle(
                            color: Color(0xFF696CFF),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 0,
                            horizontal: 10,
                          ),
                          focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xFF696CFF),
                              width: 1,
                              style: BorderStyle.solid,
                            ),
                          ),
                          border: const OutlineInputBorder(),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF696CFF),
              ),
              child: const Text("Simpan"),
            ),
          ),
        ],
      ),
      bottomNavigationBar: MyBottomNavBar(teacherTab: teacherTab),
    );
  }
}
