import 'dart:convert';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:http/http.dart' as http;
import 'package:student_attendance/models/teacher/teacher_course.dart';

part 'teacher_course_event.dart';
part 'teacher_course_state.dart';

class TeacherCourseBloc extends Bloc<TeacherCourseEvent, TeacherCourseState> {
  TeacherCourseBloc() : super(TeacherCourseInitial()) {
    on<GetTeacherCourseEvent>((event, emit) async {
      try {
        emit(TeacherCourseGetLoading());
        final response = await http.get(
          Uri.parse(
              "https://mobile.attendance.sman17gowa.com/api/teacherCourses"),
          headers: {
            HttpHeaders.acceptHeader: "application/json",
            HttpHeaders.authorizationHeader:
                "Bearer 19|dWPOhkhMBok01DSxAXzsnA94pMUA740pYQT9SnSb330f1de8",
          },
        );
        if (response.statusCode == 200) {
          emit(TeacherCourseGetSuccess(
              teacherCourses: teacherCourseFromJson(response.body)));
        } else {
          TeacherCourseFailure(message: jsonDecode(response.body)["message"]);
        }
      } catch (e) {
        emit(TeacherCourseFailure(message: e.toString()));
      }
    });
  }
}
