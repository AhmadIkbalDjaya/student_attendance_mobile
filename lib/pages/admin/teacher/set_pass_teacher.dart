import 'package:flutter/material.dart';
import 'package:student_attendance/bloc/admin/teacher/teacher_bloc.dart';
import 'package:student_attendance/components/admin/my_app_bar.dart';
import 'package:student_attendance/components/admin/my_drawer.dart';
import 'package:student_attendance/components/my_snack_bar.dart';
import 'package:student_attendance/cubit/show_password_cubit.dart';
import 'package:student_attendance/values/theme.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AdminSetPassTeacherPage extends StatelessWidget {
  AdminSetPassTeacherPage({super.key, required this.teacherId});
  final int teacherId;
  final ShowPassCubit showPassCubit = ShowPassCubit();
  final passController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    TeacherBloc teacherBloc = context.read<TeacherBloc>();
    return Scaffold(
      appBar: const MyAppBar(),
      drawer: const MyDrawer(),
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
            decoration: CustomTheme.contentDecoration(),
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 15),
                  height: 40,
                  child: BlocBuilder<ShowPassCubit, bool>(
                    bloc: showPassCubit,
                    builder: (context, state) {
                      return TextField(
                        controller: passController,
                        textInputAction: TextInputAction.next,
                        obscureText: state,
                        decoration: InputDecoration(
                          suffixIcon: GestureDetector(
                            onTap: () => showPassCubit.handleClick(),
                            child: Icon(
                              state ? Icons.visibility_off : Icons.visibility,
                              color: const Color(0xFF696CFF),
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
                          enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xFF696CFF),
                            ),
                          ),
                          focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xFF696CFF),
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
            child: BlocConsumer<TeacherBloc, TeacherState>(
              listener: (context, state) {
                if (state is TeacherSetPassSuccess) {
                  showCostumSnackBar(
                    context: context,
                    message: "Password Berhasil Diubah",
                    type: "success",
                  );
                  Navigator.pushNamed(context, "/admin");
                }
                if (state is TeacherValidationError) {
                  showCostumSnackBar(
                    context: context,
                    message: state.message,
                    type: "danger",
                  );
                }
                if (state is TeacherFailure) {
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
                    state is TeacherLoading
                        ? null
                        : teacherBloc.add(SetTeacherPasswordEvent(
                            id: teacherId,
                            password: passController.text,
                          ));
                  },
                  child: state is TeacherLoading
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2,
                          ),
                        )
                      : const Text("Simpan"),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
