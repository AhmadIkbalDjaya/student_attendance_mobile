import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student_attendance/bloc/login/login_bloc.dart';
import 'package:student_attendance/cubit/admin_drawer_bloc.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    AdminDrawerBloc activePage = context.read<AdminDrawerBloc>();
    return Drawer(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Image.asset(
                      "assets/images/logo.png",
                      width: 50,
                      height: 50,
                    ),
                    const SizedBox(width: 10),
                    const Text(
                      "MA Pompanua",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                      ),
                    ),
                  ],
                ),
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.clear,
                    size: 30,
                  ),
                )
              ],
            ),
            Container(
              height: MediaQuery.of(context).size.height - 80,
              padding: const EdgeInsets.only(top: 30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      DrawerMenu(
                        text: "Dashboard",
                        icon: Icons.home,
                        index: 0,
                        targetPage: "/admin",
                        isActive: activePage.state == 0 ? true : false,
                      ),
                      DrawerMenu(
                        text: "Guru",
                        icon: Icons.co_present_outlined,
                        index: 1,
                        targetPage: "/admin/teacher",
                        isActive: activePage.state == 1 ? true : false,
                      ),
                      DrawerMenu(
                        text: "Siswa",
                        icon: Icons.person,
                        index: 2,
                        targetPage: "/admin/student",
                        isActive: activePage.state == 2 ? true : false,
                      ),
                      DrawerMenu(
                        text: "Kelas",
                        icon: Icons.class_,
                        index: 3,
                        targetPage: "/admin/claass",
                        isActive: activePage.state == 3 ? true : false,
                      ),
                      DrawerMenu(
                        text: "Semester",
                        icon: Icons.date_range,
                        index: 4,
                        targetPage: "/admin/semester",
                        isActive: activePage.state == 4 ? true : false,
                      ),
                      DrawerMenu(
                        text: "Mata Pelajaran",
                        icon: Icons.menu_book,
                        index: 5,
                        targetPage: "/admin/course",
                        isActive: activePage.state == 5 ? true : false,
                      ),
                      DrawerMenu(
                        text: "Rekap Absensi",
                        icon: Icons.book_sharp,
                        index: 6,
                        targetPage: "/admin/recap",
                        isActive: activePage.state == 6 ? true : false,
                      ),
                    ],
                  ),
                  BlocConsumer<LoginBloc, LoginState>(
                    listener: (context, state) {
                      if (state is UserSignOut) {
                        Navigator.pushReplacementNamed(context, "/");
                      }
                    },
                    builder: (context, state) {
                      return InkWell(
                        onTap: () {
                          state is LoginLoading
                              ? null
                              : context.read<LoginBloc>().add(SignOut());
                        },
                        child: Container(
                          margin: const EdgeInsets.symmetric(
                            horizontal: 25,
                            vertical: 5,
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 3,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(
                              color: const Color(0xFF696CFF),
                              width: 2,
                            ),
                            color: Colors.transparent,
                          ),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.logout,
                                size: 30,
                                color: Colors.black54,
                              ),
                              const SizedBox(width: 5),
                              Text(
                                state is LoginLoading ? "Logout ..." : "Logout",
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black54,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DrawerMenu extends StatelessWidget {
  const DrawerMenu({
    super.key,
    required this.icon,
    required this.text,
    required this.index,
    this.targetPage = "/admin",
    this.isActive = false,
  });
  final IconData icon;
  final String text;
  final int index;
  final String targetPage;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    AdminDrawerBloc activePage = context.read<AdminDrawerBloc>();
    return InkWell(
      onTap: () {
        activePage.setActive(index);
        Navigator.pushNamed(context, targetPage);
      },
      child: Container(
        margin: const EdgeInsets.symmetric(
          horizontal: 25,
          vertical: 5,
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 3,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            color: const Color(0xFF696CFF),
            width: 2,
          ),
          color: isActive ? const Color(0xFF696CFF) : Colors.transparent,
        ),
        child: Row(
          children: [
            Icon(
              icon,
              size: 30,
              color: isActive ? Colors.white : Colors.black54,
            ),
            const SizedBox(width: 5),
            Text(
              text,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: isActive ? Colors.white : Colors.black54,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
