import 'package:flutter/material.dart';
import 'package:student_attendance/bloc/teacher/teacher_home/teacher_home_bloc.dart';
import 'package:student_attendance/components/my_snack_bar.dart';
import 'package:student_attendance/models/teacher/teacher_home.dart';
import 'package:student_attendance/presentation/costum_icons_icons.dart';
import 'package:student_attendance/values/auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    TeacherHomeBloc teacherHomeBloc = context.read<TeacherHomeBloc>();
    teacherHomeBloc.add(GetTeacherHomeEvent());
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.logout,
              color: Colors.grey,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 25),
        child: Column(
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 35,
                  backgroundColor: Colors.grey,
                  backgroundImage: AssetImage(
                    Auth.gender == "male"
                        ? "assets/images/male_profil.png"
                        : "assets/images/female_profil.png",
                  ),
                ),
                const SizedBox(width: 15),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${Auth.name}",
                      style: const TextStyle(
                        color: Color(0xFF696CFF),
                        fontSize: 24,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      "${Auth.username}",
                      style: const TextStyle(
                        color: Color(0xFF696CFF),
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                )
              ],
            ),
            const SizedBox(height: 30),
            BlocBuilder<TeacherHomeBloc, TeacherHomeState>(
              builder: (context, state) {
                return Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 30, horizontal: 15),
                  height: 160,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    gradient: LinearGradient(
                      colors: [
                        Color(0xFF696CFF),
                        Color(0xFFACAEFE),
                      ],
                      begin: Alignment(0, 0),
                      end: Alignment.bottomLeft,
                    ),
                  ),
                  child: BlocBuilder<TeacherHomeBloc, TeacherHomeState>(
                    builder: (context, state) {
                      if (state is TeacherHomeSuccess) {
                        TeacherHome teacherHome = state.teacherHome;
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  "Jumlah Pertemuan",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                RichText(
                                  text: TextSpan(
                                    text:
                                        "${teacherHome.attendanceCount - teacherHome.attendanceNullCount}",
                                    style: const TextStyle(
                                      fontSize: 50,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    children: [
                                      TextSpan(
                                        text:
                                            " / ${teacherHome.attendanceCount}",
                                        style: const TextStyle(fontSize: 30),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Icon(
                                  CostumIcons.book,
                                  color: Colors.white,
                                  size: 50,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 10),
                                  child: Text(
                                    "${teacherHome.attendanceNullCount} Pertemuan Belum Terisi",
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        );
                      }
                      return Container();
                    },
                  ),
                );
              },
            ),
            const SizedBox(height: 25),
            BlocConsumer<TeacherHomeBloc, TeacherHomeState>(
              listener: (context, state) {
                if (state is TeacherHomeFailure) {
                  showCostumSnackBar(
                    context: context,
                    message: state.message,
                    type: "danger",
                  );
                }
              },
              builder: (context, state) {
                if (state is TeacherHomeSuccess) {
                  TeacherHome teacherHome = state.teacherHome;
                  return Expanded(
                    child: GridView.count(
                      childAspectRatio: (180 / 130),
                      crossAxisCount: 2,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 30,
                      children: [
                        ItemCountBox(
                          text: "${teacherHome.claassCount} Kelas",
                          icon: CostumIcons.claass,
                        ),
                        ItemCountBox(
                          text: "${teacherHome.courseCount} Mapel",
                          icon: CostumIcons.course,
                        ),
                        ItemCountBox(
                          text: "${teacherHome.studentCount} Siswa",
                          icon: CostumIcons.student,
                        ),
                        ItemCountBox(
                          text: "${teacherHome.attendanceCount} Pertemuan",
                          icon: Icons.book,
                        ),
                      ],
                    ),
                  );
                }
                return Container();
              },
            )
          ],
        ),
      ),
    );
  }
}

class ItemCountBox extends StatelessWidget {
  const ItemCountBox({
    super.key,
    required this.text,
    required this.icon,
  });
  final String text;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 180,
      height: 120,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(
            color: Color.fromARGB(50, 0, 0, 0),
            spreadRadius: 1,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            width: 65,
            height: 60,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(5)),
              gradient: LinearGradient(
                colors: [
                  Color(0xFF696CFF),
                  Color(0xFFACAEFE),
                ],
                begin: Alignment(0, 0),
                end: Alignment.bottomCenter,
              ),
            ),
            child: Icon(
              icon,
              color: Colors.white,
              size: 40,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            text,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
