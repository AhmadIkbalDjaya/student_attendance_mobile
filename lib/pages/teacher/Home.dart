import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:student_attendance/bloc/auth/auth_bloc.dart';
import 'package:student_attendance/bloc/login/login_bloc.dart';
import 'package:student_attendance/bloc/teacher/teacher_home/teacher_home_bloc.dart';
import 'package:student_attendance/components/my_snack_bar.dart';
import 'package:student_attendance/components/teacher/home_count_box.dart';
import 'package:student_attendance/presentation/costum_icons_icons.dart';
import 'package:student_attendance/values/auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    TeacherHomeBloc teacherHomeBloc = context.read<TeacherHomeBloc>();
    teacherHomeBloc.add(GetTeacherHomeEvent());
    AuthBloc authBloc = context.read<AuthBloc>();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          BlocConsumer<LoginBloc, LoginState>(
            listener: (context, state) {
              if (state is LogoutSuccess) {
                authBloc.add(SetSignOut());
                Navigator.pushNamed(context, "/");
              }
            },
            builder: (context, state) {
              return IconButton(
                onPressed: () {
                  state is LoginLoading
                      ? null
                      : context.read<LoginBloc>().add(SignOut());
                },
                icon: const Icon(
                  Icons.logout,
                  color: Colors.grey,
                ),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(
            top: 10,
            left: 20,
            right: 20,
          ),
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
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${Auth.name}",
                          overflow: TextOverflow.ellipsis,
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
                    ),
                  )
                ],
              ),
              const SizedBox(height: 25),
              BlocConsumer<TeacherHomeBloc, TeacherHomeState>(
                listener: (context, state) {
                  if (state is InvalidToken) {
                    authBloc.add(SetSignOut());
                  }
                },
                builder: (context, state) {
                  return Skeletonizer(
                    enabled: state is! TeacherHomeSuccess,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 30,
                        horizontal: 15,
                      ),
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
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Skeleton.keep(
                                child: Text(
                                  "Jumlah Pertemuan",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              RichText(
                                text: TextSpan(
                                  text: state is TeacherHomeSuccess
                                      ? "${state.teacherHome.attendanceCount - state.teacherHome.attendanceNullCount}"
                                      : "x",
                                  style: const TextStyle(
                                    fontSize: 50,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  children: [
                                    TextSpan(
                                      text: state is TeacherHomeSuccess
                                          ? " / ${state.teacherHome.attendanceCount}"
                                          : " / x",
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
                              const Skeleton.keep(
                                child: Icon(
                                  CostumIcons.book,
                                  color: Colors.white,
                                  size: 50,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 10),
                                child: Text(
                                  state is TeacherHomeSuccess
                                      ? "${state.teacherHome.attendanceNullCount} Pertemuan Belum Terisi"
                                      : "x Pertemuan Belum Terisi",
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
                      ),
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
                  return Skeletonizer(
                    enabled: state is! TeacherHomeSuccess,
                    child: GridView(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: (180 / 130),
                        crossAxisSpacing: 20,
                        mainAxisSpacing: 20,
                      ),
                      children: [
                        HomeCountBox(
                          text: state is TeacherHomeSuccess
                              ? "${state.teacherHome.claassCount} Kelas"
                              : "x Kelas",
                          icon: CostumIcons.claass,
                        ),
                        HomeCountBox(
                          text: state is TeacherHomeSuccess
                              ? "${state.teacherHome.courseCount} Mapel"
                              : "x Mapel",
                          icon: CostumIcons.course,
                        ),
                        HomeCountBox(
                          text: state is TeacherHomeSuccess
                              ? "${state.teacherHome.studentCount} Siswa"
                              : "x Siswa",
                          icon: CostumIcons.student,
                        ),
                        HomeCountBox(
                          text: state is TeacherHomeSuccess
                              ? "${state.teacherHome.attendanceCount} Pertemuan"
                              : "x Pertemuan",
                          icon: Icons.book,
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
