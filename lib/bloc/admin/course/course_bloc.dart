import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:http/http.dart' as http;
import 'package:student_attendance/values/constant.dart';
import 'package:student_attendance/models/admin/course.dart';

part 'course_event.dart';
part 'course_state.dart';

class CourseBloc extends Bloc<CourseEvent, CourseState> {
  CourseBloc() : super(CourseInitial()) {
    on<GetAllCourseEvent>((event, emit) async {
      try {
        emit(CourseGetLoading());
        final response = await http.get(
          Uri.parse("${ApiConfig.url}/admin/course"),
          headers: ApiConfig.headerWithToken,
        );
        if (response.statusCode == 200) {
          emit(CourseAllSuccess(courses: coursesFromJson(response.body)));
        } else {
          emit(CourseFailure(message: jsonDecode(response.body)["message"]));
        }
      } catch (e) {
        emit(CourseFailure(message: e.toString()));
      }
    });

    on<GetDetailCourseEvent>((event, emit) async {
      try {
        emit(CourseGetLoading());
        final response = await http.get(
          Uri.parse("${ApiConfig.url}/admin/course/${event.id}"),
          headers: ApiConfig.headerWithToken,
        );
        if (response.statusCode == 200) {
          emit(CourseDetailSuccess(course: courseFromJson(response.body)));
        } else {
          emit(CourseFailure(message: jsonDecode(response.body)["message"]));
        }
      } catch (e) {
        emit(CourseFailure(message: e.toString()));
      }
    });

    on<AddCourseEvent>((event, emit) async {
      try {
        emit(CourseLoading());
        final response = await http.post(
          Uri.parse("${ApiConfig.url}/admin/course"),
          headers: ApiConfig.headerWithToken,
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
        emit(CourseFailure(message: e.toString()));
      }
    });

    on<EditCourseEvent>((event, emit) async {
      try {
        emit(CourseLoading());
        final response = await http.post(
          Uri.parse("${ApiConfig.url}/admin/course/${event.id}?_method=put"),
          headers: ApiConfig.headerWithToken,
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
        emit(CourseFailure(message: e.toString()));
      }
    });

    on<DeleteCourseEvent>((event, emit) async {
      try {
        emit(CourseLoading());
        final response = await http.delete(
          Uri.parse("${ApiConfig.url}/admin/course/${event.id}"),
          headers: ApiConfig.headerWithToken,
        );
        if (response.statusCode == 200) {
          emit(CourseDeleteSuccess());
        } else {
          emit(CourseFailure(message: jsonDecode(response.body)["message"]));
        }
      } catch (e) {
        emit(CourseFailure(message: e.toString()));
      }
    });
  }
}
