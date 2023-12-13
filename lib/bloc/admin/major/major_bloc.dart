import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:student_attendance/models/id_name.dart';
import 'package:student_attendance/values/constant.dart' as constant;
import 'package:http/http.dart' as http;

part 'major_event.dart';
part 'major_state.dart';

class MajorBloc extends Bloc<MajorEvent, MajorState> {
  MajorBloc() : super(MajorInitial()) {
    on<GetAllMajorEvent>((event, emit) async {
      try {
        emit(MajorLoading());
        final response = await http.get(
          Uri.parse("${constant.apiUrl}/admin/major"),
          headers: constant.apiHeaderWithToken,
        );
        if (response.statusCode == 200) {
          emit(MajorAllSuccess(majors: idNamesFromJson(response.body)));
        } else {
          emit(MajorFailure(message: jsonDecode(response.body)['message']));
        }
      } catch (e) {
        emit(MajorFailure(message: e.toString()));
      }
    });
  }
}
