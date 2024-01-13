import 'package:flutter/material.dart';

enum ArrowDirection {
  left,
  right,
}

class IndexArrowBtn extends StatefulWidget {
  const IndexArrowBtn({
    super.key,
    required this.onTap,
    required this.direction,
  });
  final ArrowDirection direction;
  final void Function()? onTap;

  @override
  State<IndexArrowBtn> createState() => _IndexArrowBtnState();
}

class _IndexArrowBtnState extends State<IndexArrowBtn> {
  bool get isActive => widget.onTap != null;
  Color get iconColorDflt => Theme.of(context).textTheme.bodyMedium!.color!;
  Color get obscuredIconColor => iconColorDflt.withOpacity(0.3);
  Color get iconColor => isActive ? iconColorDflt : obscuredIconColor;

  IconData get icon => widget.direction == ArrowDirection.left
      ? Icons.chevron_left
      : Icons.chevron_right;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(999),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: widget.onTap,
          child: Padding(
            padding: const EdgeInsets.all(2),
            child: Icon(
              icon,
              size: 24,
              color: iconColor,
            ),
          ),
        ),
      ),
    );
  }
}
