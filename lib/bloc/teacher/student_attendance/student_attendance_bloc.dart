import 'dart:convert';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:http/http.dart' as http;
import 'package:student_attendance/models/teacher/student_attendance.dart';

part 'student_attendance_event.dart';
part 'student_attendance_state.dart';

class StudentAttendanceBloc
    extends Bloc<StudentAttendanceEvent, StudentAttendanceState> {
  StudentAttendanceBloc() : super(StudentAttendanceInitial()) {
    on<GetStudentAttendanceEvent>((event, emit) async {
      try {
        emit(StudentAttendanceGetLoading());
        final response = await http.get(
            Uri.parse(
                "https://mobile.attendance.sman17gowa.com/api/teacher/attendance/${event.attendanceId}"),
            headers: {HttpHeaders.acceptHeader: "application/json"});
        if (response.statusCode == 200) {
          emit(StudentAttendanceGetSuccess(
            studentAttendance: studentAttendanceFromJson(response.body),
          ));
        } else {
          emit(StudentAttendanceFailure(
            message: jsonDecode(response.body)["message"],
          ));
        }
      } catch (e) {
        emit(StudentAttendanceFailure(message: e.toString()));
      }
    });
  }
}