import 'package:flutter/material.dart';
import 'package:student_attendance/bloc/admin/teacher/teacher_bloc.dart';
import 'package:student_attendance/components/admin/my_app_bar.dart';
import 'package:student_attendance/components/admin/my_drawer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student_attendance/models/admin/teacher.dart';

class AdminDetailTeacherPage extends StatelessWidget {
  const AdminDetailTeacherPage({super.key, required this.teacherId});
  final int teacherId;

  @override
  Widget build(BuildContext context) {
    TeacherBloc teacherBloc = context.read<TeacherBloc>();
    teacherBloc.add(GetDetailTeacherEvent(teacherId: teacherId));
    return WillPopScope(
      onWillPop: () async {
        teacherBloc.add(GetAllTeacherEvent());
        return true;
      },
      child: Scaffold(
        appBar: const MyAppBar(),
        drawer: const MyDrawer(),
        body: Column(
          children: [
            Container(
              decoration: const BoxDecoration(
                color: Color(0xFFD9D9D9),
              ),
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
                          "Informasi Guru",
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          "Datail Informasi Guru",
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    top: 0,
                    left: 0,
                    child: BackButton(
                      onPressed: () {
                        Navigator.pop(context);
                        teacherBloc.add(GetAllTeacherEvent());
                      },
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(
                      vertical: 20,
                      horizontal: 15,
                    ),
                    padding: const EdgeInsets.symmetric(
                      vertical: 25,
                      horizontal: 30,
                    ),
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(15),
                      ),
                      color: Color(0xFFD9D9D9),
                    ),
                    width: double.infinity,
                    child: BlocBuilder<TeacherBloc, TeacherState>(
                      builder: (context, state) {
                        if (state is TeacherGetLoading) {
                          return const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CircularProgressIndicator(),
                            ],
                          );
                        }
                        if (state is TeacherDetailSuccess) {
                          Teacher teacher = state.teacher;
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                teacher.name,
                                style: const TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                teacher.username,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(height: 20),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.email_outlined,
                                    size: 25,
                                  ),
                                  const SizedBox(width: 10),
                                  Text(
                                    "${teacher.email}",
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
                                    Icons.phone,
                                    size: 25,
                                  ),
                                  const SizedBox(width: 10),
                                  Text(
                                    "${teacher.phone}",
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
                                    teacher.gender == "male"
                                        ? "Laki-Laki"
                                        : "Perempuan",
                                    style: const TextStyle(
                                      fontSize: 18,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              Row(
                                children: [
                                  ElevatedButton(
                                    onPressed: () {
                                      Navigator.pushNamed(
                                          context, "/admin/teacher/edit");
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.amber[300],
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 15,
                                        vertical: 0,
                                      ),
                                    ),
                                    child: const Row(
                                      children: [
                                        Icon(
                                          Icons.edit_square,
                                          color: Colors.black,
                                          size: 20,
                                        ),
                                        SizedBox(width: 5),
                                        Text(
                                          "Edit",
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(width: 15),
                                  ElevatedButton(
                                    onPressed: () {},
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.red,
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 15,
                                        vertical: 0,
                                      ),
                                    ),
                                    child: const Row(
                                      children: [
                                        Icon(
                                          Icons.delete,
                                          color: Colors.black,
                                          size: 20,
                                        ),
                                        SizedBox(width: 5),
                                        Text(
                                          "Hapus",
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              )
                            ],
                          );
                        }
                        return Container();
                      },
                    ),
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
