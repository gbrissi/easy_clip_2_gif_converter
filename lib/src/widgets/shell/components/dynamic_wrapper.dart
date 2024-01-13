import 'package:flutter/material.dart';

class DynamicWrapper extends StatelessWidget {
  const DynamicWrapper({
    super.key,
    required this.child,
  });
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: child,
    );
  }
}
