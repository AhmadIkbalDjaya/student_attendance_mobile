import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    // SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
    Future.delayed(
      const Duration(seconds: 1),
      // () {
      //   LoginBloc loginBloc = context.read<LoginBloc>();
      //   print(loginBloc.state);
      //   if (loginBloc.state is UserSignIn) {
      //     if (Auth.role == "admin") {
      //       Navigator.of(context).pushReplacement(MaterialPageRoute(
      //         builder: (context) => const AdminHomePage(),
      //       ));
      //       // Navigator.of(context).pushReplacementNamed("/admin");
      //       // Navigator.pushReplacementNamed(context, "/admin");
      //     } else if (Auth.role == "teacher") {
      //       Navigator.of(context).pushReplacement(MaterialPageRoute(
      //         builder: (context) => const TeacherPage(),
      //       ));
      //       // Navigator.of(context).pushReplacementNamed("/teacher");
      //       // Navigator.pushReplacementNamed(context, "/teacher");
      //     }
      //   } else {
      //     Navigator.of(context).pushReplacement(MaterialPageRoute(
      //       builder: (context) => LoginPage(),
      //     ));
      //     // Navigator.pushReplacementNamed(context, "/");
      //   }
      //   // Navigator.of(context).pushReplacementNamed("/admin");
      // },
    );
  }

  // @override
  // void dispose() {
  //   SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
  //       overlays: SystemUiOverlay.values);
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset("assets/images/logo.png"),
          const SizedBox(height: 25),
          const Text(
            "Absensi Siswa MA Pompanua",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color(0xFF696CFF),
              fontSize: 32,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
