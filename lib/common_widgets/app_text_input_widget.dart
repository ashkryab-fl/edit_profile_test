import 'package:flutter/material.dart';

class AppTextInputWidget extends StatelessWidget {
  const AppTextInputWidget({
    super.key,
    required this.controller,
    required this.hint,
    this.onTap,
    this.padding,
    this.error,
  });

  final EdgeInsets? padding;
  final String hint;
  final String? error;
  final TextEditingController controller;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? const EdgeInsets.symmetric(horizontal: 10),
      child: Stack(
        children: [
          Container(
            height: 58,
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
            decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black,
                ),
                borderRadius: const BorderRadius.all(Radius.circular(8))),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
            child: TextField(
              onTap: () {
                onTap?.call();
              },
              textCapitalization: TextCapitalization.words,
              textInputAction: TextInputAction.done,
              controller: controller,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  errorBorder: InputBorder.none,
                  labelText: hint,
                  errorText: (error ?? '').isNotEmpty ? error : null),
            ),
          )
        ],
      ),
    );
  }
}
