import 'package:flutter/material.dart';

class CourseAttendancePage extends StatelessWidget {
  const CourseAttendancePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
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
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Column(
                  children: [
                    const Text(
                      "KELAS",
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Bahasa Indonesia (XII IPA 1)",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const Text(
                            "(Genap) 2022/2023",
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          const SizedBox(height: 10),
                          ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF696CFF),
                            ),
                            child: const Text("Buat Absensi"),
                          ),
                        ],
                      ),
                    )
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
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: ListView(
              children: [
                AttendanceBox(),
                AttendanceBox(),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class AttendanceBox extends StatelessWidget {
  const AttendanceBox({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(10),
      ),
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(10),
            decoration: const BoxDecoration(
              color: Color(0xFFC4C4C4),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
            ),
            child: const Text(
              "Pertemuan 1",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Row(
                  children: [
                    Icon(Icons.people),
                    SizedBox(width: 5),
                    Text(
                      "Kehadiran",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 5,
                      height: 5,
                      child: Checkbox(
                        value: false,
                        onChanged: (value) {},
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.delete),
                    )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
