import 'package:flutter/material.dart';
import 'package:student_attendance/components/ClaassList.dart';

class ClaassPage extends StatelessWidget {
  const ClaassPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
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
                "KELAS",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text("Pilih salah satu kelas di bawah"),
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
              children: [
                ClaassList(),
                ClaassList(),
                ClaassList(),
              ],
            ),
          ),
        )
      ],
    );
  }
}
