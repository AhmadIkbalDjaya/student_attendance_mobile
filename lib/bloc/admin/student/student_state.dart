part of 'student_bloc.dart';

// @immutable
sealed class StudentState {}

final class StudentInitial extends StudentState {}

class StudentGetLoading extends StudentState {}

class StudentLoading extends StudentState {}

class StudentSuccess extends StudentState {}

class StudentAddSuccess extends StudentState {}

class StudentEditSuccess extends StudentState {}

class StudentDeleteSuccess extends StudentState {}

class StudentFailure extends StudentState {}

class StudentAllSuccess extends StudentState {
  final List<Student> students;
  StudentAllSuccess({required this.students});
}

class StudentDetailSuccess extends StudentState {
  final Student student;
  StudentDetailSuccess({required this.student});
}

class StudentValidationError extends StudentState {
  String message;
  StudentValidationError({required this.message});
}
