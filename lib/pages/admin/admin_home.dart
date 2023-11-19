import 'package:flutter/material.dart';
import 'package:student_attendance/bloc/login/login_bloc.dart';
import 'package:student_attendance/components/admin/my_app_bar.dart';
import 'package:student_attendance/components/admin/my_drawer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AdminHomePage extends StatelessWidget {
  const AdminHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: BlocConsumer<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state is UserSignOut) {
            Navigator.pushNamed(context, "/");
          }
        },
        builder: (context, state) {
          return IconButton(
            onPressed: () {
              context.read<LoginBloc>().add(SignOut());
            },
            icon: const Icon(Icons.logout),
          );
        },
      ),
      appBar: const MyAppBar(),
      drawer: const MyDrawer(),
      body: const Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 50,
          vertical: 75,
        ),
        child: Column(
          children: [
            CountBox(
              text: "Total Kelas",
              count: "100",
              icon: Icons.class_outlined,
            ),
            CountBox(
              text: "Total Guru",
              count: "80",
              icon: Icons.co_present_outlined,
            ),
            CountBox(
              text: "Total Siswa",
              count: "87",
              icon: Icons.person,
            ),
          ],
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
