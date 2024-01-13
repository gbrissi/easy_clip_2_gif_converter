import 'package:flutter/material.dart';

class InfoTextButton extends StatelessWidget {
  const InfoTextButton({
    super.key,
    required this.onTap,
    required this.icon,
    required this.color,
  });
  final void Function() onTap;
  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: Material(
        color: color,
        child: InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(2),
            child: Icon(
              icon,
              size: 10,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
