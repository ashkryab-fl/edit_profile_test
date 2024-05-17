import 'package:flutter/material.dart';

class AppTextButton extends StatelessWidget {
  const AppTextButton(
      {super.key,
      required this.text,
      required this.onPress,
      this.preventTap = false,
      this.color});

  final String text;
  final Color? color;
  final VoidCallback onPress;
  final bool preventTap;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      child: Text(
        text,
        style: TextStyle(color: color??Colors.blue,fontSize: 16),
      ),
      onPressed: () {
        if (!preventTap) {
          onPress.call();
        }
      },
    );
  }
}
