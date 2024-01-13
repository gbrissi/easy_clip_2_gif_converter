import 'package:flutter/material.dart';

class ColumnSeparated extends StatelessWidget {
  ColumnSeparated({
    super.key,
    required List<Widget> children,
    required double spacing,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.mainAxisAlignment = MainAxisAlignment.start,
  }) : spacedChildren = _getSpacedChildren(children, spacing);
  final List<Widget> spacedChildren;
  final CrossAxisAlignment crossAxisAlignment;
  final MainAxisAlignment mainAxisAlignment;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: mainAxisAlignment,
      crossAxisAlignment: crossAxisAlignment,
      children: spacedChildren,
    );
  }
}

List<Widget> _getSpacedChildren(
  List<Widget> children,
  double spacing,
) {
  final List<Widget> spacedChildren = [];
  final SizedBox divider = SizedBox(height: spacing);

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
