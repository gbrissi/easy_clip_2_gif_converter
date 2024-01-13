import 'package:flutter/material.dart';

class IndexBtn extends StatefulWidget {
  const IndexBtn({
    super.key,
    required this.isActive,
    required this.index,
  });
  final int index;
  final bool isActive;

  @override
  State<IndexBtn> createState() => _IndexBtnState();
}

class _IndexBtnState extends State<IndexBtn> {
  ColorScheme get _colorScheme => Theme.of(context).colorScheme;
  Color get _btnColor =>
      widget.isActive ? _colorScheme.primary : _colorScheme.secondary.withOpacity(0.6);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(999),
      child: Material(
        color: _btnColor,
        child: const InkWell(
          child: Padding( 
            padding: EdgeInsets.all(10),
          ),
        ),
      ),
    );
  }
}
