import 'package:bloc/bloc.dart';
import 'package:http/http.dart' as http;
import 'package:student_attendance/values/constant.dart';
import 'package:student_attendance/models/admin/admin_recap.dart';

part 'admin_recap_event.dart';
part 'admin_recap_state.dart';

class AdminRecapBloc extends Bloc<AdminRecapEvent, AdminRecapState> {
  AdminRecapBloc() : super(AdminRecapInitial()) {
    on<GetAdminRecapEvent>((event, emit) async {
      try {
        emit(AdminRecapLoading());
        final response = await http.get(
          Uri.parse("${ApiConfig.url}/admin/recap"),
          headers: ApiConfig.headerWithToken,
        );
        if (response.statusCode == 200) {
          emit(
              AdminRecapSuccess(adminRecap: adminRecapFromJson(response.body)));
        }
      } catch (e) {
        emit(AdminRecapFailure(message: e.toString()));
      }
    });
  }
}
