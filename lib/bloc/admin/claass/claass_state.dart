part of 'claass_bloc.dart';

// @immutable
sealed class ClaassState {}

final class ClaassInitial extends ClaassState {}

class ClaassGetLoading extends ClaassState {}

class ClaassLoading extends ClaassState {}

class ClaassSuccess extends ClaassState {}

class ClaassAddSuccess extends ClaassState {}

class ClaassEditSuccess extends ClaassState {}

class ClaassDeleteSuccess extends ClaassState {}

class ClaassFailure extends ClaassState {}

class ClaassAllSuccess extends ClaassState {
  final List<Claass> claasses;
  ClaassAllSuccess({required this.claasses});
}

class ClaassDetailSuccess extends ClaassState {
  final Claass claass;
  ClaassDetailSuccess({required this.claass});
}

class ClaassValidationError extends ClaassState {
  String message;
  ClaassValidationError({required this.message});
}

