import 'package:easy_clip_2_gif/src/widgets/sidebar/components/sidebar_item.dart';
import 'package:flutter/material.dart';

import '../../../constants/text_styles.dart';
import '../../shared/column_separated.dart';

class SidebarSection extends StatelessWidget {
  const SidebarSection({
    super.key,
    required this.label,
    required this.items,
  });
  final String label;
  final List<SidebarItem> items;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: ColumnSeparated(
        spacing: 4,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label.toLowerCase(),
            style: TextStyles.small.apply(
              color: Theme.of(context).colorScheme.secondary.withOpacity(0.8),
            ),
          ),
          ColumnSeparated(
            spacing: 2,
            children: items,
          ),
        ],
      ),
    );
  }
}
