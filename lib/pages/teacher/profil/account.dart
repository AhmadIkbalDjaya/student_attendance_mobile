import 'package:flutter/material.dart';
import 'package:student_attendance/bloc/teacher/profil/account_setting/account_setting_bloc.dart';
import 'package:student_attendance/components/my_snack_bar.dart';
import 'package:student_attendance/values/auth.dart';
import 'package:student_attendance/components/my_bottom_nav_bar.dart';
import 'package:student_attendance/cubit/drop_down_value_cubit.dart';
import 'package:student_attendance/cubit/teacher_tab_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AccountPage extends StatelessWidget {
  AccountPage({super.key});
  final nameController = TextEditingController();
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final genderValue = DropDownValueCubit();

  @override
  Widget build(BuildContext context) {
    TeacherTabBloc teacherTab = context.read<TeacherTabBloc>();
    nameController.text = Auth.name.toString();
    usernameController.text = Auth.username.toString();
    emailController.text = Auth.email.toString();
    phoneController.text = Auth.phone.toString();
    genderValue.changeValue(Auth.gender.toString());
    AccountSettingBloc accountSettingBloc = context.read<AccountSettingBloc>();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
        leading: const BackButton(
          color: Colors.black,
        ),
        title: const Text(
          "Pengaturan Akun",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        centerTitle: false,
      ),
      body: ListView(
        children: [
          CircleAvatar(
            radius: 50,
            backgroundColor: Colors.grey[300],
          ),
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
                  child: TextField(
                    controller: nameController,
                    textInputAction: TextInputAction.next,
                    decoration: const InputDecoration(
                      labelText: "Nama",
                      floatingLabelStyle: TextStyle(
                        color: Color(0xFF696CFF),
                      ),
                      contentPadding: EdgeInsets.symmetric(
                        vertical: 0,
                        horizontal: 10,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xFF696CFF),
                          width: 1,
                          style: BorderStyle.solid,
                        ),
                      ),
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 15),
                  height: 40,
                  child: TextField(
                    controller: usernameController,
                    textInputAction: TextInputAction.next,
                    decoration: const InputDecoration(
                      labelText: "NIP",
                      floatingLabelStyle: TextStyle(
                        color: Color(0xFF696CFF),
                      ),
                      contentPadding: EdgeInsets.symmetric(
                        vertical: 0,
                        horizontal: 10,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xFF696CFF),
                          width: 1,
                          style: BorderStyle.solid,
                        ),
                      ),
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 15),
                  height: 40,
                  child: TextField(
                    controller: emailController,
                    textInputAction: TextInputAction.next,
                    decoration: const InputDecoration(
                      labelText: "Email",
                      floatingLabelStyle: TextStyle(
                        color: Color(0xFF696CFF),
                      ),
                      contentPadding: EdgeInsets.symmetric(
                        vertical: 0,
                        horizontal: 10,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xFF696CFF),
                          width: 1,
                          style: BorderStyle.solid,
                        ),
                      ),
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 15),
                  height: 40,
                  child: TextField(
                    controller: phoneController,
                    textInputAction: TextInputAction.next,
                    decoration: const InputDecoration(
                      labelText: "Nomor Telepon",
                      floatingLabelStyle: TextStyle(
                        color: Color(0xFF696CFF),
                      ),
                      contentPadding: EdgeInsets.symmetric(
                        vertical: 0,
                        horizontal: 10,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xFF696CFF),
                          width: 1,
                          style: BorderStyle.solid,
                        ),
                      ),
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 15),
                  height: 40,
                  child: DropdownButtonFormField(
                    value: genderValue.state,
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
                      genderValue.changeValue(value.toString());
                    },
                    decoration: const InputDecoration(
                      labelText: "Jenis Kelamin",
                      floatingLabelStyle: TextStyle(
                        color: Color(0xFF696CFF),
                      ),
                      contentPadding: EdgeInsets.symmetric(
                        vertical: 0,
                        horizontal: 10,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xFF696CFF),
                          width: 1,
                          style: BorderStyle.solid,
                        ),
                      ),
                      border: OutlineInputBorder(),
                    ),
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
                    message: "Profil Berhasil Diubah",
                    type: "success",
                  );
                  Navigator.pushNamed(context, "/teacher");
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
                        : accountSettingBloc.add(UpdateProfileEvent(
                            name: nameController.text,
                            username: usernameController.text,
                            email: emailController.text,
                            phone: phoneController.text,
                            gender: genderValue.state,
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
      bottomNavigationBar: MyBottomNavBar(teacherTab: teacherTab),
    );
  }
}
