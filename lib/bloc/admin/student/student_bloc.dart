import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:student_attendance/models/admin/student.dart';

part 'student_event.dart';
part 'student_state.dart';

class StudentBloc extends Bloc<StudentEvent, StudentState> {
  StudentBloc() : super(StudentInitial()) {
    on<GetAllStudentEvent>((event, emit) async {
      emit(StudentLoading());
      final response = await http.get(
        Uri.parse("https://mobile.attendance.sman17gowa.com/api/admin/student"),
        headers: {HttpHeaders.acceptHeader: "application/json"},
      );
      emit(StudentSuccess(students: studentsFromJson(response.body)));
    });
  }
}
