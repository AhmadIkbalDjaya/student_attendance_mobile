import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:http/http.dart' as http;
import 'package:student_attendance/models/admin/admin_home.dart';
import 'package:student_attendance/values/constant.dart';

part 'admin_home_event.dart';
part 'admin_home_state.dart';

class AdminHomeBloc extends Bloc<AdminHomeEvent, AdminHomeState> {
  AdminHomeBloc() : super(AdminHomeInitial()) {
    on<GetAdminHomeEvent>((event, emit) async {
      try {
        emit(AdminHomeLoading());
        final response = await http.get(
          Uri.parse("${ApiConfig.url}/admin/home"),
          headers: ApiConfig.headerWithToken,
        );
        if (response.statusCode == 200) {
          emit(AdminHomeSuccess(adminHome: adminHomeFromJson(response.body)));
        } else if (response.statusCode == 401 || response.statusCode == 403) {
          emit(InvalidToken());
        } else {
          emit(AdminHomeFailure(message: jsonDecode(response.body)["message"]));
        }
      } catch (e) {
        emit(AdminHomeFailure(message: e.toString()));
      }
    });
  }
}
