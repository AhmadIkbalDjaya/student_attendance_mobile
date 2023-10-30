import 'package:flutter/material.dart';

class DeleteIB extends StatelessWidget {
  const DeleteIB({
    super.key,
    this.name = "",
    this.deleteFunction = defaultFunction,
  });
  final String name;
  final Function deleteFunction;
  static void defaultFunction() {}
  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text(
                "Konfirmasi Hapus",
                textAlign: TextAlign.center,
              ),
              content: Text(
                "Yakin Ingin Menghapus $name?",
                textAlign: TextAlign.center,
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text("Tidak"),
                ),
                TextButton(
                  onPressed: () {
                    deleteFunction();
                  },
                  child: const Text("Ya"),
                ),
              ],
            );
          },
        );
      },
      icon: const Icon(
        Icons.delete,
        color: Colors.red,
      ),
    );
  }
}
