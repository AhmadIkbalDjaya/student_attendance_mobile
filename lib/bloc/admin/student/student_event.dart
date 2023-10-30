part of 'student_bloc.dart';

sealed class StudentEvent {}

class GetAllStudentEvent extends StudentEvent {}

class GetDetailStudentEvent extends StudentEvent {
  final int studentId;
  GetDetailStudentEvent({required this.studentId});
}

class AddStudentEvent extends StudentEvent {
  String? nis;
  String? name;
  String? gender;
  String? classId;
  BuildContext context;
  AddStudentEvent(
      {this.nis, this.name, this.gender, this.classId, required this.context}) {
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
  BuildContext context;
  EditStudentEvent({
    required this.id,
    this.nis,
    this.name,
    this.gender,
    this.classId,
    required this.context,
  }) {
    nis ??= "";
    name ??= "";
    gender ??= "";
    classId ??= "";
  }
}

class DeleteStudentEvent extends StudentEvent {
  int id;
  BuildContext context;
  DeleteStudentEvent({required this.id, required this.context});
}
