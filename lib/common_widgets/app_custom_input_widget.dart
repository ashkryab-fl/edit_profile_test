import 'package:flutter/material.dart';

class AppCustomInputWidget extends StatefulWidget {
  const AppCustomInputWidget(
      {super.key,
      required this.child,
      required this.hint,
      this.isEmpty = true,
      this.padding,
      this.error,
      required this.onTap});

  final Widget child;
  final EdgeInsets? padding;
  final String hint;
  final String? error;
  final bool isEmpty;
  final VoidCallback onTap;

  @override
  State<AppCustomInputWidget> createState() => _AppCustomInputWidget();
}

class _AppCustomInputWidget extends State<AppCustomInputWidget> {

  @override
  Widget build(BuildContext context) {
    var child = Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
      child: InputDecorator(
        decoration: _getEffectiveDecoration(),
        isFocused: false,
        isEmpty: widget.isEmpty,
        textAlign: TextAlign.start,
        child: Container(color: Colors.transparent, child: widget.child),
      ),
    );

    return Padding(
      padding: widget.padding ?? const EdgeInsets.symmetric(horizontal: 10),
      child: GestureDetector(
        onTap: () {
          widget.onTap.call();
        },
        child: Stack(
          children: [
            child,
            Container(
              height: 58,
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
              decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black,
                  ),
                  borderRadius: const BorderRadius.all(Radius.circular(8))),
            ),
          ],
        ),
      ),
    );
  }

  InputDecoration _getEffectiveDecoration() {
    final ThemeData themeData = Theme.of(context);
    return InputDecoration(
            labelText: widget.hint,
            border: InputBorder.none,
            hintStyle: themeData.inputDecorationTheme.hintStyle?.copyWith(
                color: (widget.error ?? '').isNotEmpty
                    ? Theme.of(context).colorScheme.error
                    : null),
            errorText: (widget.error ?? '').isNotEmpty ? widget.error : null)
        .applyDefaults(themeData.inputDecorationTheme);
  }
}
