import 'dart:convert';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:http/http.dart' as http;
import 'package:student_attendance/models/admin/course.dart';

part 'course_event.dart';
part 'course_state.dart';

class CourseBloc extends Bloc<CourseEvent, CourseState> {
  CourseBloc() : super(CourseInitial()) {
    on<GetAllCourseEvent>((event, emit) async {
      emit(CourseGetLoading());
      final response = await http.get(
        Uri.parse("https://mobile.attendance.sman17gowa.com/api/admin/course"),
        headers: {HttpHeaders.acceptHeader: "application/json"},
      );
      emit(CourseAllSuccess(courses: coursesFromJson(response.body)));
    });

    on<GetDetailCourseEvent>((event, emit) async {
      emit(CourseGetLoading());
      final response = await http.get(
        Uri.parse(
            "https://mobile.attendance.sman17gowa.com/api/admin/course/${event.id}"),
        headers: {HttpHeaders.acceptHeader: "application/json"},
      );
      emit(CourseDetailSuccess(course: courseFromJson(response.body)));
    });

    on<AddCourseEvent>(
      (event, emit) async {
        try {
          emit(CourseLoading());
          final response = await http.post(
            Uri.parse(
                "https://mobile.attendance.sman17gowa.com/api/admin/course"),
            headers: {HttpHeaders.acceptHeader: "application/json"},
            body: {
              "name": event.name,
              "claass_id": event.claassId,
              "teacher_id": event.teacherId,
              "semester_id": event.semesterId,
            },
          );
          if (response.statusCode == 200) {
            emit(CourseAddSuccess());
          } else {
            final message = jsonDecode(response.body)["message"];
            emit(CourseValidationError(message: message));
          }
        } catch (e) {
          emit(CourseFailure());
        }
      },
    );

    on<EditCourseEvent>((event, emit) async {
      try {
        emit(CourseLoading());
        final response = await http.post(
          Uri.parse(
              "https://mobile.attendance.sman17gowa.com/api/admin/course/${event.id}?_method=put"),
          headers: {HttpHeaders.acceptHeader: "application/json"},
          body: {
            "name": event.name,
            "claass_id": event.claassId,
            "teacher_id": event.teacherId,
            "semester_id": event.semesterId,
          },
        );
        if (response.statusCode == 200) {
          emit(CourseEditSuccess());
        } else {
          final message = jsonDecode(response.body)["message"];
          emit(CourseValidationError(message: message));
        }
      } catch (e) {
        emit(CourseFailure());
      }
    });

    on<DeleteCourseEvent>((event, emit) async {
      emit(CourseLoading());
      final response = await http.delete(
        Uri.parse(
            "https://mobile.attendance.sman17gowa.com/api/admin/course/${event.id}"),
        headers: {HttpHeaders.acceptHeader: "application/json"},
      );
      if (response.statusCode == 200) {
        emit(CourseDeleteSuccess());
      } else {
        emit(CourseFailure());
      }
    });
  }
}
