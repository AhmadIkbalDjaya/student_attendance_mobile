import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student_attendance/bloc/auth/auth_bloc.dart';
import 'package:student_attendance/bloc/login/login_bloc.dart';
import 'package:student_attendance/components/my_snack_bar.dart';
import 'package:student_attendance/cubit/show_password_cubit.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});
  final showPassCubit = ShowPassCubit();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    LoginBloc loginBloc = context.read<LoginBloc>();

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(
          top: 25,
          bottom: 25,
          left: 50,
          right: 50,
        ),
        child: ListView(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height - 95,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Absens Siswa MA Pompanua",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFF696CFF),
                      fontSize: 32,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(
                    height: 300,
                    child: Image.asset('assets/images/logo.png'),
                  ),
                  const Text(
                    "Login",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFF696CFF),
                      fontSize: 32,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Column(
                    children: [
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.only(left: 2),
                        child: const Text(
                          "Username / NIP",
                          style: TextStyle(
                            color: Color(0xFF696CFF),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 40,
                        child: TextField(
                          controller: usernameController,
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(
                              vertical: 0,
                              horizontal: 10,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Color(0xFF696CFF),
                                width: 1,
                                style: BorderStyle.solid,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.only(left: 2),
                        child: const Text(
                          "Password",
                          style: TextStyle(
                            color: Color(0xFF696CFF),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 40,
                        child: BlocBuilder<ShowPassCubit, bool>(
                          bloc: showPassCubit,
                          builder: (context, state) {
                            return TextField(
                              controller: passwordController,
                              textInputAction: TextInputAction.done,
                              obscureText: state,
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.symmetric(
                                  vertical: 0,
                                  horizontal: 10,
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    color: Color(0xFF696CFF),
                                    width: 1,
                                    style: BorderStyle.solid,
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),

                                // suffixIcon: passwordController.text != ""
                                //     ? GestureDetector(
                                //         onTap: () {
                                //           showPassCubit.handleClick();
                                //         },
                                //         child: Icon(
                                //           state
                                //               ? Icons.visibility_off
                                //               : Icons.visibility,
                                //           color: const Color(0xFF696CFF),
                                //         ),
                                //       )
                                //     : null,
                                suffixIcon: GestureDetector(
                                  onTap: () {
                                    showPassCubit.handleClick();
                                  },
                                  child: Icon(
                                    state
                                        ? Icons.visibility_off
                                        : Icons.visibility,
                                    color: const Color(0xFF696CFF),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                  BlocConsumer<LoginBloc, LoginState>(
                    listener: (context, state) {
                      if (state is LoginFailure) {
                        showCostumSnackBar(
                          context: context,
                          message: state.message,
                          type: "danger",
                        );
                      }
                      if (state is LoginSuccess) {
                        context.read<AuthBloc>().add(SetSignIn());
                        if (state.login.role == "admin") {
                          Navigator.pushReplacementNamed(context, "/admin");
                        } else {
                          Navigator.pushReplacementNamed(context, "/teacher");
                        }
                      }
                    },
                    builder: (context, state) {
                      return OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(horizontal: 50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          side: const BorderSide(
                            width: 1,
                            color: Color(0xFF696CFF),
                          ),
                        ),
                        onPressed: () {
                          state is LoginLoading
                              ? null
                              : loginBloc.add(SignIn(
                                  username: usernameController.text,
                                  password: passwordController.text,
                                ));
                        },
                        child: state is LoginLoading
                            ? const SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: Color(0xFF696CFF),
                                ),
                              )
                            : const Text(
                                "Login",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xFF696CFF),
                                ),
                              ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
