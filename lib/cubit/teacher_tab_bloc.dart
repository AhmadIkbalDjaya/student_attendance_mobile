import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student_attendance/pages/teacher/attendance/claass.dart';
import 'package:student_attendance/pages/teacher/home.dart';
import 'package:student_attendance/pages/teacher/profil/profil.dart';
import 'package:student_attendance/pages/teacher/recap/recap_claass_list.dart';
import 'package:flutter/material.dart';

class TeacherTabBloc extends Cubit<int> {
  TeacherTabBloc() : super(0);

  final List<Widget> pages = [
    const HomePage(),
    const ClaassPage(),
    const RecapClaassListPage(),
    const ProfilPage(),
  ];

  void changeTab(int index) {
    emit(index);
  }

  Widget getPages(int index) {
    return pages[index];
  }
}
