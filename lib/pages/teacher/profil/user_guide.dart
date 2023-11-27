import 'package:flutter/material.dart';
import 'package:student_attendance/components/my_bottom_nav_bar.dart';
import 'package:student_attendance/cubit/teacher_tab_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserGuidePage extends StatelessWidget {
  const UserGuidePage({super.key});

  @override
  Widget build(BuildContext context) {
    TeacherTabBloc teacherTab = context.read<TeacherTabBloc>();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
        leading: const BackButton(
          color: Colors.black,
        ),
        title: const Text(
          "Panduan Pengguna",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        centerTitle: false,
      ),
      body: ListView(
        children: const [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                GuideBox(
                  number: 1,
                  text:
                      "Akses platform dengan akun yang telah terdaftar. Masukkan username dan password yang telah diberikan. Klik tombol 'Login' untuk mengakses dashboard.",
                  imagePath: "assets/images/user_guide/1.png",
                ),
                GuideBox(
                  number: 2,
                  text:
                      "Setelah melakukan login maka akan masuk pada halaman dashboard sebagai tampilan awal setelah login.",
                  imagePath: "assets/images/user_guide/2.png",
                ),
                GuideBox(
                  number: 3,
                  text: "Pilih kelas yang ingin diakses, ",
                  imagePath: "assets/images/user_guide/3.png",
                ),
                GuideBox(
                  number: 4,
                  text:
                      "kemudian lihat daftar mata pelajaran yang diajar atau diikuti. Kemudian pilih mata pelajaran untuk melakukan absensi.",
                  imagePath: "assets/images/user_guide/4.png",
                ),
                GuideBox(
                  number: 5,
                  text: "Buat absensi jika ingin menambah pertemuan",
                  imagePath: "assets/images/user_guide/5.png",
                ),
                GuideBox(
                  number: 6,
                  text: "Tambahkan judul absensi dan tanggal absensi",
                  imagePath: "assets/images/user_guide/6.png",
                ),
                GuideBox(
                  number: 7,
                  text:
                      "Pilih kelas yang sudah dibuat kemudian lakukan absensi pada siswa dengan keterangan H = Hadir, S = Sakit, I = Izin, A = Alfa.",
                  imagePath: "assets/images/user_guide/7.png",
                ),
                GuideBox(
                  number: 8,
                  text:
                      "Akses rekap absensi untuk melihat riwayat kehadiran siswa.",
                  imagePath: "assets/images/user_guide/8.png",
                ),
                GuideBox(
                  number: 9,
                  text: "Ekspor data rekap absensi jika diperlukan.",
                  imagePath: "assets/images/user_guide/9.png",
                ),
                GuideBox(
                  number: 10,
                  text:
                      "Akses informasi profil pribadi. Perbarui informasi pribadi seperti foto profil, nomor kontak, Jenis Kelamin, email. ",
                  imagePath: "assets/images/user_guide/10.png",
                ),
                GuideBox(
                  number: 11,
                  text: "Ganti password jika diperlukan",
                  imagePath: "assets/images/user_guide/11.png",
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: MyBottomNavBar(teacherTab: teacherTab),
    );
  }
}

class GuideBox extends StatelessWidget {
  const GuideBox({
    super.key,
    required this.number,
    required this.text,
    required this.imagePath,
  });
  final int number;
  final String text;
  final String imagePath;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "$number. ",
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                ),
              ),
              Flexible(
                child: Text(
                  text,
                  textAlign: TextAlign.justify,
                  style: const TextStyle(
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 5),
          Image.asset(imagePath),
        ],
      ),
    );
  }
}
