import 'package:flutter/material.dart';
import 'package:student_attendance/bloc/teacher_tab_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student_attendance/components/my_bottom_nav_bar.dart';

class CourseRecapPage extends StatelessWidget {
  const CourseRecapPage({super.key});

  @override
  Widget build(BuildContext context) {
    TeacherTabBloc teacherTab = context.read<TeacherTabBloc>();
    return Scaffold(
      body: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 0),
            color: const Color(0xFFD9D9D9),
            child: Stack(
              alignment: Alignment.center,
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                  child: Column(
                    children: [
                      Text(
                        "Rakapan Siswa",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "Bahasa Indonesia XII IPA 1",
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                      SizedBox(height: 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.leaderboard_rounded),
                              SizedBox(width: 10),
                              Text(
                                "(Genap) 2022/2023",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                "15 Pertemuan",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              SizedBox(width: 10),
                              Icon(Icons.meeting_room),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: 0,
                  left: 0,
                  child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.arrow_back),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 3),
              child: ListView(
                children: [
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: DataTable(
                      border: TableBorder.all(
                        width: 2,
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(3),
                      ),
                      columns: const [
                        DataColumn(
                          label: Text(
                            "No",
                            style: TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            "Nama",
                            style: TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            "NIS",
                            style: TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            "L/P",
                            style: TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                        ),
                        DataColumn(
                          label: Text("H"),
                        ),
                        DataColumn(
                          label: Text("S"),
                        ),
                        DataColumn(
                          label: Text("I"),
                        ),
                        DataColumn(
                          label: Text("A"),
                        ),
                      ],
                      rows: const [
                        DataRow(
                          cells: [
                            DataCell(
                              Text("1"),
                            ),
                            DataCell(
                              Text("Ahmad Ikbal Djaya"),
                            ),
                            DataCell(
                              Text("60200120073"),
                            ),
                            DataCell(
                              Text("P"),
                            ),
                            DataCell(
                              Text("1"),
                            ),
                            DataCell(
                              Text("1"),
                            ),
                            DataCell(
                              Text("1"),
                            ),
                            DataCell(
                              Text("1"),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF696CFF),
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.print),
                        Text("Print"),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: MyBottomNavBar(teacherTab: teacherTab),
    );
  }
}
