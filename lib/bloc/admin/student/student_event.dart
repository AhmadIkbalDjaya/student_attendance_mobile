part of 'student_bloc.dart';

sealed class StudentEvent {}

class GetAllStudentEvent extends StudentEvent {
  final int claassId;
  GetAllStudentEvent({required this.claassId});
}

class GetDetailStudentEvent extends StudentEvent {
  final int studentId;
  GetDetailStudentEvent({required this.studentId});
}

class AddStudentEvent extends StudentEvent {
  String? nis;
  String? name;
  String? gender;
  String? classId;
  AddStudentEvent({
    this.nis,
    this.name,
    this.gender,
    this.classId,
  }) {
    nis ??= "";
    name ??= "";
    gender ??= "";
    classId ??= "";
  }
}

class EditStudentEvent extends StudentEvent {
  int id;
  String? nis;
  String? name;
  String? gender;
  String? classId;
  EditStudentEvent({
    required this.id,
    this.nis,
    this.name,
    this.gender,
    this.classId,
  }) {
    nis ??= "";
    name ??= "";
    gender ??= "";
    classId ??= "";
  }
}

class DeleteStudentEvent extends StudentEvent {
  int id;
  DeleteStudentEvent({required this.id});
}
