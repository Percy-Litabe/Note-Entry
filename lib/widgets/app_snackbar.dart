import 'package:flutter/material.dart';

class AppSnackbar extends StatelessWidget {
  const AppSnackbar({Key? key, required this.message}) : super(key: key);

  final String message;

  @override
  Widget build(BuildContext context) {
    return SnackBar(
      content: Text(
        message,
        style: const TextStyle(
          color: Colors.amber,
          fontSize: 20,
        ),
        textAlign: TextAlign.center,
      ),
      backgroundColor: Colors.grey[900],
      elevation: 12,
      behavior: SnackBarBehavior.floating,
      padding: const EdgeInsets.only(left: 8),
      dismissDirection: DismissDirection.horizontal,
    );
  }
}
