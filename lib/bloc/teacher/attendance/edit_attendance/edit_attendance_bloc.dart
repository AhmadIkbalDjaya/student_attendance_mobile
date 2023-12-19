import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:http/http.dart' as http;
import 'package:student_attendance/values/constant.dart';

part 'edit_attendance_event.dart';
part 'edit_attendance_state.dart';

class EditAttendanceBloc
    extends Bloc<EditAttendanceEvent, EditAttendanceState> {
  EditAttendanceBloc() : super(EditAttendanceInitial()) {
    on<EditEvent>((event, emit) async {
      try {
        emit(EditAttendanceLoading());
        final response = await http.post(
          Uri.parse(
              "${ApiConfig.url}/teacher/attendance/${event.attendanceId}?_method=put"),
          headers: ApiConfig.headerWithToken,
          body: {
            "title": event.title,
            "datetime": event.datetime,
          },
        );
        if (response.statusCode == 200) {
          emit(EditAttendanceSuccess());
        } else {
          emit(EditAttendanceFailure(
              message: jsonDecode(response.body)["message"]));
        }
      } catch (e) {
        emit(EditAttendanceFailure(message: e.toString()));
      }
    });
  }
}
