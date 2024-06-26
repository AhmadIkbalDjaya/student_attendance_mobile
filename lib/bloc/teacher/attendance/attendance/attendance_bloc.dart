import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:http/http.dart' as http;
import 'package:student_attendance/values/constant.dart';
import 'package:student_attendance/models/teacher/course_attendance.dart';

part 'attendance_event.dart';
part 'attendance_state.dart';

class AttendanceBloc extends Bloc<AttendanceEvent, AttendanceState> {
  AttendanceBloc() : super(AttendanceInitial()) {
    on<GetCourseAttendanceEvent>(
      (event, emit) async {
        try {
          emit(AttendanceGetLoading());
          final response = await http.get(
            Uri.parse(
                "${ApiConfig.url}/teacher/attendance/course/${event.courseId}"),
            headers: ApiConfig.headerWithToken,
          );
          if (response.statusCode == 200) {
            emit(AttendanceGetSuccess(
                courseAttendance: courseAttendanceFromJson(response.body)));
          } else {
            emit(AttendanceFailure(
                message: jsonDecode(response.body)['message']));
          }
        } catch (e) {
          emit(AttendanceFailure(message: e.toString()));
        }
      },
    );

    on<GetDetailAttendanceEvent>(
      (event, emit) async {
        try {
          emit(AttendanceGetLoading());
          final response = await http.get(
            Uri.parse(
                "${ApiConfig.url}/teacher/attendance/${event.attendanceId}"),
            headers: ApiConfig.headerWithToken,
          );
          if (response.statusCode == 200) {
            emit(AttendanceDetailSucces(
                attendance: attendanceFromJson(response.body)));
          } else {
            emit(
              AttendanceFailure(message: jsonDecode(response.body).toString()),
            );
          }
        } catch (e) {
          emit(AttendanceFailure(message: e.toString()));
        }
      },
    );

    on<DeleteAttendanceEvent>(
      (event, emit) async {
        try {
          emit(AttendanceLoading());
          final response = await http.delete(
            Uri.parse(
                "${ApiConfig.url}/teacher/attendance/${event.attendanceId}"),
            headers: ApiConfig.headerWithToken,
          );
          if (response.statusCode == 200) {
            emit(AttendanceDeleteSuccess());
          } else {
            emit(
              AttendanceFailure(message: jsonDecode(response.body)["message"]),
            );
          }
        } catch (e) {
          emit(AttendanceFailure(message: e.toString()));
        }
      },
    );
  }
}
