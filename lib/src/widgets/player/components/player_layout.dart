import 'package:easy_clip_2_gif/src/widgets/player/components/index_arrow_btn.dart';
import 'package:easy_clip_2_gif/src/widgets/player/providers/layout_controller.dart';
import 'package:easy_clip_2_gif/src/widgets/player/providers/player_layout_controller.dart';
import 'package:easy_clip_2_gif/src/widgets/shared/column_separated.dart';
import 'package:easy_clip_2_gif/src/widgets/shared/row_separated.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'index_btn.dart';

class IndexedWidget {
  final int index;
  final Widget child;

  IndexedWidget({
    required this.index,
    required this.child,
  });
}

class PlayerLayout extends StatefulWidget {
  PlayerLayout({
    super.key,
    required List<Widget> views,
  }) : indexedViews = views
            .asMap()
            .map(
              (index, view) => MapEntry(
                index,
                IndexedWidget(
                  index: index,
                  child: view,
                ),
              ),
            )
            .values
            .toList();

  const PlayerLayout.custom({
    super.key,
    required this.indexedViews,
  });

  final List<IndexedWidget> indexedViews;

  @override
  State<PlayerLayout> createState() => _TabViewControllerState();
}

class _TabViewControllerState extends State<PlayerLayout> {
  late final ValueNotifier<int> _totalViews = ValueNotifier(
    widget.indexedViews.length,
  );

  @override
  void didUpdateWidget(oldWidget) {
    _totalViews.value = widget.indexedViews.length;
    super.didUpdateWidget(oldWidget);
  }

  Widget _getLayoutWidget({
    required Layout layout,
    required List<Widget> children,
  }) =>
      layout == Layout.tab
          ? Stack(children: children)
          : ColumnSeparated(
              spacing: 4,
              children: children,
            );

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => PlayerTabController(_totalViews),
      child: Consumer2<LayoutController, PlayerTabController>(
        builder: (context, layoutProvider, tabProvider, child) {
          return Stack(
            children: [
              _getLayoutWidget(
                layout: layoutProvider.layout,
                children: widget.indexedViews
                    .map(
                      (view) => Visibility(
                        visible: tabProvider.curIndex == view.index ||
                            layoutProvider.layout == Layout.column,
                        child: view.child,
                      ),
                    )
                    .toList(),
              ),
              Positioned(
                right: 8,
                bottom: 8,
                child: Visibility(
                  visible: widget.indexedViews.length > 1 &&
                      layoutProvider.layout == Layout.tab,
                  child: RowSeparated(
                    spacing: 4,
                    children: [
                      IndexArrowBtn(
                        onTap: tabProvider.viewPast,
                        direction: ArrowDirection.left,
                      ),
                      RowSeparated(
                        spacing: 4,
                        children: widget.indexedViews
                            .map(
                              (e) => IndexBtn(
                                isActive: e.index == tabProvider.curIndex,
                                index: e.index,
                              ),
                            )
                            .toList(),
                      ),
                      IndexArrowBtn(
                        onTap: tabProvider.viewNext,
                        direction: ArrowDirection.right,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
