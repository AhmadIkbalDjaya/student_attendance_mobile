import 'package:flutter/material.dart';

class ProfilPage extends StatelessWidget {
  const ProfilPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: ListView(
        children: [
          const Column(
            children: [
              CircleAvatar(
                radius: 45,
                backgroundColor: Color(0xFFD9D9D9),
              ),
              SizedBox(height: 10),
              Text(
                "Ahmad Ikbal Djaya",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              Text(
                "60200120073",
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
            ],
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 15),
            padding: const EdgeInsets.all(15),
            decoration: const BoxDecoration(
              color: Color(0xFFD9D9D9),
              borderRadius: BorderRadius.all(Radius.circular(5)),
            ),
            child: const Column(
              children: [
                ProfilList(icon: Icons.mail, text: "ikbaldjaya@gmail.com"),
                SizedBox(height: 10),
                ProfilList(icon: Icons.phone, text: "081241250245"),
                SizedBox(height: 10),
                ProfilList(icon: Icons.male, text: "Laki-Laki"),
              ],
            ),
          ),
          Column(
            children: [
              Container(
                margin: const EdgeInsets.symmetric(vertical: 5),
                width: double.infinity,
                child: const Text(
                  "Akun Saya",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: const Color(0xFFD9D9D9),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Column(
                  children: [
                    ProfilMenu(
                      icon: Icons.settings,
                      text: "Pengaturan Akun",
                      onTap: () {
                        Navigator.pushNamed(context, "/profil/account");
                      },
                    ),
                    ProfilMenu(
                      icon: Icons.key,
                      text: "Ganti Password",
                      onTap: () {
                        Navigator.pushNamed(context, "/profil/changePass");
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Column(
            children: [
              Container(
                margin: const EdgeInsets.symmetric(vertical: 5),
                width: double.infinity,
                child: const Text(
                  "Paduan & Tentang Kami",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: const Color(0xFFD9D9D9),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Column(
                  children: [
                    ProfilMenu(
                      icon: Icons.help,
                      text: "Panduan Pengguna",
                      onTap: () =>
                          Navigator.pushNamed(context, "/profil/userGuide"),
                    ),
                    ProfilMenu(
                      icon: Icons.info,
                      text: "Tentang Kami",
                      onTap: () =>
                          Navigator.pushNamed(context, "/profil/aboutUs"),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, "/");
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF696CFF),
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.logout, size: 24),
                SizedBox(width: 5),
                Text(
                  "Keluar",
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ProfilList extends StatelessWidget {
  const ProfilList({super.key, required this.icon, required this.text});
  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon),
        const SizedBox(width: 20),
        Text(
          text,
          style: const TextStyle(fontSize: 18),
        ),
      ],
    );
  }
}

class ProfilMenu extends StatelessWidget {
  const ProfilMenu({
    super.key,
    required this.icon,
    required this.text,
    this.onTap = defaultFunction,
  });
  final IconData icon;
  final String text;
  final Function onTap;
  static void defaultFunction() {}
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap();
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 5),
        padding: const EdgeInsets.only(bottom: 6),
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(width: 2, color: Colors.grey),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(icon, size: 28),
                const SizedBox(width: 20),
                Text(
                  text,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            const Icon(
              Icons.navigate_next,
              size: 35,
            ),
          ],
        ),
      ),
    );
  }
}
