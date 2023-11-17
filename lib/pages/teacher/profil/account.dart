import 'package:flutter/material.dart';
import 'package:student_attendance/components/my_bottom_nav_bar.dart';
import 'package:student_attendance/cubit/teacher_tab_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

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
                  child: const TextField(
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
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
                  child: const TextField(
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
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
                  child: const TextField(
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
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
                  child: const TextField(
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
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
                    onChanged: (value) {},
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
