part of 'student_bloc.dart';

// @immutable
sealed class StudentState {}

final class StudentInitial extends StudentState {}

class StudentLoading extends StudentState {}

class StudentSuccess extends StudentState {
  final List<Student> students;
  StudentSuccess({required this.students});
}

class StudentFailure extends StudentState {}
