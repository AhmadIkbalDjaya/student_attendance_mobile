import 'package:flutter/material.dart';
import 'package:student_attendance/models/teacher/course_attendance.dart';

class AttendanceBox extends StatelessWidget {
  const AttendanceBox({super.key, required this.attendance});
  final Attendance attendance;
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
            child: Text(
              attendance.title,
              textAlign: TextAlign.center,
              style: const TextStyle(
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
                Expanded(
                  child: InkWell(
                    onTap: () {
                      Navigator.pushNamed(
                          context, "/teacher/attendance/attend");
                    },
                    child: const Row(
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
                  ),
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 5,
                      height: 5,
                      child: Checkbox(
                        value: attendance.isFilled == "1" ? true : false,
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
