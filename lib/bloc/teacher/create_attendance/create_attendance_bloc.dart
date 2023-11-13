import 'dart:convert';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:http/http.dart' as http;

part 'create_attendance_event.dart';
part 'create_attendance_state.dart';

class CreateAttendanceBloc
    extends Bloc<CreateAttendanceEvent, CreateAttendanceState> {
  CreateAttendanceBloc() : super(CreateAttendanceInitial()) {
    on<CreateNewAttendanceEvent>((event, emit) async {
      try {
        emit(CreateAttendanceLoading());
        final response = await http.post(
          Uri.parse(
              "https://mobile.attendance.sman17gowa.com/api/teacher/attendance/create/${event.courseId}"),
          headers: {HttpHeaders.acceptHeader: "application/json"},
          body: {
            "title": event.title,
            "datetime": event.datetime,
          },
        );
        if (response.statusCode == 200) {
          emit(CreateAttendanceSuccess());
        } else {
          emit(CreateAttendanceFailure(
              message: jsonDecode(response.body)["message"]));
        }
      } catch (e) {
        emit(CreateAttendanceFailure(message: e.toString()));
      }
    });
  }
}
