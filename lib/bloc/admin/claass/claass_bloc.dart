import 'dart:convert';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:http/http.dart' as http;
import 'package:student_attendance/models/admin/claass.dart';

part 'claass_event.dart';
part 'claass_state.dart';

class ClaassBloc extends Bloc<ClaassEvent, ClaassState> {
  ClaassBloc() : super(ClaassInitial()) {
    on<GetAllClaassEvent>((event, emit) async {
      try {
        emit(ClaassGetLoading());
        final response = await http.get(
          Uri.parse(
              "https://mobile.attendance.sman17gowa.com/api/admin/claass"),
          headers: {HttpHeaders.acceptHeader: "application/json"},
        );
        if (response.statusCode == 200) {
          emit(ClaassAllSuccess(claasses: claassesFromJson(response.body)));
        } else {
          emit(ClaassFailure(message: jsonDecode(response.body)["message"]));
        }
      } catch (e) {
        emit(ClaassFailure(message: e.toString()));
      }
    });

    on<GetDetailClaassEvent>((event, emit) async {
      try {
        emit(ClaassGetLoading());
        final response = await http.get(
          Uri.parse(
              "https://mobile.attendance.sman17gowa.com/api/admin/claass/${event.claassId}"),
          headers: {HttpHeaders.acceptHeader: "application/json"},
        );
        if (response.statusCode == 200) {
          emit(ClaassDetailSuccess(claass: claassFromJson(response.body)));
        } else {
          emit(ClaassFailure(message: jsonDecode(response.body)["message"]));
        }
      } catch (e) {
        emit(ClaassFailure(message: e.toString()));
      }
    });

    on<AddClaassEvent>((event, emit) async {
      try {
        emit(ClaassLoading());
        final response = await http.post(
          Uri.parse(
              "https://mobile.attendance.sman17gowa.com/api/admin/claass"),
          headers: {HttpHeaders.acceptHeader: "application/json"},
          body: {
            "major_id": event.majorId,
            "level": event.level,
            "name": event.name,
          },
        );
        if (response.statusCode == 200) {
          emit(ClaassAddSuccess());
        } else {
          var message = jsonDecode(response.body)["message"];
          emit(ClaassValidationError(message: message));
        }
      } catch (e) {
        emit(ClaassFailure());
      }
    });

    on<EditClaassEvent>((event, emit) async {
      try {
        emit(ClaassLoading());
        final response = await http.post(
          Uri.parse(
              "https://mobile.attendance.sman17gowa.com/api/admin/claass/${event.id}?_method=put"),
          headers: {HttpHeaders.acceptHeader: "application/json"},
          body: {
            "major_id": event.majorId,
            "level": event.level,
            "name": event.name,
          },
        );
        if (response.statusCode == 200) {
          emit(ClaassEditSuccess());
        } else {
          var message = jsonDecode(response.body)["message"];
          emit(ClaassValidationError(message: message));
        }
      } catch (e) {
        emit(ClaassFailure());
      }
    });

    on<DeleteClaassEvent>((event, emit) async {
      try {
        emit(ClaassLoading());
        final response = await http.delete(
          Uri.parse(
              "https://mobile.attendance.sman17gowa.com/api/admin/claass/${event.id}"),
          headers: {HttpHeaders.acceptHeader: "application/json"},
        );
        if (response.statusCode == 200) {
          emit(ClaassDeleteSuccess());
        } else {
          emit(ClaassFailure(message: jsonDecode(response.body)["message"]));
        }
      } catch (e) {
        emit(ClaassFailure(message: e.toString()));
      }
    });
  }
}
