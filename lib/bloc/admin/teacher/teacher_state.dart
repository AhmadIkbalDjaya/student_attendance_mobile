part of 'teacher_bloc.dart';

// @immutable
sealed class TeacherState {}

final class TeacherInitial extends TeacherState {}

class TeacherGetLoading extends TeacherState {}

class TeacherLoading extends TeacherState {}

class TeacherSuccess extends TeacherState {}

class TeacherAddSuccess extends TeacherState {}

class TeacherEditSuccess extends TeacherState {}

class TeacherDeleteSuccess extends TeacherState {}

class TeacherFailure extends TeacherState {}

class TeacherAllSuccess extends TeacherState {
  final List<Teacher> teachers;
  TeacherAllSuccess({required this.teachers});
}

class TeacherDetailSuccess extends TeacherState {
  final Teacher teacher;
  TeacherDetailSuccess({required this.teacher});
}

class TeacherValidationError extends TeacherState {
  String message;
  TeacherValidationError({required this.message});
}
