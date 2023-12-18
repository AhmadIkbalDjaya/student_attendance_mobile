import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:http/http.dart' as http;
import 'package:student_attendance/values/constant.dart' as constant;

part 'create_attendance_event.dart';
part 'create_attendance_state.dart';

class CreateAttendanceBloc
    extends Bloc<CreateAttendanceEvent, CreateAttendanceState> {
  CreateAttendanceBloc() : super(CreateAttendanceInitial()) {
    on<CreateNewAttendanceEvent>((event, emit) async {
      try {
        emit(CreateAttendanceLoading());
        final response = await http.post(
          Uri.parse("${constant.apiUrl}/teacher/attendance"),
          headers: constant.apiHeaderWithToken,
          body: {
            "course_id": event.courseId,
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
