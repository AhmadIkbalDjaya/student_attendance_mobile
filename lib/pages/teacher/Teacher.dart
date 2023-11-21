import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student_attendance/cubit/teacher_tab_bloc.dart';
import 'package:student_attendance/components/my_bottom_nav_bar.dart';

class TeacherPage extends StatelessWidget {
  const TeacherPage({super.key});

  @override
  Widget build(BuildContext context) {
    TeacherTabBloc teacherTab = context.read<TeacherTabBloc>();
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        body: BlocBuilder<TeacherTabBloc, int>(
          bloc: teacherTab,
          builder: (context, state) {
            return IndexedStack(
              index: state,
              children: teacherTab.pages,
            );
          },
        ),
        bottomNavigationBar:
            MyBottomNavBar(teacherTab: teacherTab, atHome: true),
      ),
    );
  }
}
