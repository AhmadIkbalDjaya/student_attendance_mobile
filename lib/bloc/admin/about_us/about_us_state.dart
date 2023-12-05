part of 'about_us_bloc.dart';

// @immutable
sealed class AboutUsState {}

final class AboutUsInitial extends AboutUsState {}

class AboutUsGetLoading extends AboutUsState {}

class AboutUsLoading extends AboutUsState {}

class AboutUsSuccess extends AboutUsState {}

class AboutUsAddSuccess extends AboutUsState {}

class AboutUsEditSuccess extends AboutUsState {}

class AboutUsDeleteSuccess extends AboutUsState {}

class AboutUsSetPassSuccess extends AboutUsState {}

class AboutUsFailure extends AboutUsState {
  String message;
  AboutUsFailure({this.message = "error"});
}

class AboutUsAllSuccess extends AboutUsState {
  final List<AboutUs> aboutUses;
  AboutUsAllSuccess({required this.aboutUses});
}

class AboutUsDetailSuccess extends AboutUsState {
  final AboutUs aboutUs;
  AboutUsDetailSuccess({required this.aboutUs});
}

class AboutUsValidationError extends AboutUsState {
  String message;
  AboutUsValidationError({required this.message});
}