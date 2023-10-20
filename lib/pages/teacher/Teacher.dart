import 'package:flutter/material.dart';
import 'package:student_attendance/components/ClaassList.dart';
import 'package:student_attendance/pages/teacher/Home.dart';

class TeacherPage extends StatelessWidget {
  const TeacherPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const ClaassList(),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color(0xFF696CFF),
        type: BottomNavigationBarType.fixed,
        currentIndex: 0,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.black26,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        onTap: (value) {},
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
      ),
    );
  }
}

