import 'dart:convert';
import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:http/http.dart' as http;
import 'package:student_attendance/values/constant.dart';
part 'update_student_attendance_event.dart';
part 'update_student_attendance_state.dart';

class UpdateStudentAttendanceBloc
    extends Bloc<UpdateStudentAttendanceEvent, UpdateStudentAttendanceState> {
  UpdateStudentAttendanceBloc() : super(UpdateStudentAttendanceInitial()) {
    on<UpdateEvent>((event, emit) async {
      try {
        emit(UpdateStudentAttendanceLoading());
        var request = http.MultipartRequest(
            "POST",
            Uri.parse(
                "${ApiConfig.url}/teacher/studentAttendance/${event.attendanceId}?_method=put"));
        request.headers.addAll(ApiConfig.headerWithToken);
        for (var i = 0; i < event.ids.length; i++) {
          request.fields['ids[$i]'] = event.ids[i];
          request.fields['status_ids[$i]'] = event.statusesId[i];
          if (event.images[i] is String) {
            request.fields['images[$i]'] = event.images[i];
          }
          if (event.images[i] is Uint8List) {
            request.files.add(http.MultipartFile(
                'images[$i]',
                http.ByteStream.fromBytes(event.images[i]),
                event.images[i].length,
                filename: "images[$i]"));
          }
        }
        final response = await request.send();
        if (response.statusCode == 200) {
          emit(UpdateStudentAttendanceSuccess());
        } else {
          String responseBody = await response.stream.bytesToString();
          emit(
            UpdateStudentAttendanceFailure(
                message: jsonDecode(responseBody)['message']),
          );
        }
      } catch (e) {
        emit(UpdateStudentAttendanceFailure(message: e.toString()));
      }
    });
  }
}
