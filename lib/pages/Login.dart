import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 0, left: 50, right: 50),
        child: ListView(
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
                    "NIP",
                    style: TextStyle(
                      color: Color(0xFF696CFF),
                    ),
                  ),
                ),
                SizedBox(
                  height: 40,
                  child: TextField(
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
            const SizedBox(height: 20),
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
                  child: TextField(
                    textInputAction: TextInputAction.done,
                    obscureText: true,
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
                      suffixIcon: const Icon(
                        Icons.remove_red_eye,
                        color: Color(0xFF696CFF),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            OutlinedButton(
              style: OutlinedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                side: const BorderSide(
                  width: 1,
                  color: Color(0xFF696CFF),
                ),
              ),
              onPressed: () {},
              child: const Text(
                "Login",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF696CFF),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
