import 'dart:convert';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:http/http.dart' as http;

part 'update_student_attendance_event.dart';
part 'update_student_attendance_state.dart';

class UpdateStudentAttendanceBloc
    extends Bloc<UpdateStudentAttendanceEvent, UpdateStudentAttendanceState> {
  UpdateStudentAttendanceBloc() : super(UpdateStudentAttendanceInitial()) {
    on<UpdateEvent>((event, emit) async {
      try {
        emit(UpdateStudentAttendanceLoading());
        Map<String, dynamic> requrestBody = {};
        for (var i = 0; i < event.ids.length; i++) {
          requrestBody['ids[$i]'] = event.ids[i];
          requrestBody['status_ids[$i]'] = event.statusesId[i];
        }
        final response = await http.post(
          Uri.parse(
              "https://mobile.attendance.sman17gowa.com/api/teacher/attendance/update/${event.attendanceId}"),
          headers: {HttpHeaders.acceptHeader: "application/json"},
          body: requrestBody,
        );
        if (response.statusCode == 200) {
          emit(UpdateStudentAttendanceSuccess());
        } else {
          emit(
            UpdateStudentAttendanceFailure(
                message: jsonDecode(response.body)['message']),
          );
        }
      } catch (e) {
        emit(UpdateStudentAttendanceFailure(message: e.toString()));
      }
    });
  }
}
