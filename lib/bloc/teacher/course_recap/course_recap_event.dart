part of 'course_recap_bloc.dart';

// @immutable
sealed class CourseRecapEvent {}

class GetCourseRecapEvent extends CourseRecapEvent {
  final int courseId;
  GetCourseRecapEvent({required this.courseId});
}
