import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:student_attendance/bloc/admin/student/student_bloc.dart';
import 'package:student_attendance/components/admin/my_app_bar.dart';
import 'package:student_attendance/components/admin/my_drawer.dart';
import 'package:student_attendance/models/admin/student.dart';
import 'package:student_attendance/values/theme.dart';

class AdminDetailStudentPage extends StatelessWidget {
  const AdminDetailStudentPage(
      {super.key, required this.studentId, required this.claassId});
  final int claassId;
  final int studentId;
  @override
  Widget build(BuildContext context) {
    StudentBloc studentBloc = context.read<StudentBloc>();
    studentBloc.add(GetDetailStudentEvent(studentId: studentId));
    return WillPopScope(
      onWillPop: () async {
        studentBloc.add(GetAllStudentEvent(claassId: claassId));
        return true;
      },
      child: Scaffold(
        appBar: const MyAppBar(),
        drawer: const MyDrawer(),
        body: Column(
          children: [
            Container(
              decoration: CustomTheme.headerDecoration(),
              padding: const EdgeInsets.only(
                  top: 0, bottom: 10, right: 10, left: 10),
              width: double.infinity,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 20),
                    child: Column(
                      children: [
                        Text(
                          "Informasi Siswa",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          "Datail Informasi Siswa",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    top: 0,
                    left: 0,
                    child: BackButton(
                      color: Colors.white,
                      onPressed: () {
                        Navigator.pop(context);
                        studentBloc.add(GetAllStudentEvent(claassId: claassId));
                      },
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                children: [
                  BlocBuilder<StudentBloc, StudentState>(
                    builder: (context, state) {
                      Student student = state is StudentDetailSuccess
                          ? state.student
                          : dummyStudents[0];
                      return Skeletonizer(
                        enabled: state is! StudentDetailSuccess,
                        child: Container(
                          margin: const EdgeInsets.symmetric(
                            vertical: 20,
                            horizontal: 15,
                          ),
                          padding: const EdgeInsets.symmetric(
                            vertical: 25,
                            horizontal: 30,
                          ),
                          decoration: CustomTheme.contentDecoration(),
                          width: double.infinity,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                student.name,
                                style: const TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                student.nis,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(height: 20),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.class_,
                                    size: 25,
                                  ),
                                  const SizedBox(width: 10),
                                  Text(
                                    student.claassName != null
                                        ? student.claassName.toString()
                                        : "-",
                                    style: const TextStyle(
                                      fontSize: 18,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.male,
                                    size: 25,
                                  ),
                                  const SizedBox(width: 10),
                                  Text(
                                    student.gender != null
                                        ? student.gender == "male"
                                            ? "Laki-Laki"
                                            : "Perempuan"
                                        : "-",
                                    style: const TextStyle(
                                      fontSize: 18,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
