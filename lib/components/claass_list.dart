import 'package:flutter/material.dart';
import 'package:student_attendance/models/teacher/teacher_course.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ClaassList extends StatelessWidget {
  ClaassList(
      {super.key, this.nextpage = "attendance", required this.teacherCourse});
  final String nextpage;
  final TeacherCourse teacherCourse;
  final showCourses = ShowCoursesCubit();

  @override
  Widget build(BuildContext context) {
    bool allClaassEmpty = true;
    for (var i = 0; i < teacherCourse.levels.length; i++) {
      Level level = teacherCourse.levels[i];
      if (level.claasses.isNotEmpty) {
        allClaassEmpty = false;
        break;
      }
    }
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(10),
      ),
      margin: const EdgeInsets.symmetric(vertical: 25),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(15),
            decoration: const BoxDecoration(
              color: Color(0xFFD9D9D9),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
            ),
            child: Text(
              teacherCourse.major,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 15,
            ),
            child: allClaassEmpty
                ? Center(
                    child: Text(
                      "Anda Tidak Mengajar Kelas Apapun di Jurusan ${teacherCourse.major}",
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Kelas :",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Column(
                        children: List<Widget>.generate(
                          teacherCourse.levels.length,
                          (index) {
                            Level level = teacherCourse.levels[index];
                            if (level.claasses.isNotEmpty) {
                              return Row(
                                children: [
                                  Text(
                                    level.level,
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  const SizedBox(width: 25),
                                  Expanded(
                                    child: SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: Row(
                                        children: List<Widget>.generate(
                                          level.claasses.length,
                                          (index) {
                                            Claass claass =
                                                level.claasses[index];
                                            if (claass.courses.isNotEmpty) {
                                              return Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 10),
                                                child: ElevatedButton(
                                                  onPressed: () {
                                                    showCourses.handleClick(
                                                        claassName:
                                                            claass.claassName,
                                                        courses:
                                                            claass.courses);
                                                  },
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                          backgroundColor:
                                                              const Color(
                                                                  0xFF696CFF)),
                                                  child:
                                                      Text(claass.claassName),
                                                ),
                                              );
                                            }
                                            return Container();
                                          },
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              );
                            }
                            return Container();
                          },
                        ),
                      ),
                      BlocBuilder<ShowCoursesCubit, Map<String, dynamic>>(
                        bloc: showCourses,
                        builder: (context, state) {
                          if (state["show"] == true) {
                            return Container(
                              width: double.infinity,
                              padding: const EdgeInsets.all(15),
                              margin: const EdgeInsets.only(top: 10),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  width: 2,
                                  color: Colors.grey,
                                ),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(state["claassName"]),
                                  Column(
                                    children: List<Widget>.generate(
                                      state["courses"].length,
                                      (index) {
                                        Course course = state["courses"][index];
                                        return SizedBox(
                                          width: double.infinity,
                                          child: ElevatedButton(
                                            onPressed: () {
                                              if (nextpage == "attendance") {
                                                Navigator.pushNamed(
                                                  context,
                                                  "/teacher/attendance/course",
                                                  arguments: {
                                                    "courseId": course.id
                                                  },
                                                );
                                              } else if (nextpage == "recap") {
                                                Navigator.pushNamed(
                                                  context,
                                                  "/teacher/recap/course",
                                                  arguments: {
                                                    "courseId": course.id
                                                  },
                                                );
                                              }
                                            },
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor:
                                                  const Color(0xFF696CFF),
                                            ),
                                            child: Text(course.courseName),
                                          ),
                                        );
                                      },
                                    ),
                                  )
                                ],
                              ),
                            );
                          }
                          return Container();
                        },
                      ),
                    ],
                  ),
          )
        ],
      ),
    );
  }
}

class ShowCoursesCubit extends Cubit<Map<String, dynamic>> {
  ShowCoursesCubit({
    bool? show,
    String? claassName,
    List<Course>? courses,
  }) : super({
          "show": show ?? false,
          "claassName": claassName ?? "",
          "courses": courses ?? <Course>[],
        });

  void handleClick({String? claassName, List<Course>? courses}) {
    emit({
      "show": !state["show"],
      "claassName": claassName,
      "courses": courses,
    });
  }
}
