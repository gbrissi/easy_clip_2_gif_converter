import 'package:flutter/material.dart';

class RowSeparated extends StatelessWidget {
  RowSeparated({
    super.key,
    required List<Widget> children,
    required double spacing,
    this.mainAxisSize = MainAxisSize.max,
    this.crossAxisAlignment = CrossAxisAlignment.center,
  }) : spacedChildren = _getSpacedChildren(children, spacing);
  final List<Widget> spacedChildren;
  final MainAxisSize mainAxisSize;
  final CrossAxisAlignment crossAxisAlignment;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: crossAxisAlignment,
      mainAxisSize: mainAxisSize,
      children: spacedChildren,
    );
  }
}

List<Widget> _getSpacedChildren(
  List<Widget> children,
  double spacing,
) {
  final List<Widget> spacedChildren = [];
  final SizedBox divider = SizedBox(width: spacing);

  for (var i = 0; i < children.length; i++) {
    spacedChildren.add(children[i]);

    if (!(i == (children.length - 1))) {
      spacedChildren.add(divider);
      continue;
    }

    break;
  }

  return spacedChildren;
}
