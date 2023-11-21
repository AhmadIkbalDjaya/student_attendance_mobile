import 'package:bloc/bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:student_attendance/models/login.dart';
import 'package:student_attendance/values/auth.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<CheckAuth>((event, emit) async {
      Login? savedLogin = await getLoginFromSharedPreferences();
      if (savedLogin != null) {
        Auth.setAuth(
          token: savedLogin.token,
          role: savedLogin.role,
          id: savedLogin.user.id,
          username: savedLogin.user.username,
          email: savedLogin.user.email,
          name: savedLogin.user.name,
          phone: savedLogin.user.phone,
          gender: savedLogin.user.gender,
        );
        emit(UserSignIn(login: savedLogin));
      } else {
        Auth.resetAuth();
        emit(UserSignOut());
      }
    });

    on<SetSignIn>((event, emit) async {
      Login? savedLogin = await getLoginFromSharedPreferences();
      if (savedLogin != null) {
        Auth.setAuth(
          token: savedLogin.token,
          role: savedLogin.role,
          id: savedLogin.user.id,
          username: savedLogin.user.username,
          email: savedLogin.user.email,
          name: savedLogin.user.name,
          phone: savedLogin.user.phone,
          gender: savedLogin.user.gender,
        );
        emit(UserSignIn(login: savedLogin));
      }
    });

    on<SetSignOut>((event, emit) {
      Auth.resetAuth();
      emit(UserSignOut());
    });
  }
  Future<Login?> getLoginFromSharedPreferences() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString("token");
    String? role = pref.getString("role");
    int? id = pref.getInt("id");
    String? username = pref.getString("username");
    String? email = pref.getString("email");
    String? name = pref.getString("name");
    String? phone = pref.getString("phone");
    String? gender = pref.getString("gender");

    if (token != null &&
        username != null &&
        email != null &&
        id != null &&
        role != null) {
      User user = User(
        id: id,
        username: username,
        email: email,
        name: name,
        phone: phone,
        gender: gender,
      );

      Login login = Login(
        token: token,
        user: user,
        role: role,
      );
      return login;
    }
    return null;
  }
}
