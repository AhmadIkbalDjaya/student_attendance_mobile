import 'package:flutter/material.dart';
import 'package:student_attendance/components/claass_list.dart';

class RecapClaassListPage extends StatelessWidget {
  const RecapClaassListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 25),
            decoration: const BoxDecoration(
              color: Color(0xFFD9D9D9),
            ),
            child: const Column(
              children: [
                Text(
                  "REKAP",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text("Pilih salah satu kelas di dan lihat rekap absensi"),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 15,
                horizontal: 20,
              ),
              child: ListView(
                children: const [
                  // ClaassList(nextpage: "recap"),
                  // ClaassList(),
                  // ClaassList(),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
