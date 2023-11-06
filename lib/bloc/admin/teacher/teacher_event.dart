part of 'teacher_bloc.dart';

// @immutable
sealed class TeacherEvent {}

class GetAllTeacherEvent extends TeacherEvent {}

class GetDetailTeacherEvent extends TeacherEvent {
  final int teacherId;
  GetDetailTeacherEvent({required this.teacherId});
}

class AddTeacherEvent extends TeacherEvent {
  String? username;
  String? password;
  String? email;
  String? name;
  String? phone;
  String? gender;
  AddTeacherEvent({
    this.username,
    this.password,
    this.email,
    this.name,
    this.phone,
    this.gender,
  }) {
    username ??= "";
    password ??= "";
    email ??= "";
    name ??= "";
    phone ??= "";
    gender ??= "";
  }
}

class EditTeacherEvent extends TeacherEvent {
  int id;
  String? username;
  String? password;
  String? email;
  String? name;
  String? phone;
  String? gender;
  EditTeacherEvent({
    required this.id,
    this.username,
    this.password,
    this.email,
    this.name,
    this.phone,
    this.gender,
  }) {
    username ??= "";
    password ??= "";
    email ??= "";
    name ??= "";
    phone ??= "";
    gender ??= "";
  }
}

class DeleteTeacherEvent extends TeacherEvent {
  int id;
  DeleteTeacherEvent({required this.id});
}
