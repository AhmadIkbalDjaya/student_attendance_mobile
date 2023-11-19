import 'dart:convert';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:http/http.dart' as http;
import 'package:student_attendance/values/constant.dart' as constant;
import 'package:student_attendance/models/admin/semester.dart';

part 'semester_event.dart';
part 'semester_state.dart';

class SemesterBloc extends Bloc<SemesterEvent, SemesterState> {
  SemesterBloc() : super(SemesterInitial()) {
    on<GetAllSemesterEvent>((event, emit) async {
      try {
        emit(SemesterGetLoading());
        final response = await http.get(
          Uri.parse("${constant.apiUrl}/admin/semester"),
          headers: {HttpHeaders.acceptHeader: "application/json"},
        );
        if (response.statusCode == 200) {
          emit(SemesterAllSuccess(semesters: semestersFromJson(response.body)));
        } else {
          emit(SemesterFailure(message: jsonDecode(response.body)["message"]));
        }
      } catch (e) {
        emit(SemesterFailure(message: e.toString()));
      }
    });

    on<GetDetailSemesterEvent>((event, emit) async {
      try {
        emit(SemesterGetLoading());
        final response = await http.get(
          Uri.parse("${constant.apiUrl}/admin/semester/${event.semesterId}"),
          headers: {HttpHeaders.acceptHeader: "application/json"},
        );
        if (response.statusCode == 200) {
          emit(
              SemesterDetailSuccess(semester: semesterFromJson(response.body)));
        } else {
          emit(SemesterFailure(message: jsonDecode(response.body)["message"]));
        }
      } catch (e) {
        emit(SemesterFailure(message: e.toString()));
      }
    });

    on<AddSemesterEvent>((event, emit) async {
      try {
        emit(SemesterLoading());
        final response = await http.post(
          Uri.parse("${constant.apiUrl}/admin/semester"),
          headers: {HttpHeaders.acceptHeader: "application/json"},
          body: {
            "start_year": event.startYear,
            "odd_even": event.oddEven,
          },
        );
        if (response.statusCode == 200) {
          emit(SemesterAddSuccess());
        } else {
          var message = jsonDecode(response.body)["message"];
          emit(SemesterValidationError(message: message));
        }
      } catch (e) {
        emit(SemesterFailure(message: e.toString()));
      }
    });

    on<EditSemesterEvent>((event, emit) async {
      try {
        emit(SemesterLoading());
        final response = await http.post(
          Uri.parse(
              "${constant.apiUrl}/admin/semester/${event.id}?_method=put"),
          headers: {HttpHeaders.acceptHeader: "application/json"},
          body: {
            "start_year": event.startYear,
            "odd_even": event.oddEven,
          },
        );
        if (response.statusCode == 200) {
          emit(SemesterEditSuccess());
        } else {
          final message = jsonDecode(response.body)["message"];
          emit(SemesterValidationError(message: message));
        }
      } catch (e) {
        emit(SemesterFailure(message: e.toString()));
      }
    });

    on<DeleteSemesterEvent>((event, emit) async {
      try {
        emit(SemesterLoading());
        final response = await http.delete(
          Uri.parse("${constant.apiUrl}/admin/semester/${event.id}"),
          headers: {HttpHeaders.acceptHeader: "application/json"},
        );
        if (response.statusCode == 200) {
          emit(SemesterDeleteSuccess());
        } else {
          emit(SemesterFailure(message: jsonDecode(response.body)["message"]));
        }
      } catch (e) {
        emit(SemesterFailure(message: e.toString()));
      }
    });

    on<ChangeSemesterEvent>((event, emit) async {
      try {
        emit(SemesterLoading());
        final response = await http.get(
          Uri.parse("${constant.apiUrl}/admin/semester/${event.id}/setActive"),
          headers: {HttpHeaders.acceptHeader: "application/json"},
        );
        if (response.statusCode == 200) {
          emit(SemesterChangeSuccess());
        } else {
          final message = jsonDecode(response.body)["message"];
          emit(SemesterValidationError(message: message));
        }
      } catch (e) {
        emit(SemesterFailure(message: e.toString()));
      }
    });
  }
}
