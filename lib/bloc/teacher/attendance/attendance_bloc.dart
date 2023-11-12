import 'dart:convert';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:http/http.dart' as http;
import 'package:student_attendance/models/teacher/course_attendance.dart';

part 'attendance_event.dart';
part 'attendance_state.dart';

class AttendanceBloc extends Bloc<AttendanceEvent, AttendanceState> {
  AttendanceBloc() : super(AttendanceInitial()) {
    on<GetCourseAttendanceEvent>((event, emit) async {
      try {
        emit(AttendanceGetLoading());
        final response = await http.get(
          Uri.parse(
              "https://mobile.attendance.sman17gowa.com/api/teacher/attendance/list/${event.courseId}"),
          headers: {HttpHeaders.acceptHeader: "application/json"},
        );
        if (response.statusCode == 200) {
          emit(AttendanceGetSuccess(
              courseAttendance: courseAttendanceFromJson(response.body)));
        } else {
          emit(
              AttendanceFailure(message: jsonDecode(response.body)['message']));
        }
      } catch (e) {
        emit(AttendanceFailure(message: e.toString()));
      }
    });
  }
}
