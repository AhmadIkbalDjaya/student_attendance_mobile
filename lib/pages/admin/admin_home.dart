import 'package:flutter/material.dart';
import 'package:student_attendance/bloc/admin/admin_home/admin_home_bloc.dart';
import 'package:student_attendance/bloc/auth/auth_bloc.dart';
import 'package:student_attendance/components/admin/my_app_bar.dart';
import 'package:student_attendance/components/admin/my_drawer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student_attendance/components/center_loading.dart';

class AdminHomePage extends StatelessWidget {
  const AdminHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    AdminHomeBloc adminHomeBloc = context.read<AdminHomeBloc>();
    adminHomeBloc.add(GetAdminHomeEvent());
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        appBar: const MyAppBar(),
        drawer: const MyDrawer(),
        body: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 50,
            vertical: 30,
          ),
          child: BlocConsumer<AdminHomeBloc, AdminHomeState>(
            listener: (context, state) {
              if (state is InvalidToken) {
                context.read<AuthBloc>().add(SetSignOut());
              }
            },
            builder: (context, state) {
              if (state is AdminHomeSuccess) {
                return ListView(
                  children: [
                    CountBox(
                      text: "Total Kelas",
                      count: state.adminHome.claassCount.toString(),
                      icon: Icons.class_outlined,
                    ),
                    CountBox(
                      text: "Total Mapel",
                      count: state.adminHome.courseCount.toString(),
                      icon: Icons.calculate_sharp,
                    ),
                    CountBox(
                      text: "Total Guru",
                      count: state.adminHome.teacherCount.toString(),
                      icon: Icons.co_present_outlined,
                    ),
                    CountBox(
                      text: "Total Siswa",
                      count: state.adminHome.studentCount.toString(),
                      icon: Icons.person,
                    ),
                  ],
                );
              }
              return const CenterLoading();
            },
          ),
        ),
      ),
    );
  }
}

class CountBox extends StatelessWidget {
  const CountBox({
    super.key,
    required this.text,
    required this.count,
    required this.icon,
  });

  final String text;
  final String count;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xFF696CFF),
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                text,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                count,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 65,
                ),
              ),
            ],
          ),
          Icon(
            icon,
            color: Colors.white,
            size: 100,
          ),
        ],
      ),
    );
  }
}
