part of 'about_us_bloc.dart';

// @immutable
sealed class AboutUsEvent {}

class GetAllAboutUsEvent extends AboutUsEvent {}

class GetDetailAboutUsEvent extends AboutUsEvent {
  final int aboutUsId;
  GetDetailAboutUsEvent({required this.aboutUsId});
}

class AddAboutUsEvent extends AboutUsEvent {
  String? name;
  String? position;
  String? email;
  String? phone;
  AddAboutUsEvent({
    this.name,
    this.position,
    this.email,
    this.phone,
  }) {
    name ??= "";
    position ??= "";
    email ??= "";
    phone ??= "";
  }
}

class EditAboutUsEvent extends AboutUsEvent {
  int id;
  String? name;
  String? position;
  String? email;
  String? phone;
  EditAboutUsEvent({
    required this.id,
    this.name,
    this.position,
    this.email,
    this.phone,
  }) {
    name ??= "";
    position ??= "";
    email ??= "";
    phone ??= "";
  }
}

class DeleteAboutUsEvent extends AboutUsEvent {
  int id;
  DeleteAboutUsEvent({required this.id});
}
