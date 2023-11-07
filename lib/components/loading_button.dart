import 'package:flutter/material.dart';

class LoadingButton extends StatelessWidget {
  const LoadingButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF696CFF),
      ),
      child: const SizedBox(
          width: 20,
          height: 20,
          child: CircularProgressIndicator(color: Colors.white)),
    );
  }
}
