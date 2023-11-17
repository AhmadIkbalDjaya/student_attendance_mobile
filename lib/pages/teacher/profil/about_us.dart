import 'package:flutter/material.dart';
import 'package:student_attendance/components/my_bottom_nav_bar.dart';
import 'package:student_attendance/cubit/teacher_tab_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AboutUsPage extends StatelessWidget {
  const AboutUsPage({super.key});

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
          "Tentang Kami",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        centerTitle: false,
      ),
      body: ListView(
        children: const [],
      ),
      bottomNavigationBar: MyBottomNavBar(teacherTab: teacherTab),
    );
  }
}
