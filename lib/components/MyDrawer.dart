import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
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
            const Padding(
              padding: EdgeInsets.only(top: 30),
              child: Column(
                children: [
                  DrawerMenu(text: "Dashboard", icon: Icons.home),
                  DrawerMenu(text: "Guru", icon: Icons.co_present_outlined),
                  DrawerMenu(text: "Siswa", icon: Icons.person),
                  DrawerMenu(text: "Kelas", icon: Icons.class_),
                  DrawerMenu(text: "Semester", icon: Icons.date_range),
                  DrawerMenu(text: "Mata Pelajaran", icon: Icons.menu_book),
                  DrawerMenu(text: "Rekap Absensi", icon: Icons.book_sharp),
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
  const DrawerMenu({super.key, required this.icon, required this.text});
  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
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
      ),
      child: Row(
        children: [
          Icon(icon, size: 30, color: Colors.black54),
          const SizedBox(width: 5),
          Text(
            text,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black54,
            ),
          ),
        ],
      ),
    );
  }
}
