import 'package:flutter/material.dart';
import 'package:student_attendance/bloc/teacher/profil/account_setting/account_setting_bloc.dart';
import 'package:student_attendance/components/admin/my_app_bar.dart';
import 'package:student_attendance/components/admin/my_drawer.dart';
import 'package:student_attendance/components/my_snack_bar.dart';
import 'package:student_attendance/cubit/show_password_cubit.dart';
import 'package:student_attendance/values/theme.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AdminChangePassPage extends StatelessWidget {
  AdminChangePassPage({super.key});
  final ShowPassCubit showOldPass = ShowPassCubit();
  final ShowPassCubit showNewPass = ShowPassCubit();
  final ShowPassCubit showConfirmNewPass = ShowPassCubit();
  final oldPassController = TextEditingController();
  final newPassController = TextEditingController();
  final confirmNewPassController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    AccountSettingBloc accountSettingBloc = context.read<AccountSettingBloc>();
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
                    bloc: showOldPass,
                    builder: (context, state) {
                      return TextField(
                        controller: oldPassController,
                        textInputAction: TextInputAction.next,
                        obscureText: state,
                        decoration: InputDecoration(
                          suffixIcon: GestureDetector(
                            onTap: () => showOldPass.handleClick(),
                            child: Icon(
                              state ? Icons.visibility_off : Icons.visibility,
                              color: const Color(0xFF696CFF),
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
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 15),
                  height: 40,
                  child: BlocBuilder<ShowPassCubit, bool>(
                    bloc: showNewPass,
                    builder: (context, state) {
                      return TextField(
                        controller: newPassController,
                        textInputAction: TextInputAction.next,
                        obscureText: state,
                        decoration: InputDecoration(
                          suffixIcon: GestureDetector(
                            onTap: () => showNewPass.handleClick(),
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
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 15),
                  height: 40,
                  child: BlocBuilder<ShowPassCubit, bool>(
                    bloc: showConfirmNewPass,
                    builder: (context, state) {
                      return TextField(
                        controller: confirmNewPassController,
                        textInputAction: TextInputAction.next,
                        obscureText: state,
                        decoration: InputDecoration(
                          suffixIcon: GestureDetector(
                            onTap: () => showConfirmNewPass.handleClick(),
                            child: Icon(
                              state ? Icons.visibility_off : Icons.visibility,
                              color: const Color(0xFF696CFF),
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
            child: BlocConsumer<AccountSettingBloc, AccountSettingState>(
              listener: (context, state) {
                if (state is UpdateSuccess) {
                  showCostumSnackBar(
                    context: context,
                    message: "Password Berhasil Diubah",
                    type: "success",
                  );
                  Navigator.pushNamed(context, "/admin");
                }
                if (state is ValidationError) {
                  showCostumSnackBar(
                    context: context,
                    message: state.message,
                    type: "danger",
                  );
                }
                if (state is Failure) {
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
                    state is Loading
                        ? null
                        : accountSettingBloc.add(UpdatePassword(
                            oldPassword: oldPassController.text,
                            newPassword: newPassController.text,
                            confirmNewPassword: confirmNewPassController.text,
                          ));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF696CFF),
                  ),
                  child: state is Loading
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
