part of 'student_bloc.dart';

// @immutable
sealed class StudentState {}

final class StudentInitial extends StudentState {}

// student
class StudentLoading extends StudentState {}
class StudentFailure extends StudentState {}

class StudentSuccess extends StudentState {
  final List<Student> students;
  StudentSuccess({required this.students});
}

class StudentDetailSuccess extends StudentState {
  final Student student;
  StudentDetailSuccess({required this.student});
}
