import 'dart:convert';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:http/http.dart' as http;
import 'package:student_attendance/models/teacher/course_recap.dart';

part 'course_recap_event.dart';
part 'course_recap_state.dart';

class CourseRecapBloc extends Bloc<CourseRecapEvent, CourseRecapState> {
  CourseRecapBloc() : super(CourseRecapInitial()) {
    on<GetCourseRecapEvent>((event, emit) async {
      try {
        emit(CourseRecapGetLoading());
        final response = await http.get(
          Uri.parse(
              "https://mobile.attendance.sman17gowa.com/api/teacher/recap/${event.courseId}"),
          headers: {
            HttpHeaders.acceptHeader: "application/json",
          },
        );
        if (response.statusCode == 200) {
          emit(
            CourseRecapSuccess(courseRecap: courseRecapFromJson(response.body)),
          );
        } else {
          emit(
            CourseRecapFailure(message: jsonDecode(response.body)['message']),
          );
        }
      } catch (e) {
        emit(CourseRecapFailure(message: e.toString()));
      }
    });
  }
}
