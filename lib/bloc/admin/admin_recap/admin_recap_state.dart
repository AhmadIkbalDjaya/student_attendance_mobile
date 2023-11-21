part of 'admin_recap_bloc.dart';

// @immutable
sealed class AdminRecapState {}

final class AdminRecapInitial extends AdminRecapState {}

class AdminRecapLoading extends AdminRecapState {}

class AdminRecapSuccess extends AdminRecapState {
  List<AdminRecap> adminRecap;
  AdminRecapSuccess({required this.adminRecap});
}

class AdminRecapFailure extends AdminRecapState {
  String message;
  AdminRecapFailure({required this.message});
}
