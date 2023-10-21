import 'package:flutter/material.dart';

class PrevPageButton extends StatelessWidget {
  const PrevPageButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        Navigator.pop(context);
      },
      icon: const Icon(Icons.arrow_back),
    );
  }
}
