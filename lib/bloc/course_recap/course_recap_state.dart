part of 'course_recap_bloc.dart';

// @immutable
sealed class CourseRecapState {}

final class CourseRecapInitial extends CourseRecapState {}

class CourseRecapGetLoading extends CourseRecapState {}

class CourseRecapSuccess extends CourseRecapState {
  CourseRecap courseRecap;
  CourseRecapSuccess({required this.courseRecap});
}

class CourseRecapFailure extends CourseRecapState {
  String message;
  CourseRecapFailure({this.message = ""});
}
