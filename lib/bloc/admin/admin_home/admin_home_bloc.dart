import 'dart:convert';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:http/http.dart' as http;
import 'package:student_attendance/models/admin/admin_home.dart';
import 'package:student_attendance/values/constant.dart' as constant;

part 'admin_home_event.dart';
part 'admin_home_state.dart';

class AdminHomeBloc extends Bloc<AdminHomeEvent, AdminHomeState> {
  AdminHomeBloc() : super(AdminHomeInitial()) {
    on<GetAdminHomeEvent>((event, emit) async {
      try {
        emit(AdminHomeLoading());
        final response = await http.get(
          Uri.parse("${constant.apiUrl}/admin/home"),
          headers: {
            HttpHeaders.acceptHeader: "application/json",
          },
        );
        if (response.statusCode == 200) {
          emit(AdminHomeSuccess(adminHome: adminHomeFromJson(response.body)));
        } else {
          emit(AdminHomeFailure(message: jsonDecode(response.body)["message"]));
        }
      } catch (e) {
        emit(AdminHomeFailure(message: e.toString()));
      }
    });
  }
}
