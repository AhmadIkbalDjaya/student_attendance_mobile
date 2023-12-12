part of 'major_bloc.dart';

// @immutable
sealed class MajorState {}

final class MajorInitial extends MajorState {}

class MajorLoading extends MajorState {}

class MajorAllSuccess extends MajorState {
  List<IdName> majors;
  MajorAllSuccess({required this.majors});
}

class MajorFailure extends MajorState {
  String message;
  MajorFailure({this.message = ""});
}
