import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student_attendance/pages/teacher/home.dart';
import 'package:student_attendance/pages/teacher/attendance/claass.dart';
import 'package:student_attendance/pages/teacher/profil/profil.dart';
import 'package:student_attendance/pages/teacher/recap/recap_claass_list.dart';

class TeacherPage extends StatelessWidget {
  TeacherPage({super.key});

  final List<Widget> pages = [
    const HomePage(),
    const ClaassPage(),
    const RecapClaassListPage(),
    const ProfilPage(),
  ];

  @override
  Widget build(BuildContext context) {
    TeacherTabBloc teacherTab = TeacherTabBloc();
    return Scaffold(
      body: BlocBuilder<TeacherTabBloc, int>(
        bloc: teacherTab,
        builder: (context, state) {
          return pages[state];
        },
      ),
      bottomNavigationBar: BlocBuilder<TeacherTabBloc, int>(
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
      ),
    );
  }
}

class TeacherTabBloc extends Cubit<int> {
  TeacherTabBloc() : super(0);

  void changeTab(int index) {
    emit(index);
  }
}

// class TeacherNavBloc extends Cubit<Widget> {
//   TeacherNavBloc() : super(HomePage());

//   final List<Widget> pages = [
//     const HomePage(),
//     const ClaassPage(),
//     const RecapClaassListPage(),
//     const ProfilPage(),
//   ];
//   void changeTab(int index) {
//     emit(pages[index]);
//   }
// }
