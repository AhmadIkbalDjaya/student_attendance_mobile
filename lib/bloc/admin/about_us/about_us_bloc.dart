import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:student_attendance/models/about_us.dart';
import 'package:student_attendance/values/constant.dart';
import 'package:http/http.dart' as http;

part 'about_us_event.dart';
part 'about_us_state.dart';

class AboutUsBloc extends Bloc<AboutUsEvent, AboutUsState> {
  AboutUsBloc() : super(AboutUsInitial()) {
    on<GetAllAboutUsEvent>((event, emit) async {
      try {
        emit(AboutUsGetLoading());
        final response = await http.get(
          Uri.parse("${ApiConfig.url}/admin/aboutUs"),
          headers: ApiConfig.headerWithToken,
        );
        if (response.statusCode == 200) {
          emit(AboutUsAllSuccess(aboutUses: aboutUsesFromJson(response.body)));
        } else {
          emit(AboutUsFailure(message: jsonDecode(response.body)["message"]));
        }
      } catch (e) {
        emit(AboutUsFailure(message: e.toString()));
      }
    });

    on<GetDetailAboutUsEvent>((event, emit) async {
      try {
        emit(AboutUsGetLoading());
        final response = await http.get(
          Uri.parse("${ApiConfig.url}/admin/aboutUs/${event.aboutUsId}"),
          headers: ApiConfig.headerWithToken,
        );
        if (response.statusCode == 200) {
          emit(AboutUsDetailSuccess(aboutUs: aboutUsFromJson(response.body)));
        } else {
          emit(AboutUsFailure(message: jsonDecode(response.body)["message"]));
        }
      } catch (e) {
        emit(AboutUsFailure(message: e.toString()));
      }
    });

    on<AddAboutUsEvent>((event, emit) async {
      try {
        emit(AboutUsLoading());
        final response = await http.post(
          Uri.parse("${ApiConfig.url}/admin/aboutUs"),
          headers: ApiConfig.headerWithToken,
          body: {
            "name": event.name,
            "position": event.position,
            "email": event.email,
            "phone": event.phone,
          },
        );
        if (response.statusCode == 200) {
          emit(AboutUsAddSuccess());
        } else {
          var message = jsonDecode(response.body)["message"];
          emit(AboutUsValidationError(message: message));
        }
      } catch (e) {
        emit(AboutUsFailure(message: e.toString()));
      }
    });

    on<EditAboutUsEvent>((event, emit) async {
      try {
        emit(AboutUsLoading());
        final response = await http.post(
          Uri.parse("${ApiConfig.url}/admin/aboutUs/${event.id}?_method=put"),
          body: {
            "name": event.name,
            "position": event.position,
            "email": event.email,
            "phone": event.phone,
          },
          headers: ApiConfig.headerWithToken,
        );
        if (response.statusCode == 200) {
          emit(AboutUsEditSuccess());
        } else {
          var message = json.decode(response.body)['message'];
          emit(AboutUsValidationError(message: message));
        }
      } catch (e) {
        emit(AboutUsFailure(message: e.toString()));
      }
    });

    on<DeleteAboutUsEvent>((event, emit) async {
      try {
        emit(AboutUsLoading());
        final response = await http.delete(
          Uri.parse("${ApiConfig.url}/admin/aboutUs/${event.id}"),
          headers: ApiConfig.headerWithToken,
        );
        if (response.statusCode == 200) {
          emit(AboutUsDeleteSuccess());
        } else {
          emit(AboutUsFailure(message: jsonDecode(response.body)["message"]));
        }
      } catch (e) {
        emit(AboutUsFailure(message: e.toString()));
      }
    });
  }
}
