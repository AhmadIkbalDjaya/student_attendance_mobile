import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student_attendance/bloc/teacher_tab_bloc.dart';

class MyBottomNavBar extends StatelessWidget {
  const MyBottomNavBar({
    super.key,
    required this.teacherTab,
    this.atHome = false,
  });

  final TeacherTabBloc teacherTab;
  final bool atHome;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TeacherTabBloc, int>(
      bloc: teacherTab,
      builder: (context, state) {
        return BottomNavigationBar(
          backgroundColor: const Color(0xFF696CFF),
          type: BottomNavigationBarType.fixed,
          currentIndex: state,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.black26,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          onTap: (value) {
            if (!atHome) {
              Navigator.pushNamed(context, "/teacher");
            }
            teacherTab.changeTab(value);
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: "Home",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.class_),
              label: "Claass",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.my_library_books),
              label: "Recap",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: "Profil",
            ),
          ],
        );
      },
    );
  }
}
