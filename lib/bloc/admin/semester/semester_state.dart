part of 'semester_bloc.dart';

// @immutable
sealed class SemesterState {}

final class SemesterInitial extends SemesterState {}

class SemesterGetLoading extends SemesterState {}

class SemesterLoading extends SemesterState {}

class SemesterSuccess extends SemesterState {}

class SemesterAddSuccess extends SemesterState {}

class SemesterEditSuccess extends SemesterState {}

class SemesterDeleteSuccess extends SemesterState {}

class SemesterChangeSuccess extends SemesterState {}

class SemesterAllSuccess extends SemesterState {
  final List<Semester> semesters;
  SemesterAllSuccess({required this.semesters});
}

class SemesterDetailSuccess extends SemesterState {
  final Semester semester;
  SemesterDetailSuccess({required this.semester});
}

class SemesterValidationError extends SemesterState {
  String message;
  SemesterValidationError({required this.message});
}

class SemesterFailure extends SemesterState {}
