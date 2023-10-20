import 'package:flutter/material.dart';
import 'package:student_attendance/components/MyAppBar.dart';
import 'package:student_attendance/components/MyDrawer.dart';

class AdminCreateCoursePage extends StatelessWidget {
  const AdminCreateCoursePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(),
      drawer: const MyDrawer(),
      body: Column(
        children: [
          Container(
            decoration: const BoxDecoration(
              color: Color(0xFFD9D9D9),
            ),
            padding:
                const EdgeInsets.only(top: 0, bottom: 10, right: 10, left: 10),
            width: double.infinity,
            child: Stack(
              alignment: Alignment.center,
              children: [
                const Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: Column(
                    children: [
                      Text(
                        "Tambahkan Mapel",
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        "Tambahkan Mapel pada colom dibawah",
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: 0,
                  left: 0,
                  child: IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.arrow_back),
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
                    horizontal: 10,
                  ),
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(15),
                    ),
                    color: Color(0xFFD9D9D9),
                  ),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 40,
                        child: TextField(
                          decoration: InputDecoration(
                            label: Text("Nama Mapel"),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(8),
                              ),
                            ),
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 0,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 25),
                      SizedBox(
                        height: 40,
                        width: double.infinity,
                        child: DropdownButtonFormField(
                          hint: const Text("Guru Pengajar"),
                          items: const [
                            DropdownMenuItem(
                              value: "1",
                              child: Text("Agung"),
                            ),
                            DropdownMenuItem(
                              value: "2",
                              child: Text("Umar"),
                            ),
                          ],
                          decoration: const InputDecoration(
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 10),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(8),
                              ),
                            ),
                          ),
                          onChanged: (value) {},
                        ),
                      ),
                      const SizedBox(height: 25),
                      SizedBox(
                        height: 40,
                        width: double.infinity,
                        child: DropdownButtonFormField(
                          hint: const Text("Kelas"),
                          items: const [
                            DropdownMenuItem(
                              value: "10",
                              child: Text("Al-Khawarizmi"),
                            ),
                            DropdownMenuItem(
                              value: "11",
                              child: Text("Al-Biruni"),
                            ),
                          ],
                          decoration: const InputDecoration(
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 10),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(8),
                              ),
                            ),
                          ),
                          onChanged: (value) {},
                        ),
                      ),
                      const SizedBox(height: 25),
                      SizedBox(
                        height: 40,
                        width: double.infinity,
                        child: DropdownButtonFormField(
                          hint: const Text("Semester"),
                          items: const [
                            DropdownMenuItem(
                              value: "1",
                              child: Text("Ganjil 2022/2023"),
                            ),
                            DropdownMenuItem(
                              value: "11",
                              child: Text("Genap 2022/2023"),
                            ),
                          ],
                          decoration: const InputDecoration(
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 10),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(8),
                              ),
                            ),
                          ),
                          onChanged: (value) {},
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF696CFF),
                    ),
                    child: const Text("Simpan"),
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
