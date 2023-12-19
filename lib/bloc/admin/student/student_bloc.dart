import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:student_attendance/values/constant.dart';
import 'package:student_attendance/models/admin/student.dart';

part 'student_event.dart';
part 'student_state.dart';

class StudentBloc extends Bloc<StudentEvent, StudentState> {
  StudentBloc() : super(StudentInitial()) {
    on<GetAllStudentEvent>((event, emit) async {
      try {
        emit(StudentGetLoading());
        final response = await http.get(
          Uri.parse("${ApiConfig.url}/admin/studentByClaass/${event.claassId}"),
          headers: ApiConfig.headerWithToken,
        );
        if (response.statusCode == 200) {
          emit(StudentAllSuccess(students: studentsFromJson(response.body)));
        } else {
          emit(StudentFailure(message: jsonDecode(response.body)["message"]));
        }
      } catch (e) {
        emit(StudentFailure(message: e.toString()));
      }
    });

    on<GetDetailStudentEvent>((event, emit) async {
      try {
        emit(StudentGetLoading());
        final response = await http.get(
          Uri.parse("${ApiConfig.url}/admin/student/${event.studentId}"),
          headers: ApiConfig.headerWithToken,
        );
        if (response.statusCode == 200) {
          emit(StudentDetailSuccess(student: studentFromJson(response.body)));
        } else {
          emit(StudentFailure(message: jsonDecode(response.body)["message"]));
        }
      } catch (e) {
        emit(StudentFailure(message: e.toString()));
      }
    });

    on<AddStudentEvent>((event, emit) async {
      try {
        emit(StudentLoading());
        final response = await http.post(
          Uri.parse("${ApiConfig.url}/admin/student"),
          body: {
            "nis": event.nis,
            "name": event.name,
            "gender": event.gender,
            "claass_id": event.classId
          },
          headers: ApiConfig.headerWithToken,
        );
        if (response.statusCode == 200) {
          emit(StudentAddSuccess());
        } else {
          var message = json.decode(response.body)['message'];
          emit(StudentValidationError(message: message));
        }
      } catch (e) {
        emit(StudentFailure(message: e.toString()));
      }
    });

    on<EditStudentEvent>((event, emit) async {
      try {
        emit(StudentLoading());
        final response = await http.post(
          Uri.parse("${ApiConfig.url}/admin/student/${event.id}?_method=put"),
          body: {
            "nis": event.nis,
            "name": event.name,
            "gender": event.gender,
            "claass_id": event.classId
          },
          headers: ApiConfig.headerWithToken,
        );
        if (response.statusCode == 200) {
          emit(StudentEditSuccess());
        } else {
          var message = json.decode(response.body)['message'];
          emit(StudentValidationError(message: message));
        }
      } catch (e) {
        emit(StudentFailure(message: e.toString()));
      }
    });

    on<DeleteStudentEvent>((event, emit) async {
      try {
        emit(StudentLoading());
        final response = await http.delete(
          Uri.parse("${ApiConfig.url}/admin/student/${event.id}"),
          headers: ApiConfig.headerWithToken,
        );
        if (response.statusCode == 200) {
          emit(StudentDeleteSuccess());
        } else {
          emit(StudentFailure(message: jsonDecode(response.body)["message"]));
        }
      } catch (e) {
        emit(StudentFailure(message: e.toString()));
      }
    });
  }
}
