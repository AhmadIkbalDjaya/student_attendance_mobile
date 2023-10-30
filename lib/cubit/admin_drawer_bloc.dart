import 'package:flutter_bloc/flutter_bloc.dart';

class AdminDrawerBloc extends Cubit<int> {
  AdminDrawerBloc() : super(0);

  void setActive(int index) {
    emit(index);
  }
}
