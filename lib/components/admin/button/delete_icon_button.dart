import 'package:flutter/material.dart';

class DeleteIB extends StatelessWidget {
  const DeleteIB({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {},
      icon: const Icon(
        Icons.delete,
        color: Colors.red,
      ),
    );
  }
}
