import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student_attendance/bloc/auth/auth_bloc.dart';
import 'package:student_attendance/values/auth.dart';
import 'package:student_attendance/bloc/login/login_bloc.dart';

class ProfilPage extends StatelessWidget {
  const ProfilPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 35, right: 20, left: 20),
      child: ListView(
        children: [
          Column(
            children: [
              CircleAvatar(
                radius: 45,
                backgroundImage: AssetImage(
                  Auth.gender == "male"
                      ? "assets/images/male_profil.png"
                      : "assets/images/female_profil.png",
                ),
              ),
              const SizedBox(height: 10),
              Text(
                "${Auth.name}",
                style: const TextStyle(
                  color: Color(0xFF696CFF),
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                ),
              ),
              Text(
                "${Auth.username}",
                style: const TextStyle(
                  color: Color(0xFF696CFF),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 15),
            padding: const EdgeInsets.all(15),
            decoration: const BoxDecoration(
              color: Color(0xFFD9D9D9),
              gradient: LinearGradient(
                colors: [
                  Color(0xFF696CFF),
                  Color(0xFFACAEFE),
                ],
                begin: Alignment(0.2, 0),
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.all(Radius.circular(5)),
            ),
            child: Column(
              children: [
                ProfilList(icon: Icons.mail, text: "${Auth.email}"),
                const SizedBox(height: 10),
                ProfilList(
                  icon: Icons.phone,
                  text: Auth.phone != "" ? Auth.phone.toString() : "-",
                ),
                const SizedBox(height: 10),
                ProfilList(
                  icon: Auth.gender == "male" ? Icons.male : Icons.female,
                  text: Auth.gender == "male" ? "Laki-laki" : "Perempuan",
                ),
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
                    color: Color(0xFF696CFF),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5),
                  boxShadow: const [
                    BoxShadow(
                      color: Color.fromARGB(25, 0, 0, 0),
                      spreadRadius: 1,
                      blurRadius: 1,
                      offset: Offset(0, 3),
                    ),
                  ],
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
                    color: Color(0xFF696CFF),
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5),
                  boxShadow: const [
                    BoxShadow(
                      color: Color.fromARGB(25, 0, 0, 0),
                      spreadRadius: 1,
                      blurRadius: 1,
                      offset: Offset(0, 3),
                    ),
                  ],
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
          BlocConsumer<LoginBloc, LoginState>(
            listener: (context, state) {
              if (state is LogoutSuccess) {
                context.read<AuthBloc>().add(SetSignOut());
                Navigator.pushNamed(context, "/");
              }
            },
            builder: (context, state) {
              return ElevatedButton(
                onPressed: () {
                  state is LoginLoading
                      ? null
                      : context.read<LoginBloc>().add(SignOut());
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF696CFF),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.logout, size: 24),
                    const SizedBox(width: 5),
                    Text(
                      state is! LoginLoading ? "Keluar" : "Keluar ...",
                      style: const TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
              );
            },
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
        Icon(
          icon,
          color: Colors.white,
        ),
        const SizedBox(width: 20),
        Text(
          text,
          style: const TextStyle(
            fontSize: 18,
            color: Colors.white,
          ),
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
            bottom: BorderSide(
              width: 2,
              color: Color(0xFFACAEFE),
            ),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(
                  icon,
                  size: 28,
                  color: const Color(0xFF696CFF),
                ),
                const SizedBox(width: 20),
                Text(
                  text,
                  style: const TextStyle(
                    color: Color(0xFF696CFF),
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            const Icon(
              Icons.navigate_next,
              size: 35,
              color: Color(0xFF696CFF),
            ),
          ],
        ),
      ),
    );
  }
}
