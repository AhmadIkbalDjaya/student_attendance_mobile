import 'package:flutter/material.dart';
import 'package:student_attendance/pages/teacher/profil/Profil.dart';

class TeacherPage extends StatelessWidget {
  const TeacherPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const ProfilPage(),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color(0xFF696CFF),
        type: BottomNavigationBarType.fixed,
        currentIndex: 0,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.black26,
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

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 35),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            height: 150,
            width: double.infinity,
            color: Colors.grey,
          ),
          Container(
            height: 150,
            width: double.infinity,
            color: Colors.grey,
          ),
          Container(
            height: 150,
            width: double.infinity,
            color: Colors.grey,
          ),
        ],
      ),
    );
  }
}
