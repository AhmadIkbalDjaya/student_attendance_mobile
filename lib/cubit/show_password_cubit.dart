import 'package:flutter_bloc/flutter_bloc.dart';

class ShowPassCubit extends Cubit<bool> {
  ShowPassCubit() : super(true);
  void handleClick() {
    emit(!state);
  }
}
