import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:http/http.dart' as http;
import 'package:student_attendance/values/constant.dart' as constant;
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
              "${constant.apiUrl}/teacher/studentAttendance/${event.attendanceId}?_method=put"),
          headers: constant.apiHeaderWithToken,
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
