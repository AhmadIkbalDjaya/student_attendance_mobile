import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:http/http.dart' as http;
import 'package:student_attendance/models/teacher/teacher_course.dart';
import 'package:student_attendance/values/constant.dart';

part 'teacher_course_event.dart';
part 'teacher_course_state.dart';

class TeacherCourseBloc extends Bloc<TeacherCourseEvent, TeacherCourseState> {
  TeacherCourseBloc() : super(TeacherCourseInitial()) {
    on<GetTeacherCourseEvent>((event, emit) async {
      try {
        emit(TeacherCourseGetLoading());
        final response = await http.get(
          Uri.parse("${ApiConfig.url}/teacher/teacherCourses"),
          headers: ApiConfig.headerWithToken,
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
